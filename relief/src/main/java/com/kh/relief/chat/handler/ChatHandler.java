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
import com.kh.relief.chat.model.vo.ChatHistory;

@Component
public class ChatHandler extends TextWebSocketHandler {
@Autowired
private ChatService cService;
@Autowired
private MainHandler mainHandler;
	// 웹소켓 세션을 담아둘 맵
	HashMap<String, WebSocketSession> sessionMap = new HashMap<>();
	// 웹소켓 세션을 담아둘 리스트
	List<HashMap<String, Object>> lArr = new ArrayList<>();

	// 로그인 한 유저 세션
	Map<String, WebSocketSession> userSessionMap = new HashMap<>();
	
	// 채팅방 내부 사람들 세션
	List<HashMap<String, Object>> chatSessionMap = new ArrayList<>();
	
	// 소켓 연결
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		boolean flag = false;
		String url = session.getUri().toString();
		String[] urlArray = url.split("/relief/");
		// chat/user01:1 => 채팅방 들어왔을때. 
		// account/user01 => main 페이지 소켓 연결했을때
		if (urlArray[1].equals("account")) {
			//main 페이지 소켓 연결했을때
			String accountId = urlArray[2];
			// TODO 로그인 한 유저 판별해서 userSessionMap 에 key = accountId, value = session 으로 넣기
			userSessionMap.put(accountId, session);
		} else {
			//채팅방 들어왔을때. 
			String accountId = urlArray[2].split("/")[0];
			int chatId = Integer.parseInt(urlArray[2].split("/")[1]);
			boolean existFlag = false;
			int idx = chatSessionMap.size(); // 방의 사이즈를 조사한다.
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
			if (existFlag) { // 존재하는 방이라면 세션만 추가한다.
				HashMap<String, Object> map = chatSessionMap.get(idx);
				map.put(accountId, session);
			} else { // 최초 생성하는 방이라면 방번호와 세션을 추가한다.
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("chatId", chatId);
				map.put(accountId, session);
				chatSessionMap.add(map);
			}
			
		}
		
		
		
		int chatId = Integer.parseInt(url.split("/relief/")[1]);
		String accountId = url.split("/relief/")[2];
		int idx = lArr.size(); // 방의 사이즈를 조사한다.
		if (lArr.size() > 0) {
			for (int i = 0; i < lArr.size(); i++) {
				int rN = (int) lArr.get(i).get("chatId");
				if (rN == chatId) {
					flag = true;
					idx = i;
					break;
				}
			}
		}

		if (flag) { // 존재하는 방이라면 세션만 추가한다.
			HashMap<String, Object> map = lArr.get(idx);
			map.put(session.getId(), session);
		} else { // 최초 생성하는 방이라면 방번호와 세션을 추가한다.
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("chatId", chatId);
			map.put(session.getId(), session);
			lArr.add(map);
		}

		// 세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송한다.
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", session.getId());
		session.sendMessage(new TextMessage(obj.toJSONString()));
	}

	// 메세지 발송
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		JSONObject obj = JsonToObjectParser(msg);
		
		// obj 내 원하는 값 추출
		int chatId = Integer.parseInt((String) obj.get("chatId"));
		String accountId = (String) obj.get("accountId");
		String chat = (String) obj.get("msg");
		
		// chat insert
		ChatHistory ch = new ChatHistory();
		ch.setChatId(chatId);
		ch.setAccountId(accountId);
		ch.setContent(chat);
		
		int result = cService.insertChat(ch);
		
		HashMap<String, Object> temp = new HashMap<String, Object>();
		if (lArr.size() > 0) {
			for (int i = 0; i < lArr.size(); i++) {
				int cId = (int) lArr.get(i).get("chatId");
				if (cId == chatId) { // 같은값의 방이 존재한다면
					temp = lArr.get(i); // 해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
					break;
				}
			}

			// 해당 방의 세션들만 찾아서 메시지를 발송해준다.
			for (String k : temp.keySet()) {
				if (k.equals("chatId")) { // 다만 방번호일 경우에는 건너뛴다.
					continue;
				}

				WebSocketSession wss = (WebSocketSession) temp.get(k);
				if (wss != null) {
					try {
						TextMessage tmpMsg = new TextMessage("<a target='_blank' href='"+ "/selectChat?chatId=" + chatId +"'>" + obj.get("msg") + "</a>" );
						wss.sendMessage(new TextMessage(obj.toJSONString()));
						wss.sendMessage(tmpMsg);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	// 소켓종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		if (lArr.size() > 0) { // 소켓이 종료되면 해당 세션값들을 찾아서 지운다.
			for (int i = 0; i < lArr.size(); i++) {
				lArr.get(i).remove(session.getId());
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
