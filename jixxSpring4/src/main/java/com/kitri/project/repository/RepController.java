package com.kitri.project.repository;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vo.Channel;
import vo.Member;
import vo.Repository;
import vo.UserMeta;
import vo.UserMeta2;

@Controller
public class RepController {
	@Resource(name = "repService")
	private Service service;
	@Inject
	private JavaMailSender mailSender;

	public void setService(Service service) {
		this.service = service;
	}

	// create workspace할때 url중복검사
	@RequestMapping(value = "repository/urlCheck.do")
	public ModelAndView urlCheck(HttpServletRequest req, @RequestParam(value = "url") String url) {
		System.out.println(url);
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("workspace/urlcheck");
		String result = "";
		Repository r = service.selectRepByUrl(url);
		if (r == null) {
			result = "사용가능";
			session.setAttribute("urlCheck", true);
		} else {
			result = "사용불가";
			session.setAttribute("urlCheck", false);
		}
		System.out.println(session.getAttribute("urlCheck"));
		mav.addObject("result", result);
		return mav;
	}

	// 저장소테이블에 행추가, 채널행추가, userMeta테이블 행추가, 기본게시글작성-->저장소만드는기능
	@RequestMapping(value = "createrep.do")
	public ModelAndView createRep(HttpServletRequest req, @RequestParam(value = "nickname") String nickname,
			Repository r) throws Exception {
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		session.setAttribute("nickname", nickname);
		ModelAndView mav = new ModelAndView("workspace/teaminvite");
		service.addRep(r);
		Repository r2 = service.getRepository(r);
		service.createCh(r2);
		int rep_id1 = r2.getRep_id();
		session.setAttribute("rep_id", rep_id1);
		Channel ch = service.getChId(r2);
		int chid1 = ch.getCh_id();
		service.createUserMeta(id, rep_id1, chid1);
		service.addBoard(nickname, id, chid1);
		service.setUserMeta2Create(id, rep_id1, nickname);
		mav.addObject("r", r2);
		return mav;
	}

	// 로그인 이후에 자신의 workspace로 이동
	@RequestMapping(value = "gomain.do")
	public String goMain(RedirectAttributes rda, HttpServletRequest req, @RequestParam(value = "rep_id") int rep_id,
			Member m) {
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		session.setAttribute("rep_id", rep_id);
		String nickname = service.getNickname(id, rep_id);
		session.setAttribute("nickname", nickname);
		Channel ch = service.getChannel(rep_id);
		int cn = 0;
		if (ch != null) {
			cn = ch.getCh_id();
		}
		rda.addAttribute("cn", cn);
		service.getUserAdminLevel(id, rep_id);
		return "redirect:/post/list.do?page=1";
	}

