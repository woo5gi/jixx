package com.kitri.project.member;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Random;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.project.repository.MailHandler;

import vo.Member;

@Controller
public class MemberController {
	@Resource(name = "memService")
	private Service service;
	@Inject // spring에서 메일보내주는기능
	private JavaMailSender mailSender;

	// 문자인지 숫자인지 확인하는기능
	public static boolean isNumber(String str) {
		boolean result = false;

		try {
			Double.parseDouble(str);
			result = true;
		} catch (Exception e) {
			result = false;
		}
		return result;
	}

	public void setService(Service service) {
		this.service = service;
	}

	// 이메일 인증 페이지 이동
	@RequestMapping(value = "verifyForm.do")
	public String verifyForm() {
		return "member/verify";
	}

	// index page이동
	@RequestMapping(value = "index.do")
	public ModelAndView index(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession(false);
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		ModelAndView mav = new ModelAndView();
		try {
			int id = (int) session.getAttribute("id");
			String email = (String) session.getAttribute("email");
			Member m2 = service.getMemberByEmail(email);
			System.out.println("1111111" + m2.getName());
			mav = new ModelAndView("template/index");
			mav.addObject("user_name", m2.getName());
			mav.addObject("id", id);
			mav.addObject("email", email);
			ArrayList<String> repnamelist = service.getRepNameListById(id);
			mav.addObject("rep_list", repnamelist);
			System.out.println(repnamelist);
		} catch (NullPointerException e) {
			e.printStackTrace();
			out.println("<script>alert('session값이 없습니다'); </script>");
			out.flush();
			mav = new ModelAndView("member/login");			
		}
		return mav;
	}

	// loginForm으로 이동
	@RequestMapping(value = "member/loginForm.do")
	public String loginForm() {
		return "member/login";
	}

	// 회원가입 form으로 이동
	@RequestMapping(value = "member/signup.do")
	public String signupForm() {
		return "member/signup";
	}

	@RequestMapping(value = "mmm.do")
	public String aaa() {
		return "member/setpassword";
	}

	// 회원가입
	@RequestMapping(value = "/member/insert.do")
	public String add(@ModelAttribute("xxx") Member m, HttpServletResponse res) throws Exception {
		service.addMember(m);
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		out.println("<script>alert('회원가입을 축하합니다'); </script>");
		out.flush();// alert구현
		return "member/login";
	}

	// id중복검사
	@RequestMapping(value = "/idCheck.do")
	public ModelAndView idCheck(@RequestParam(value = "email") String email,
			@RequestParam(value = "checkfrom") String checkfrom) {
		ModelAndView mav = new ModelAndView("member/idCheck");
		String str = "";
		Member m = service.getMemberByEmail(email);
		if (m == null) {
			if (checkfrom.equals("signup")) {
				str = "사용가능한아이디";
			} else {
				str = "존재하지 않는 아이디입니다 회원가입하세요";
			}
		} else {
			if (checkfrom.equals("signup")) {
				str = "사용불가능한 아이디";
			} else {
				str = "존재하는 아이디입니다 . 인증번호전송 버튼을 눌러주세요";
			}
		}
		mav.addObject("str", str);
		return mav;
	}

	// 로그인기능
	@RequestMapping(value = "/login.do")
	public ModelAndView login(HttpServletRequest req, Member m, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView();
		Member m2 = service.getMemberByEmail(m.getEmail());
		if (m2 == null || !m2.getPwd().equals(m.getPwd())) {
			System.out.println("로그인 실패");
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println("<script>alert('로그인 실패'); </script>");
			out.flush();
			mav = new ModelAndView("member/login");
		} else {
			mav = new ModelAndView("template/index");
			HttpSession session = req.getSession();
			session.setAttribute("id", m2.getId());
			session.setAttribute("email", m.getEmail());
			int id = (int) session.getAttribute("id");
			String email = (String) session.getAttribute("email");
			String user_name = m2.getName();

			ArrayList<String> repnamelist = service.getRepNameListById(id);
			/*
			 * for (int i = 0; i < repnamelist.size(); i++) {
			 * System.out.println(repnamelist); }
			 */
			mav.addObject("user_name", user_name);
			mav.addObject("id", id);
			mav.addObject("email", email);
			mav.addObject("rep_list", repnamelist);
		}
		return mav;
	}

