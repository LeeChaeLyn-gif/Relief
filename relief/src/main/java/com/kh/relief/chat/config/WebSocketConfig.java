package com.kh.relief.chat.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.kh.relief.chat.handler.ChatHandler;
import com.kh.relief.chat.handler.MainHandler;


@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
	@Autowired
	private ChatHandler chatHandler;
	@Autowired
	private MainHandler mainHandler;

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(chatHandler, "/{type}/{targetId}");
		registry.addHandler(mainHandler, "main/{accountId}");
	}
}