	// 저장소에 회원초대하는기능
	@RequestMapping(value = "sendinvite.do")
	public String emailAuth(RedirectAttributes rda, HttpServletRequest req, String[] address,
			@RequestParam(value = "rep_name") String rep_name, @RequestParam(value = "invitest") String invitest)
			throws MessagingException, UnsupportedEncodingException, Exception {
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		Member user = service.getMember(id);
		String user_name = user.getName();
		int rep_id = 0;
		System.out.println("rep_name:" + rep_name);
		if (invitest.equals("0")) {
			rep_id = service.getRepIdByRepNameUserMeta(rep_name);
			System.out.println("rep_name:" + rep_name);
		} else {
			rep_id = (int) session.getAttribute("rep_id");
		}
		MailHandler sendMail = new MailHandler(mailSender);
		for (String str : address) {
			sendMail.setSubject(user_name + "님의 CETACEA저장소 초대");
			sendMail.setText(
			
			new StringBuffer()
		/*	.append("<h1>" + user_name + "님의 CETACEA저장소 초대</h1>")
			.append("<a href='localhost:8080/project/invitesignup.do?rep_name=" + rep_name + "&rep_id=" + rep_id)
			.append("'target='_blenk'>초대 수락</a>").toString());*/
			
			.append("<div text='#c6d4df' style='font-family:Helvetica,Arial,sans-serif;font-size:14px;color:#c6d4df;text-align:center;'><table style='width:538px;background-color:#393836' align='center' cellspacing='0' cellpadding='0'><tbody><tr><td style='height:65px;background-color:#171a21;border-bottom:1px solid #4d4b48;padding:0px'><h2 style='text-align: center;color: #fff;' height='65' >FILE CETACEA</h2></td></tr><tr><td bgcolor='#17212e'><table width='500' border='0' align='center' cellpadding='0' cellspacing='0' style='padding-left:5px;padding-right:5px;padding-bottom:10px'><tbody><tr bgcolor='#17212e'><td style='padding-top:32px;padding-bottom:16px'>")
			.append("<span style='font-size:24px;color:#66c0f4;font-family:Arial,Helvetica,sans-serif;font-weight:bold'>"+user_name+"님의 CETACEA저장소 초대</span></td></tr>")
			.append("<tr bgcolor='#121a25'><td style='padding:20px;font-size:12px;line-height:17px;color:#c6d4df;font-family:Arial,Helvetica,sans-serif'><p>"
					+ "<a style='color:#c6d4df' href='localhost:8080/project/invitesignup.do?rep_name=" + rep_name + "&rep_id=" + rep_id+"' target='_blank'>초대 수락</a></p></td></tr></tbody></table></td></tr></tbody></table></div>").toString());
			sendMail.setFrom("gusdn4973@gmail.com", "CETACEA");
			sendMail.setTo(str);
			sendMail.send();
		}
		Channel ch = service.getChannel(rep_id);
		int cn = 0;
		if (ch != null) {
			cn = ch.getCh_id();
		}
		rda.addAttribute("cn", cn);
		return "redirect:/post/list.do?page=1";
	}

	// 저장소생성상황이아닌상황에서 회원초대기능
	@RequestMapping(value = "moreteam.do")
	public ModelAndView moreTeam(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		int rep_id = (int) session.getAttribute("rep_id");
		Member user = service.getMember(id);
		String user_name = user.getName();
		/* String rep_name = service.getRepNameById(id); */
		ModelAndView mav = new ModelAndView("workspace/moreteammate");
		mav.addObject("id", id);
		mav.addObject("user_name", user_name);

		Repository r2 = service.getRepository(rep_id);
		mav.addObject("r", r2);
		mav.addObject("rep_id", rep_id);
		return mav;
	}

