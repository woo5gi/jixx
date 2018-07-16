package com.kitri.project;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.project.member.Service;

import vo.Member;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Resource(name = "memService")
	private Service service;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model,HttpServletRequest req) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);		
		
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("template/index");
		if (session.getAttribute("id") != null) {
				int id = (int) session.getAttribute("id");
				String email = (String) session.getAttribute("email");
				Member m2 = service.getMemberByEmail(email);	
				String user_name = m2.getName();
				mav.addObject("id",id);
				mav.addObject("email",email);
				ArrayList<String> repnamelist = service.getRepNameListById(id);	
				mav.addObject("rep_list", repnamelist);
				mav.addObject("user_name",user_name);
		}
		return mav;
	}
}
