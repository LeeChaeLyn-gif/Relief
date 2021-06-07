package com.kh.relief.chat.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.relief.chat.model.service.ChatService;
import com.kh.relief.chat.model.vo.ChatHistory;

@Component
public class ChatHandler extends TextWebSocketHandler {
@Autowired
private ChatService cService;
	// 웹소켓 세션을 담아둘 맵
	HashMap<String, WebSocketSession> sessionMap = new HashMap<>();
	// 웹소켓 세션을 담아둘 리스트
	List<HashMap<String, Object>> lArr = new ArrayList<>();

	// 소켓 연결
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		boolean flag = false;
		String url = session.getUri().toString();
		System.out.println(url);
		int chatId = Integer.parseInt(url.split("/chat/")[1]);
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
		// 메시지 발송
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
						wss.sendMessage(new TextMessage(obj.toJSONString()));
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