	// 초대한메일의 링크를 클릭하면 회원가입 화면으로 이동
	@RequestMapping(value = "invitesignup.do")
	public ModelAndView inviteSignup(HttpServletRequest req, @RequestParam(value = "rep_name") String rep_name,
			@RequestParam(value = "rep_id") int rep_id) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession(false);
		if (session.getAttribute("id") == null) {
			mav.setViewName("member/invitesignup");
		} else {
			mav.setViewName("member/nickname");
		}
		mav.addObject("rep_name", rep_name);
		mav.addObject("rep_id", rep_id);
		return mav;
	}
	
	@RequestMapping(value = "loginrep.do")
	public ModelAndView loginrep(HttpServletRequest req, @RequestParam(value = "rep_name") String rep_name,
			@RequestParam(value = "rep_id")int rep_id){
		ModelAndView mav = new ModelAndView("member/nickname");
//		HttpSession session = req.getSession();
		mav.addObject("rep_name", rep_name);
		mav.addObject("rep_id", rep_id);
		return mav;
	}
	
	@RequestMapping(value = "sessionokinviterep")
	public String sessionOkInviteRep(HttpServletRequest req, RedirectAttributes rda, @RequestParam(value="rep_id") int rep_id,
				@RequestParam(value="nickname")String nickname) {
		HttpSession session = req.getSession(false);
		int id = (int)session.getAttribute("id");
		session.setAttribute("rep_id", rep_id);
		ArrayList<Integer> chlist = service.getChIdList(rep_id);
		for (int i = 0; i < chlist.size(); i++) {
			int ch_id = chlist.get(i);
			try {
				service.createUserMetaInvite(id, rep_id, ch_id);
				service.addBoard(nickname, id, ch_id);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		service.setUserMeta2Invite(id, rep_id, nickname);
		Channel ch = service.getChannel(rep_id);
		int cn = 0;
		if (ch != null) {
			cn = ch.getCh_id();
		}
		rda.addAttribute("cn", cn);
		return "redirect:/post/list.do?page=1";
	}

	// 초대받은 사람이 회원가입하고, 기존의 session지우고 바로 로그인하고 저장소로이동
	@RequestMapping(value = "inviteinsert.do")
	public String add(RedirectAttributes rda, @RequestParam(value = "rep_name") String rep_name,
			@RequestParam(value = "rep_id") int rep_id, @RequestParam(value = "email") String email,
			@RequestParam(value = "pwd") String pwd, @RequestParam(value = "name") String name, HttpServletRequest req,
			@RequestParam(value = "nickname") String nickname, Member m) throws Exception {
		HttpSession session = req.getSession(false);
		session.setAttribute("nickname", nickname);
		service.addMember(email, pwd, name);
		Member m2 = service.getMember(email);
		session.invalidate();
		session = req.getSession();
		session.setAttribute("id", m2.getId());
		session.setAttribute("email", m2.getEmail());
		int id = m2.getId();
		ArrayList<Integer> chlist = service.getChIdList(rep_id);
		for (int i = 0; i < chlist.size(); i++) {
			int ch_id = chlist.get(i);
			try {
				service.createUserMetaInvite(id, rep_id, ch_id);
				service.addBoard(nickname, id, ch_id);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		service.setUserMeta2Invite(id, rep_id, nickname);
		session.setAttribute("rep_id", rep_id);
		Channel ch = service.getChannel(rep_id);
		int cn = 0;
		if (ch != null) {
			cn = ch.getCh_id();
		}
		rda.addAttribute("cn", cn);
		return "redirect:/post/list.do?page=1";
	}

	@RequestMapping(value = "addchannelform.do")
	public ModelAndView createChannelForm(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("workspace/createchannel");
		HttpSession session = req.getSession(false);
		int rep_id = (int) session.getAttribute("rep_id");
		ArrayList<Integer> userlist = service.getUserList(rep_id);
		ArrayList<String> nicknamelist = service.getUserNickNameList(rep_id, userlist);
		mav.addObject("nicknamelist", nicknamelist);
		return mav;
	}

	@RequestMapping(value = "addchannel.do")
	public String createChannel(RedirectAttributes rda, HttpServletRequest req, Repository r,
			@RequestParam(value = "chtitle") String chtitle, String[] nickname) throws Exception {
		HttpSession session = req.getSession(false);
		int rep_id = (int) session.getAttribute("rep_id");
		service.createCh(chtitle, rep_id);
		Channel ch = service.getMaxChannel(rep_id);
		int chid = ch.getCh_id();
		ArrayList<Integer> useridlist = null;
		if (nickname == null) {
			useridlist = service.getUserList(rep_id);
		} else {
			useridlist = service.getUserIdList(rep_id, nickname);
		}
		for (int i = 0; i < useridlist.size(); i++) {
			int user_id = useridlist.get(i);
			service.createUserMetaCreateChannel1(user_id, rep_id, chid);
		}
		return "redirect:/post/list.do?page=1&cn="+chid;
	}

	@RequestMapping(value = "findworkspaceform.do")
	public ModelAndView findWorkspace(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("workspace/findworkspaceform");		
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		String email = (String) session.getAttribute("email");
		Member m = service.getMemberByEmail(email);
		ArrayList<String> repnamelist = service.getRepNameListById(id);
		mav.addObject("rep_list", repnamelist);
		mav.addObject("user_name", m.getName());
		mav.addObject("id", id);
		mav.addObject("email", email);
		mav.addObject("m", m);
		return mav;
	}

	@RequestMapping(value = "findworkspace.do")
	public ModelAndView joinws(@RequestParam(value = "search") String search) {
		ModelAndView mav = new ModelAndView("workspace/findworkspaceresult");
		ArrayList<Integer> repidlist = null;
		ArrayList<String> repnamelist = null;
		ArrayList<String> usernamelist = null;
		String errorresult = null;
		try {
			repidlist = service.getRepIdList(search);
			repnamelist = service.getRepNameListById(search);
			usernamelist = service.getUserNameListByRepId(repidlist);
			errorresult = null;
		} catch (Exception e) {
			e.printStackTrace();
			repidlist = null;
			repnamelist = null;
			usernamelist = null;
			errorresult = "검색결과가없습니다";
		}
		mav.addObject("errorresult", errorresult);
		mav.addObject("repnamelist", repnamelist);
		mav.addObject("usernamelist", usernamelist);
		mav.addObject("repidlist", repidlist);
		return mav;
	}

	@RequestMapping(value = "repadminform.do")
	public ModelAndView repadminform(HttpServletRequest req, @RequestParam(value = "adminlevel") int adminlevel) {
		ModelAndView mav = new ModelAndView("workspace/repadminform");
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		int rep_id = (int) session.getAttribute("rep_id");
		ArrayList<Channel> chlist = service.getChList(rep_id);
		ArrayList<UserMeta2> um2list = service.getUserMeta2List(rep_id);
		Repository r = service.getRepository(rep_id);
		Member m = service.getMemberAll(id);
		Member m2 = service.getMember(id);
		ArrayList<String> repnamelist = service.getRepNameListById(id);
		System.out.println("email" + m.getEmail());
		mav.addObject("id", id);
		mav.addObject("rep_id", rep_id);
		mav.addObject("rep_name", r.getRep_name());
		mav.addObject("user_name", m2.getName());
		mav.addObject("rep_list", repnamelist);
		mav.addObject("chlist", chlist);
		mav.addObject("um2list", um2list);
		mav.addObject("adminlevel", adminlevel);
		mav.addObject("r", r);
		mav.addObject("m", m);
		return mav;
	}

	@RequestMapping(value = "deletech.do")
	public String deleteCh(RedirectAttributes rda, HttpServletRequest req, @RequestParam(value = "ch_id") int ch_id) {
		HttpSession session = req.getSession(false);
		int rep_id = (int) session.getAttribute("rep_id");
		service.deleteChannel(ch_id);
		Channel ch = service.getChannel(rep_id);
		int cn = 0;
		if (ch != null) {
			 ch.getCh_id();
		}
		rda.addAttribute("cn", cn);			
		return "redirect:/post/list.do?page=1";
	}

	@RequestMapping(value = "repout.do")
	public String repOut(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		int rep_id = (int) session.getAttribute("rep_id");
		int id = (int) session.getAttribute("id");
		service.deleteUserMeta(id, rep_id);
		service.deleteUserMeta2(id, rep_id);
		session.removeAttribute("rep_id");
		session.removeAttribute("nickname");

		return "redirect:/index.do";
	}

	@RequestMapping(value = "changeadminlevel.do")
	public String changeAdminLevel(RedirectAttributes rda, HttpServletRequest req, UserMeta2 um2) {
		service.changeAdminLevel(um2);
		HttpSession session = req.getSession(false);
		int rep_id = (int) session.getAttribute("rep_id");
		Channel ch = service.getChannel(rep_id);
		int cn = ch.getCh_id();
		rda.addAttribute("cn", cn);
		return "redirect:/post/list.do?page=1";

	}

	@RequestMapping(value = "alarmcheck.do")
	public String alarmCheck(HttpServletRequest req, @RequestParam(value = "alarm_type") int alarm_type,
			@RequestParam(value = "chid") int chid) {
		HttpSession session = req.getSession(false);
		System.out.println("chid:chid:" + chid);
		int id = (int) session.getAttribute("id");
		int rep_id = (int) session.getAttribute("rep_id");
		System.out.println("alarmtype:" + alarm_type + ";;chid:" + chid + ";;id,repid:" + id + rep_id);
		service.alarmCheck(id, chid, rep_id, alarm_type);

		return null;

	}

	@RequestMapping(value = "alarmuncheck.do")
	public String alarmUnCheck(HttpServletRequest req, @RequestParam(value = "alarm_type") int alarm_type,
			@RequestParam(value = "chid") int chid) {
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		int rep_id = (int) session.getAttribute("rep_id");
		service.alarmUnCheck(id, chid, rep_id, alarm_type);

		return null;
	}

	@RequestMapping(value = "teaminvite.do")
	public String teamInvite() {
		return "workspace/teaminvite";
	}

	@RequestMapping(value = "wrokspaceurl.do")
	public String workspaceUrl() {
		return "workspace/workspaceurl";
	}

}
