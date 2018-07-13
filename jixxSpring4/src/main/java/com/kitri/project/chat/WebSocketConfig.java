package com.kitri.project.chat;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;

@Configuration
@EnableWebMvc
@EnableWebSocketMessageBroker
@ComponentScan(basePackages= {"com.kitri.project.chat"})
public class WebSocketConfig extends AbstractWebSocketMessageBrokerConfigurer {

  public void configureMessageBroker(MessageBrokerRegistry confi) {
    // broker의 대상 목적지에 대한 prefix 설정
    // server-side에서 client-side로 전송할 때 사용하는 경로의 prefix
    confi.enableSimpleBroker("/chat");
    confi.setApplicationDestinationPrefixes("/app");
    // Server의 controller에서 사용할 토픽의 prefix
    // 이 설정으로 인해서 컨트롤러에서 @MessageMapping 할 때 "/app/hello" -> "/hello" 라고 선언 가능.
  }

  public void registerStompEndpoints(StompEndpointRegistry registry) {
    registry.addEndpoint("/groupchat").withSockJS();
    // Client가 접속 할 Server의 URL
    // 웹브라우저에서 connect 버튼 클릭시 다음과 같이 접속요청.
    // Request URL:http://127.0.0.1:8080/groupchat/info?t=148825793768

  }

}

