package com.kitri.project.chat;

import java.util.ArrayList;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.kitri.project.post.Service;
import vo.Channel;
import vo.Member;
import vo.Repository;

@Controller
public class ChatController {
  

  @MessageMapping("/message")
  @SendTo("/chat/messages")
  public Message getMessages(Message message) {
      System.out.println(message);
      return message;
  }
  
  @Resource(name = "postService")
  private Service service;

  @RequestMapping(value = "groupchat")
//  @MessageMapping("/message")
//  @SendTo("/chat/messages")
  public ModelAndView list(HttpServletRequest req, Message message) {
    HttpSession session = req.getSession(false);
    int id = (int) session.getAttribute("id");
    int rep_id = (int) session.getAttribute("rep_id");
    ArrayList<String> nicknamelist = service.getNicknameList(rep_id);
    ArrayList<Channel> chlist = service.getChList(rep_id);
    Member m2 = service.getMember(id);
    ArrayList<String> repnamelist = service.getRepNameListById(id);
    String user_name = m2.getName();
    Repository r = service.getRepository(rep_id);
    ModelAndView mav = new ModelAndView("/workspace/chat2");
    int adminlevel = service.getUserAdminLevel(id, rep_id);
    mav.addObject("adminlevel", adminlevel);
    mav.addObject("rep_list", repnamelist);
    mav.addObject("rep_name", r.getRep_name());
    mav.addObject("user_name", user_name);
    mav.addObject("id", id);
    mav.addObject("rep_id", rep_id);
    mav.addObject("ch_list", chlist);
    mav.addObject("nicknamelist", nicknamelist);
    System.out.println(message);
    return mav;
  }
  
  

}
