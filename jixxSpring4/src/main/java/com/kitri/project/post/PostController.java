package com.kitri.project.post;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kitri.project.repository.MailHandler;

import net.coobird.thumbnailator.Thumbnails;
import vo.Channel;
import vo.Member;
import vo.Post;
import vo.Repository;
import vo.UserMeta;

@Controller
public class PostController implements ApplicationContextAware {
	@Resource(name = "postService")
	private Service service;
	@Inject
	private JavaMailSender mailSender;
	private WebApplicationContext context = null;

	@RequestMapping(value = "/post/write.do")
	public String write(Post post, HttpServletRequest req, @RequestParam(value = "cn") int cn, RedirectAttributes rda) {
		rda.addAttribute("cn", cn);
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		int rep_id = (int) session.getAttribute("rep_id");
		MultipartFile file = post.getFile();
		if (file.getOriginalFilename() != "") {
			int pos = file.getOriginalFilename().lastIndexOf(".");
			String ext = file.getOriginalFilename().substring(pos);
			String name = file.getOriginalFilename().substring(0, pos);
			String path = "D:\\files\\" + name + UUID.randomUUID().toString() + ext;
			String thumbnailPath = "D:\\git\\jixxSpring4\\src\\main\\webapp\\resources\\img\\" + name
					+ UUID.randomUUID().toString();
			File f = new File(path);
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			post.setFile_original(path);
			if (ext.equals(".jpg")) {
				File thumbnail = new File(thumbnailPath);
				if (f.exists()) {
					thumbnail.getParentFile().mkdirs();
					try {
						Thumbnails.of(f).size(190, 150).outputFormat("png").toFile(thumbnail);
						post.setFile_thumbnail(thumbnail.getName() + ".png");
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} else {
			post.setFile_original("x");
		}
		String nickname = service.getNickname(id, rep_id);
		ArrayList<Integer> idlist = service.getMemberId(cn, id);
		ArrayList<String> emaillist = service.getMemberEmail(idlist);
		try {
			MailHandler sendMail = new MailHandler(mailSender);
			Repository r = service.getRepository(rep_id);
			for (String str : emaillist) {
				sendMail.setSubject(r.getRep_name() + "저장소의 새 글 알림");
				sendMail.setText(new StringBuffer().append("<h1>" + r.getRep_name() + "저장소의 새 글 알림</h1>")
						.append("<a href='localhost:8080/project/postalarm.do?cn=" + cn + "&rep_id=" + rep_id)
						.append("'target='_blenk'>글 확인</a>").toString());
				sendMail.setFrom("gusdn4973@gmail.com", "CETACEA");
				sendMail.setTo(str);
				sendMail.send();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		post.setChannel_id(cn);
		post.setNickname(nickname);
		post.setUser_id(Integer.parseInt(session.getAttribute("id").toString()));
		service.write(post);
		return "redirect:/post/list.do?page=1";
	}

	@RequestMapping(value = "postalarm.do")
	public String postalarm(@RequestParam("cn") int cn, @RequestParam("rep_id") int rep_id, RedirectAttributes rda,
			HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		try {
			int id = (int) session.getAttribute("id");
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/member/login";
		}
		session.setAttribute("rep_id", rep_id);
		rda.addAttribute("cn", cn);
		return "redirect:/post/list.do?page=1";

	}

	@RequestMapping(value = "/post/list.do", method = RequestMethod.GET)
	public ModelAndView list(HttpServletRequest req, @RequestParam(value = "page") int page,
			@RequestParam(value = "cn") int cn) {
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		int rep_id = (int) session.getAttribute("rep_id");
		ArrayList<String> nicknamelist = service.getNicknameList(rep_id);
		ArrayList<Channel> chlist = service.getChList(rep_id);
		ArrayList<Post> list = service.show(page, cn);
		ArrayList<Post> repost = service.getRepost(list);
		postListChange(list);
		Member m2 = service.getMember(id);
		ArrayList<String> repnamelist = service.getRepNameListById(id);
		String user_name = m2.getName();
		Repository r = service.getRepository(rep_id);
		ModelAndView mav = new ModelAndView("/template/main");
		Channel ch = service.getChannel(cn);
		int a = chlist.size();
		int[] chidlist = new int[a];
		for (int i = 0; i < chlist.size(); i++) {
			chidlist[i] = chlist.get(i).getCh_id();
			System.out.println("chidlist:" + chidlist[i]);
		}		
		ArrayList<Integer> alarmtypelist = service.getAlarmType(id, rep_id, chidlist);
		for (int i = 0; i < alarmtypelist.size(); i++) {
			System.out.println("alarmtypelist:"+alarmtypelist);			
		}
		System.out.println("alarasd22222:"+alarmtypelist);
		System.out.println("chid:" + ch.getCh_id());
		System.out.println(repost.size());
		mav.addObject("alarmtypelist",alarmtypelist);
		mav.addObject("repost", repost);
		int adminlevel = service.getUserAdminLevel(id, rep_id);
		mav.addObject("adminlevel", adminlevel);
		mav.addObject("rep_list", repnamelist);
		mav.addObject("rep_name", r.getRep_name());
		mav.addObject("user_name", user_name);
		mav.addObject("ch", ch);
		mav.addObject("id", id);
		mav.addObject("rep_id", rep_id);
		mav.addObject("ch_list", chlist);
		mav.addObject("nicknamelist", nicknamelist);
		mav.addObject("list", list);
		System.out.println(list);
		return mav;
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.context = (WebApplicationContext) applicationContext;
	}

	@RequestMapping(value = "/post/download.do", method = RequestMethod.GET)
	public ModelAndView fileDown(@RequestParam("fileName") String fileName) {
		String fullPath = "D:\\files\\" + fileName;
		File downloadFile = new File(fullPath);
		return new ModelAndView("download", "downloadFile", downloadFile);
	}

	@RequestMapping(value = "/post/delete.do")
	public String delete(@RequestParam("post_id") int post_id, @RequestParam(value = "cn") int cn,
			RedirectAttributes rda) {
		service.delete(post_id);
		rda.addAttribute("cn", cn);
		return "redirect:/post/list.do?page=1";
	}

	@RequestMapping(value = "searchboard.do")
	public ModelAndView searchBoard(HttpServletResponse res, HttpServletRequest req,
			@RequestParam(value = "search") String search) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		int rep_id = (int) session.getAttribute("rep_id");
		int cn = service.getFirstChannelId(rep_id);
		int page = 1;
		ArrayList<String> nicknamelist = service.getNicknameList(rep_id);
		ArrayList<Channel> chlist = service.getChList(rep_id);
		
		ArrayList<Post> list = service.getSearchBoard(page, rep_id, search);	
		ArrayList<Post> repost = null;
		if (list.isEmpty()) {
			mav.setViewName("redirect:/post/list.do?page=1&cn="+cn); 
			/*res.setContentType("text/html; charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println("<script>alert('일치하는 항목이 없습니다'); </script>");
			out.flush();*/
		} else {
			mav.setViewName("template/main"); 
			repost = service.getRepost(list);
			postListChange(list);
		}
		Member m2 = service.getMember(id);
		String user_name = m2.getName();
		Repository r = service.getRepository(rep_id);
		Channel ch = service.getChannel(cn);
		System.out.println("chid:" + ch.getCh_id());
		mav.addObject("repost", repost);
		mav.addObject("rep_name", r.getRep_name());
		mav.addObject("user_name", user_name);
		mav.addObject("ch", ch);
		mav.addObject("id", id);
		mav.addObject("rep_id", rep_id);
		mav.addObject("ch_list", chlist);
		mav.addObject("nicknamelist", nicknamelist);
		mav.addObject("list", list);
		return mav;
	}

	@RequestMapping(value = "/post/ajax.do", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public @ResponseBody String ajax(@RequestParam(value = "page") int page, @RequestParam(value = "cn") int cn) {
		ArrayList<Post> list = service.showMore(page, cn);
		ArrayList<Post> repost = service.getRepost(list);
		postListChange(list);
		Map<String, ArrayList<Post>> map = new HashMap<String, ArrayList<Post>>();
		map.put("list", list);
		map.put("repost", repost);
        String str = "";
        ObjectMapper mapper = new ObjectMapper();
        try {
            str = mapper.writeValueAsString(map);
            System.out.println(str);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return str;
	}

	@RequestMapping(value = "/post/searchAjax.do", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public @ResponseBody String searchAjax(@RequestParam(value = "page") int page,
			@RequestParam(value = "rep_id") int rep_id, @RequestParam(value = "search") String search) {
		ArrayList<Post> list = service.getSearchBoardMore(page, rep_id, search);
		ArrayList<Post> repost = service.getRepost(list);
		postListChange(list);
		Map<String, ArrayList<Post>> map = new HashMap<String, ArrayList<Post>>();
		map.put("list", list);
		map.put("repost", repost);
		 String str = "";
	        ObjectMapper mapper = new ObjectMapper();
	        try {
	            str = mapper.writeValueAsString(map);
	            System.out.println(str);
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
	        return str;
	}

	@RequestMapping(value = "/post/update.do", method = RequestMethod.GET)
	public void update(@RequestParam(value = "content") String content, @RequestParam(value = "post_id") int post_id) {
		service.change(content, post_id);
	}
	
	@RequestMapping(value="/post/repost.do", method = RequestMethod.POST)
	public @ResponseBody String repost(HttpServletRequest req, Post post) {
		HttpSession session = req.getSession(false);
		int user_id = (int) session.getAttribute("id");
		int rep_id = (int) session.getAttribute("rep_id");
		String nickName = service.getNickname(user_id, rep_id);
		post.setUser_id(user_id);
		post.setNickname(nickName);
		service.repostWrite(post);
		int rePost = service.getRepostID(user_id);
		String str = "{\"post_id\":\""+rePost+"\",\"nickName\":\""+nickName+"\"}";
		return str;
	}
	

	void postListChange(ArrayList<Post> list) {
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getPost_status() == 0) {
				list.get(i).setFile_original("x");
				list.get(i).setContent("삭제된 글입니다.");
				list.get(i).setNickname("삭제된 글입니다.");
				list.get(i).setFile_thumbnail("x");
			} else if (list.get(i).getFile_original() != null && !list.get(i).getFile_original().equals("x")) {
				String str = list.get(i).getFile_original();
				String name = str.substring(0, str.length() - 40);
				String realName = name.substring(9);
				String uuidName = str.substring(9);
				int pos = str.lastIndexOf(".");
				String ext = str.substring(pos);
				list.get(i).setFileName(realName + ext);
				list.get(i).setFile_original(uuidName);
			}
		}
	}
}