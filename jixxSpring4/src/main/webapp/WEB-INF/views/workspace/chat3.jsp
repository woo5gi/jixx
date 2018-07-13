<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery 3 -->
<script src="<%=request.getContextPath()%>/resources/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/webjars/sockjs-client/1.0.2/sockjs.min.js"></script>
<script src="<%=request.getContextPath()%>/webjars/stomp-websocket/stomp.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/script.js"></script>
<link href="<%=request.getContextPath()%>/resources/style.css" rel="stylesheet">

</head>
<body>
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
		<li class="message"><div class="avatar"></div>
			<div class="text_wrapper">
				<div class="text"></div>
			</div></li>
	</div>
</body>
</html>