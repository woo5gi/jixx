function connect() {
  var socket = new SockJS('/project/groupchat');
  stompClient = Stomp.over(socket);
  stompClient.connect({}, function(frame) {
    console.log("connected: " + frame);
    stompClient.subscribe('/chat/messages', function(response) {
      var data = JSON.parse(response.body);
      draw("left", data.from+ " : " +data.message);
    });
  });
}

function disconnect() {
  stompClient.disconnect();
}
function sendMessage() {
  var nick = document.getElementById("nicknamechat");
  var name = nick.getAttribute("value");
  stompClient.send("/app/message", {}, JSON.stringify({'from': name,
    'message' : $("#message_input_value").val()
  }));
}

function draw(side, text) {
  console.log("drawing...");
  var $message;
  $message = $($('.message_template').clone().html());
  $message.addClass(side).find('.avatar').html();
  $message.addClass(side).find('.text').html(text);
  $('.messages').append($message);
  return setTimeout(function() {
    return $message.addClass('appeared');
  }, 0);
}
