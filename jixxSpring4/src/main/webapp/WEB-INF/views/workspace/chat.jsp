<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.bg {
	min-height: 100%;
	background-color: #ecf0f5;
	margin-left: 230px;
}

.content1 {
	display: table;
	margin-left: auto;
	margin-right: auto;
	width: 1000px;
	padding-top: 139px;
}

.box-body {
	min-height: 500px;
}

@media ( max-width : 767px) {
	.bg {
		margin-left: 0px;
	}
	.content1 {
		width: 500px;
	}
}
</style>
<jsp:include page="../template/mainHeader.jsp" flush="false" />
<div class="bg">
  <section class="content1">
    <!-- DIRECT CHAT PRIMARY -->
    <div class="box box-primary direct-chat direct-chat-primary">
      <div class="box-header with-border">
        <h3 class="box-title">Direct Chat</h3>
        <div class="box-tools pull-right">
          <span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="3 New Messages">3</span>
          <button type="button" class="btn btn-box-tool" data-widget="collapse">
            <i class="fa fa-minus"></i>
          </button>
          <button type="button" class="btn btn-box-tool" data-toggle="tooltip" title="" data-widget="chat-pane-toggle" data-original-title="Contacts">
            <i class="fa fa-comments"></i>
          </button>
          <button type="button" class="btn btn-box-tool" data-widget="remove">
            <i class="fa fa-times"></i>
          </button>
        </div>
      </div>
      <!-- /.box-header -->
      <ul class="box-body">
        <!-- Conversations are loaded here -->
        <div class="direct-chat-messages" style="height: 520px;">
          <ul class="messages"></ul>
          <!-- /.direct-chat-msg -->
          <!-- Message to the right -->
          <div class="direct-chat-msg right">
            <div class="direct-chat-info clearfix">
              <span class="direct-chat-name pull-right">${sessionScope.nickname}</span> <span class="direct-chat-timestamp pull-left">23 Jan
                2:05 pm</span>
            </div>
            <!-- /.direct-chat-info -->
            <div class="direct-chat-text">You better believe it!</div>
            <!-- /.direct-chat-text -->
          </div>
          <!-- /.direct-chat-msg -->
        </div>
        <!--/.direct-chat-messages-->
        <!-- Contacts are loaded here -->
        <div class="direct-chat-contacts">
          <ul class="contacts-list">
            <li><a href="#"> <img class="contacts-list-img" src="../dist/img/user1-128x128.jpg" alt="User Image">
                <div class="contacts-list-info">
                  <span class="contacts-list-name"> Count Dracula <small class="contacts-list-date pull-right">2/28/2015</small>
                  </span> <span class="contacts-list-msg">How have you been? I was...</span>
                </div> <!-- /.contacts-list-info -->
            </a></li>
            <!-- End Contact Item -->
          </ul>
          <!-- /.contatcts-list -->
        </div>
        <!-- /.direct-chat-pane -->
      </ul>
      <!-- /.box-body -->
      <div class="box-footer">
        <div class="input-group">
          <input id="message_input_value" type="text" name="message" placeholder="Type Message ..." class="form-control"> <span
            class="input-group-btn">
            <button onclick="sendMessage()" id="text" class="btn btn-primary btn-flat">Send</button>
          </span>
        </div>
      </div>
      <!-- /.box-footer-->
    </div>
    <!--/.direct-chat -->
    <div>
      <button onclick="connect()">Connect to chat</button>
      <button onclick="disconnect()">Disconnect from chat</button>
    </div>
    <div id="message_template" class="direct-chat-msg">
      <li class="message">
        <div class="direct-chat-info clearfix">
          <span class="direct-chat-name pull-left "></span> <span class="direct-chat-timestamp pull-right"></span>
        </div> <!-- /.direct-chat-info -->
        <div class="direct-chat-text margin:0,20,0,0"></div> <!-- /.direct-chat-text -->
      </li>
    </div>
</div>
</section>
</div>
</body>
<script src="<%=request.getContextPath()%>/webjars/sockjs-client/1.0.2/sockjs.min.js"></script>
<script src="<%=request.getContextPath()%>/webjars/stomp-websocket/stomp.min.js"></script>
<script type="text/javascript">
  function draw(side, text) {
    console.log("drawing...");
    var $message;
    $message = $($('#message_template').clone().html());
    $message.addClass(side).find('#text').html(text);
    $('.messages').append($message);
    returnsetTimeout(function() {
      return $message.addClass('appeared');
    }, 0);
  }
  function connect() {
    var socket = new SockJS('/project/groupchat');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function(frame) {
      console.log("connected: " + frame);
      stompClient.subscribe('/chat/messages', function(response) {
        var data = JSON.parse(response.body);
        draw("left", data.message);
      });
    });
  }

  function disconnect() {
    stompClient.disconnect();
  }
  function sendMessage() {
    stompClient.send("/app/message", {}, JSON.stringify({
      'message' : $("#message_input_value").val()
    }));
  }
</script>
</html>