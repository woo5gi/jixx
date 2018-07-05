package com.kitri.project.repository;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import vo.Channel;
import vo.Member;
import vo.Repository;
import vo.UserMeta;

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
		Channel ch = service.getChId(r2);
		int chid1 = ch.getCh_id();
		service.createUserMeta(id, rep_id1, chid1);
		service.addBoard(nickname, id, chid1);
		int rep_id2 = r2.getRep_id();
		service.setUserMeta2Create(id, rep_id2, nickname);
		mav.addObject("r", r2);
		return mav;
	}

	// 로그인 이후에 자신의 workspace로 이동
	@RequestMapping(value = "gomain.do")
	public ModelAndView goMain(HttpServletRequest req, @RequestParam(value = "rep_id") int rep_id, Member m) {
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		session.setAttribute("rep_id", rep_id);
		String nickname = service.getNickname(id, rep_id);
		session.setAttribute("nickname", nickname);
		ModelAndView mav = new ModelAndView("template/main");
		// 채널리스트
		ArrayList<Channel> chlist = service.getChList(rep_id);
		// 저장소에참여한사람리스트
		ArrayList<Integer> userlist = service.getUserList(rep_id);
		ArrayList<String> usernamelist = service.getUserNameList(userlist);
		ArrayList<String> nicknamelist = service.getNicknameList(rep_id);
		System.out.println("nicknamelist:" + nicknamelist);
		System.out.println("chlist:" + chlist + ";;userlist:" + userlist + ";;usernamelist:" + usernamelist);
		String email = (String) session.getAttribute("email");
		ArrayList<String> repnamelist = service.getRepNameListById(id);
		Member m2 = service.getMember(id);
		String user_name = m2.getName();
		Repository r = service.getRepository(rep_id);
		Channel ch = service.getChannel(rep_id);	
		ArrayList<UserMeta> umlist = service.getUserMeatList(id,rep_id);
		int adminlevel = service.getUserAdminLevel(id,rep_id);
		mav.addObject("adminlevel",adminlevel);		
		mav.addObject("nicknamelist", nicknamelist);
		mav.addObject("ch", ch);
		mav.addObject("rep_name", r.getRep_name());
		mav.addObject("user_name", user_name);
		mav.addObject("email", email);
		mav.addObject("rep_list", repnamelist);
		mav.addObject("id", id);
		mav.addObject("rep_id", rep_id);
		mav.addObject("ch_list", chlist);
		mav.addObject("user_list", usernamelist);
		return mav;
	}

	// 저장소에 회원초대하는기능
	@RequestMapping(value = "sendinvite.do")
	public ModelAndView emailAuth(HttpServletRequest req, String[] address, HttpServletResponse res,
			@RequestParam(value = "rep_name") String rep_name, @RequestParam(value = "invitest") String invitest)
			throws MessagingException, UnsupportedEncodingException, Exception {
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		ModelAndView mav = new ModelAndView("template/main");
		Member user = service.getMember(id);
		String user_name = user.getName();
		int rep_id = 0;
		System.out.println("rep_name:"+rep_name);
		if (invitest.equals("0")) {
			rep_id = service.getRepIdByRepNameUserMeta(rep_name);
			System.out.println("rep_name:"+rep_name);
		} else {
			rep_id = (int) session.getAttribute("rep_id");
		}
		MailHandler sendMail = new MailHandler(mailSender);
		for (String str : address) {
			sendMail.setSubject(user_name + "님의 CETACEA저장소 초대");
			sendMail.setText(new StringBuffer().append("<h1>" + user_name + "님의 CETACEA저장소 초대</h1>").append(
					"<a href='localhost:8080/project/invitesignup.do?rep_name=" + rep_name + "&rep_id=" + rep_id)
					.append("'target='_blenk'>초대 수락</a>").toString());
			sendMail.setFrom("gusdn4973@gmail.com", "CETACEA");
			sendMail.setTo(str);
			sendMail.send();
		}
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		out.println("<script>alert('친구초대완료'); </script>");
		out.flush();
		// 채널리스트
		ArrayList<Channel> chlist = service.getChList(rep_id);
		// 저장소에참여한사람리스트
		ArrayList<Integer> userlist = service.getUserList(rep_id);
		ArrayList<String> usernamelist = service.getUserNameList(userlist);
		ArrayList<String> nicknamelist = service.getNicknameList(rep_id);
		ArrayList<String> repnamelist = service.getRepNameListById(id);
		Repository r = service.getRepository(rep_id);
		Channel ch = service.getChannel(rep_id);
		mav.addObject("ch", ch);
		mav.addObject("rep_name", r.getRep_name());
		mav.addObject("user_name", user_name);
		mav.addObject("id", id);
		mav.addObject("rep_id", rep_id);
		mav.addObject("ch_list", chlist);
		mav.addObject("user_list", usernamelist);
		mav.addObject("nicknamelist", nicknamelist);
		mav.addObject("rep_list", repnamelist);
		return mav;
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
		ModelAndView mav = new ModelAndView("member/invitesignup");
		mav.addObject("rep_name", rep_name);
		mav.addObject("rep_id", rep_id);
		return mav;
	}

	// 초대받은 사람이 회원가입하고, 기존의 session지우고 바로 로그인하고 저장소로이동
	@RequestMapping(value = "inviteinsert.do")
	public ModelAndView add(HttpServletResponse res, @RequestParam(value = "rep_name") String rep_name,
			@RequestParam(value = "rep_id") int rep_id, @RequestParam(value = "email") String email,
			@RequestParam(value = "pwd") String pwd, @RequestParam(value = "name") String name, HttpServletRequest req,
			@RequestParam(value = "nickname") String nickname, Member m) throws Exception {
		ModelAndView mav = new ModelAndView("template/main");
		HttpSession session = req.getSession(false);
		session.setAttribute("nickname", nickname);
		service.addMember(email, pwd, name);
		Member m2 = service.getMember(email);
		session.invalidate();
		session = req.getSession();
		session.setAttribute("id", m2.getId());
		session.setAttribute("email", m2.getEmail());
		System.out.println("email:" + m2.getEmail());
		int id = m2.getId();
		ArrayList<Integer> chlist = service.getChIdList(rep_id);
		for (int i = 0; i < chlist.size(); i++) {
			int ch_id = chlist.get(i);
			System.out.println(ch_id);
			try {
				service.createUserMetaInvite(id, rep_id, ch_id);
				service.addBoard(nickname, id, ch_id);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		service.setUserMeta2Invite(id, rep_id, nickname);
		session.setAttribute("rep_id", rep_id);
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		out.println("<script>alert('회원가입을 축하합니다'); </script>");
		out.flush();
		int rep_id2 = (int) session.getAttribute("rep_id");

		// 채널리스트
		ArrayList<Channel> chlist1 = service.getChList(rep_id2);
		// 저장소에참여한사람리스트
		ArrayList<Integer> userlist = service.getUserList(rep_id);
		ArrayList<String> usernamelist = service.getUserNameList(userlist);
		ArrayList<String> nicknamelist = service.getNicknameList(rep_id);
		ArrayList<String> repnamelist = service.getRepNameListById(id);
		String user_name = m2.getName();
		Repository r = service.getRepository(rep_id);
		Channel ch = service.getChannel(rep_id);
		mav.addObject("rep_name", r.getRep_name());
		mav.addObject("user_name", user_name);
		mav.addObject("id", id);
		mav.addObject("rep_id", rep_id);
		mav.addObject("ch_list", chlist1);
		mav.addObject("user_list", usernamelist);
		mav.addObject("nicknamelist", nicknamelist);
		mav.addObject("rep_list", repnamelist);
		mav.addObject("ch", ch);
		return mav;
	}

	@RequestMapping(value = "addchannelform.do")
	public ModelAndView createChannelForm(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("workspace/createchannel");
		HttpSession session = req.getSession(false);
		int rep_id = (int) session.getAttribute("rep_id");
		ArrayList<Integer> userlist = service.getUserList(rep_id);
		ArrayList<String> usernamelist = service.getUserNameList(userlist);
		mav.addObject("usernamelist", usernamelist);
		return mav;
	}

	@RequestMapping(value = "addchannel.do")
	public ModelAndView createChannel(HttpServletRequest req, Repository r,
			@RequestParam(value = "chtitle") String chtitle) {
		ModelAndView mav = new ModelAndView("template/main");
		HttpSession session = req.getSession(false);
		int id = (int) session.getAttribute("id");
		int rep_id = (int) session.getAttribute("rep_id");
		String email = (String) session.getAttribute("email");
		ArrayList<Integer> userlist = service.getUserList(rep_id);
		ArrayList<String> usernamelist = service.getUserNameList(userlist);
		ArrayList<Channel> chnamelist = service.getChList(rep_id);
		ArrayList<String> repnamelist = service.getRepNameListById(id);
		Member m2 = service.getMember(email);
		String user_name = m2.getName();
		ArrayList<Integer> chlist = service.getChIdList(rep_id);
		Repository r2 = service.getRepository(rep_id);
		service.createCh(chtitle, rep_id);
		Channel ch = service.getMaxChannel(rep_id);
		int chid = ch.getCh_id();
		ArrayList<Integer> useridlist = service.getUserList(rep_id);
		ArrayList<String> nicknamelist = service.getNicknameList(rep_id);
		System.out.println("repid:" + rep_id + ";;chid:" + chid);
		for (int i = 0; i < useridlist.size(); i++) {
			int user_id = useridlist.get(i);
			System.out.println(user_id);
			service.createUserMetaCreateChannel1(user_id, rep_id, chid);
		}
		mav.addObject("nicknamelist", nicknamelist);
		mav.addObject("rep_list", repnamelist);
		mav.addObject("ch", ch);
		mav.addObject("rep_name", r2.getRep_name());
		mav.addObject("user_name", user_name);
		mav.addObject("id", id);
		mav.addObject("rep_id", rep_id);
		mav.addObject("ch_list", chnamelist);
		mav.addObject("user_list", usernamelist);
		return mav;
	}

	@RequestMapping(value = "findworkspaceform.do")
	public String findWorkspace() {
		return "workspace/findworkspaceform";
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
			repidlist=null;
			repnamelist=null;
			usernamelist=null;
			errorresult="검색결과가없습니다";
		}
		mav.addObject("errorresult", errorresult);
		mav.addObject("repnamelist", repnamelist);
		mav.addObject("usernamelist", usernamelist);
		mav.addObject("repidlist", repidlist);
		return mav;
	}	
	@RequestMapping(value = "repadminform.do")
	public ModelAndView repadminform(HttpServletRequest req,@RequestParam(value="adminlevel") int adminlevel) {
		ModelAndView mav = new ModelAndView("workspace/repadminform");
		HttpSession session = req.getSession(false);
		int rep_id = (int) session.getAttribute("rep_id");
		ArrayList<Channel> chlist = service.getChList(rep_id);
		
		ArrayList<String> nicknamelist = service.getNicknameList(rep_id);
		mav.addObject("chlist",chlist);
		mav.addObject("nicknamelist",nicknamelist);
		mav.addObject("adminlevel",adminlevel);
		return mav;
	}

	@RequestMapping(value = "teaminvite.do")
	public String teamInvite() {
		return "workspace/teaminvite";
	}

	@RequestMapping(value = "wrokspaceurl.do")
	public String workspaceUrl() {
		return "workspace/workspaceurl";
	}

	@RequestMapping(value = "editprofile.do")
	public String editProfile() {
		return "member/EditFrofile";
	}

	@RequestMapping(value = "profile.do")
	public String profile() {
		return "member/frofile";
	}

	@RequestMapping(value = "profileform.do")
	public String profileForm() {
		return "member/frofileForm";
	}

}
