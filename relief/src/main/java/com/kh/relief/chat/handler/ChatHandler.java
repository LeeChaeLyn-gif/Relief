package com.kh.relief.chat.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.relief.account.model.vo.Account;
import com.kh.relief.chat.model.service.ChatService;
import com.kh.relief.chat.model.vo.Block;
import com.kh.relief.chat.model.vo.Chat;
import com.kh.relief.chat.model.vo.ChatHistory;

//@Component
public class ChatHandler extends TextWebSocketHandler {
	@Autowired
	private ChatService cService;
	// 로그인 한 유저 세션
	Map<String, WebSocketSession> userSessionMap = new HashMap<>();

	// 채팅방 내부 사람들 세션
	List<HashMap<String, Object>> chatSessionMap = new ArrayList<>();
	
	// 소켓 연결
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		boolean flag = false;
		String accountId = null;
		int chatId = 0;
		
		// session의 uri값을 url에 담는다.
		String url = session.getUri().toString();

		// url을 배열로 만들고 "/relief/"를 기준으로 스플릿 처리한다.
		String[] urlArray = url.split("/relief/");
		String type = urlArray[1].split("/")[0];
		String targetId = urlArray[1].split("/")[1];
		
		if(targetId.contains("_")) {
			accountId = urlArray[1].split("/")[1].split("_")[0];
			chatId = Integer.parseInt(targetId.split("_")[1]);
		} else {
			accountId = urlArray[1].split("/")[1];
		}
		
		
		System.out.println("url : " + url);
		
		// chat/user01_1 => 채팅방 들어왔을때.
		// account/user01 => main 페이지 소켓 연결했을때.
		if (type.equals("account")) {
			// main 페이지 소켓 연결했을때
			// 로그인 한 유저 판별해서 userSessionMap 에 key = accountId, value = session 으로 넣기
			System.out.println(accountId);
			userSessionMap.put(accountId, session);
			
		} else { // 채팅방 들어왔을때.
			boolean existFlag = false;
			int idx = chatSessionMap.size();
			// 방의 사이즈를 조사한다.
			if (chatSessionMap.size() > 0) {
				for (int i = 0; i < chatSessionMap.size(); i++) {
					int rN = (int) chatSessionMap.get(i).get("chatId");
					if (rN == chatId) {
						existFlag = true;
						idx = i;
						break;
					}
				}
			}
			if(existFlag) {
				// 기존 채팅방 세션 맵 불러와서 담기
				HashMap<String, Object> map = chatSessionMap.get(idx);
				map.put(accountId, session);
			} else {
				// 채팅 들어온 유저 판별해서 chatSessionMap 에 key = chatId, value = chatId,key = accountId, value = session  으로 넣기
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("chatId", chatId);
				map.put(accountId, session);
				chatSessionMap.add(map);
			}
		}
	}

	// 메세지 발송
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		JSONObject obj = JsonToObjectParser(msg);
		System.out.println("obj : " + obj);


		// obj 내 원하는 값 추출
		int chatId = Integer.parseInt((String) obj.get("chatId"));
		String accountId = (String) obj.get("accountId");
		String targetAccountId = (String) obj.get("accountId2");
		String chat = (String) obj.get("msg");
		String type = (String) obj.get("type");

		// chat insert
		ChatHistory ch = new ChatHistory();
		ch.setChatId(chatId);
		ch.setAccountId(accountId);
		ch.setContent(chat);
		
		Chat c = new Chat();
		c.setAccountId(targetAccountId);
		c.setChatId(chatId);
		
		Block b = cService.blockUser(c);
		if(b == null) {
			int result = cService.insertChat(ch);
		} else if(accountId.equals(ch.getAccountId())) {
			int result = cService.insertChat2(ch);
		} else {
			int result = cService.insertChat3(ch);
		}

		
		Map<String, Object> chatSession = new HashMap<>();
		
		for(int i = 0; i < chatSessionMap.size(); i++) {
			int cId = (int) chatSessionMap.get(i).get("chatId"); 
			if( cId == chatId) {
				chatSession = chatSessionMap.get(i);
				break;
			}
		}
		
		
		if(chatSession.get(targetAccountId) != null) {
			WebSocketSession targetSession = (WebSocketSession)chatSession.get(obj.get("accountId2"));
			TextMessage sendmsg = new TextMessage(obj.toJSONString());
			System.out.println("sendmsg : " + sendmsg);
			targetSession.sendMessage(sendmsg);
			
		} else {
			if (userSessionMap.get(targetAccountId)!=null) {
				WebSocketSession targetSession = (WebSocketSession)userSessionMap.get(obj.get("accountId2"));
				TextMessage alram = new TextMessage(obj.toJSONString());
				System.out.println("t : " + targetSession);
				targetSession.sendMessage(alram);
			}
		}
	}

	// 소켓종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		if (chatSessionMap.size() > 0) { // 소켓이 종료되면 해당 세션값들을 찾아서 지운다.
			
			for (int i = 0; i < chatSessionMap.size(); i++) {
				Map<String, Object> chatSession = chatSessionMap.get(i);
				
				for(String key : chatSession.keySet()) {
					
					if (session == chatSession.get(key)) {
						chatSession.remove(key);
						break;
					}
				}
			}
		}
		super.afterConnectionClosed(session, status);
	}

	// json형태의 문자열을 파라미터로 받아서 SimpleJson의 파서를 활용하여 JSONObject로 파싱처리를 해주는 함수
	private static JSONObject JsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}
}