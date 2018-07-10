package com.kitri.project.chat;

import java.util.ArrayList;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import com.kitri.project.post.Service;
import vo.Channel;
import vo.ChatMessage;
import vo.Member;
import vo.Post;
import vo.Repository;

@Controller
public class ChatController {
//  @Resource(name = "chatService")
//  private Service chservice;
//  private WebApplicationContext context = null;
// 
  @Resource(name = "postService")
  private Service service;

  @RequestMapping(value = "/privatechat.do")
  public ModelAndView list(HttpServletRequest req) {
    HttpSession session = req.getSession(false);
    int id = (int) session.getAttribute("id");
    int rep_id = (int) session.getAttribute("rep_id");
    ArrayList<String> nicknamelist = service.getNicknameList(rep_id);
    ArrayList<Channel> chlist = service.getChList(rep_id);
    Member m2 = service.getMember(id);
    ArrayList<String> repnamelist = service.getRepNameListById(id);
    String user_name = m2.getName();
    Repository r = service.getRepository(rep_id);
    ModelAndView mav = new ModelAndView("/workspace/privatechat2");
    int adminlevel = service.getUserAdminLevel(id, rep_id);
    mav.addObject("adminlevel", adminlevel);
    mav.addObject("rep_list", repnamelist);
    mav.addObject("rep_name", r.getRep_name());
    mav.addObject("user_name", user_name);
    mav.addObject("id", id);
    mav.addObject("rep_id", rep_id);
    mav.addObject("ch_list", chlist);
    mav.addObject("nicknamelist", nicknamelist);
    return mav;
  }


  @MessageMapping("/chat.sendMessage")
  @SendTo("/topic/public")
  public ChatMessage sendMessage(@Payload ChatMessage chatMessage) {
    return chatMessage;
  }

  @MessageMapping("/chat.addUser")
  @SendTo("/topic/public")
  public ChatMessage addUser(@Payload ChatMessage chatMessage,
      SimpMessageHeaderAccessor headerAccessor) {
    // Add username in web socket session
    headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
    return chatMessage;
  }
}