	// 로그아웃기능
	@RequestMapping(value = "/member/logout.do")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		session.removeAttribute("id");
		session.invalidate();
		return "member/login";
	}

	// 탈퇴기능
	@RequestMapping(value = "/member/out.do")
	public String out(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		service.delMember(Integer.parseInt(id));
		session.removeAttribute("id");
		session.invalidate();
		return "member/login";
	}

	// create workspace누르면 인증번호 메일전송하는 페이지로이동
	@RequestMapping(value = "crw1.do")
	public ModelAndView crw1(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("workspace/createworkspace1");
		HttpSession session = req.getSession(false);
		String email = (String) session.getAttribute("email");
		Member m = service.getMemberByEmail(email);
		mav.addObject("m", m);
		return mav;
	}

	// createworkspace할때 인증번호 메일로 보내는기능
	@RequestMapping(value = "emailauth.do")
	public String emailAuth(HttpServletRequest req, @RequestParam(value = "email") String email,
			@RequestParam(value = "requestfrom") String requestfrom)
			throws MessagingException, UnsupportedEncodingException {
		HttpSession session = req.getSession(false);
		MailHandler sendMail = new MailHandler(mailSender);
		Random ran = new Random();
		int ran2 = 0;
		while (ran2 <= 100000) {
			ran2 = ran.nextInt(1000000);
		}
		if (requestfrom.equals("createws")) {
			int id = (int) session.getAttribute("id");
			sendMail.setSubject("FILE CETACEA 이메일인증");
			sendMail.setText(
					new StringBuffer().append("<h1>이메일인증</h1>").append("<a href='localhost:8080/project/verifyForm.do")
							.append("'target='_blenk'>이메일 인증 확인</a>").append(ran2).toString());
			sendMail.setFrom("gusdn4973@gmail.com", "CETACEA");
			sendMail.setTo(email);
			sendMail.send();
			service.setTempkey(ran2, id);
			return "member/verify";
		} else if (requestfrom.equals("findpass")) {
			sendMail.setSubject("FILE CETACEA 비밀번호 찾기 이메일인증");
			sendMail.setText(new StringBuffer().append("<h1>이메일인증</h1>")
					.append("<a href='localhost:8080/project/verifypass.do?email=" + email + "&tempkey=" + ran2)
					.append("'target='_blenk'>새 비밀번호 설정</a>").toString());
			sendMail.setFrom("gusdn4973@gmail.com", "CETACEA");
			sendMail.setTo(email);
			sendMail.send();
			service.setTempkey(ran2, email);
			return "member/verifypass";
		}
		return null;
	}

	// 메일로보낸 인증키와 입력받은값 비교하여 메일인증
	@RequestMapping(value = "verify.do")
	public String verify(HttpServletRequest req, @RequestParam(value = "verify") int tempKey, HttpServletResponse res)
			throws Exception {
		HttpSession session = req.getSession(false);
		String email = (String) session.getAttribute("email");

		Member m = new Member();
		m.setEmail(email);
		int tempKeydb = service.selectTempKey(email);
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		if (tempKey == tempKeydb) {
			service.verifyMember(m);
			return "workspace/createworkspace2";
		} else {
			if (isNumber(String.valueOf(tempKey))) {
				out.println("<script>alert('인증번호가 일치하지 않습니다'); </script>");
				out.flush();
			} else {
				out.println("<script>alert('숫자를 입력하세요'); </script>");
				out.flush();
			}
		}
		return "member/verify";
	}

	// 비번찾기누르면 인증번호 메일전송하는 페이지로이동
	@RequestMapping(value = "member/forgotpass.do")
	public String findPass() {
		return "member/forgotpassword";
	}

	@RequestMapping(value = "verifypass.do")
	public ModelAndView setNewPass(HttpServletResponse res, @RequestParam(value = "email") String email,
			@RequestParam(value = "tempkey") int tempkey) throws Exception {
		ModelAndView mav;
		int tempkeydb = service.selectTempKey(email);
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		if (tempkey == tempkeydb) {
			service.verifyMemberByEmail(email);
			mav = new ModelAndView("member/setpassword");
			mav.addObject("email", email);
		} else {
			out.println("<script>alert('인증번호가 일치하지 않거나 시스템 오류입니다'); </script>");
			out.flush();
			mav = new ModelAndView("member/login");
		}
		return mav;
	}

	@RequestMapping(value = "setnewpass.do")
	public String setPassLogin(HttpServletResponse res, Member m) throws Exception {
		service.setNewPass(m);
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		out.println("<script>alert('비밀번호 변경이 완료되었습니다.'); </script>");
		out.flush();
		return "member/login";
	}

	@RequestMapping(value = "editprofileform.do")
	public ModelAndView profileForm(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("member/profileform");
		HttpSession session = req.getSession(false);
		/* String */
		return mav;
	}

	// 회원정보수정Form으로 이동
	@RequestMapping(value = "/member/editForm.do")
	public ModelAndView editForm(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("member/editForm");
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		Member m = service.getMemberId(Integer.parseInt(id));
		mav.addObject("m", m);
		return mav;
	}

	// 회원정보수정기능
	@RequestMapping(value = "/member/edit.do")
	public String edit(Member m) {
		service.editMember(m);
		return "member/main";
	}

}
