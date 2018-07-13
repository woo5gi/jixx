<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.bg {
	min-height: 100%;
	background-color: #ecf0f5;
	margin-left: 230px;
}
</style>
</head>
<jsp:include page="../template/mainHeader.jsp" flush="false" />
<div class="bg">
  <section class="content ">
  <h1>Simple chat</h1>
  <div class="chat_window">
    <div class="top_menu">
      <div class="buttons">
        <div class="button close"></div>
        <div class="button minimize"></div>
        <div class="button maximize"></div>
      </div>
      <div class="title">Chat</div>
    </div>
    <ul class="messages"></ul>
    <div class="bottom_wrapper clearfix">
      <div class="message_input_wrapper">
        <input id="message_input_value" class="message_input" placeholder="Type your message here..." />
      </div>
      <div class="send_message">
        <div class="icon"></div>
      </div>
      <button onclick="connect()">Connect to chat</button>
      <button onclick="sendMessage()" class="text">Send</button>
      <button onclick="disconnect()">Disconnect from chat</button>
    </div>
  </div>
  <div id="message_template" class="message_template">
    <li class="message"><div class="avatar">${sessionScope.nickname}</div>
      <div class="text_wrapper">
        <div class="text"></div>
      </div></li>
  </div>
  </section>
</div>
</body>
<script src="<%=request.getContextPath()%>/webjars/sockjs-client/1.0.2/sockjs.min.js"></script>
<script src="<%=request.getContextPath()%>/webjars/stomp-websocket/stomp.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/script.js"></script>
<link href="<%=request.getContextPath()%>/resources/style.css" rel="stylesheet">
</html>