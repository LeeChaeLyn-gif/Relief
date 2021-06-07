package com.kh.relief.chat.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.relief.chat.model.service.ChatService;
import com.kh.relief.chat.model.vo.ChatHistory;


@Controller
public class ChatController {
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Autowired
	private ChatService cService;

	List<ChatHistory> chatHistoryList = new ArrayList<ChatHistory>();
	static int roomNumber = 0;
	
	@RequestMapping("/chat")
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat");
		return mv;
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		return "chat/room";
	}
	
	// 채팅 리스트
	@GetMapping("/chatList")
	public void chatList(String accountId, HttpServletResponse response, HttpServletRequest request) throws IOException {
		List<ChatHistory>cList = cService.selectList(accountId);
		
		String host = request.getRemoteAddr();
		System.out.println(host);
		
		JSONArray jArr = new JSONArray();
		
		for(ChatHistory chat : cList) {
	         JSONObject jChat = new JSONObject();
	         
	         jChat.put("accountId", chat.getAccountId());
	         jChat.put("accountId2", chat.getAccountId2());
	         jChat.put("content", chat.getContent());
	         jChat.put("chatDate", chat.getChatDate().toString());
	         jChat.put("chatId", chat.getChatId());
	         
	         jArr.add(jChat);
	      }
		
	      JSONObject sendJson = new JSONObject();
	      sendJson.put("cList", jArr);
	      
	      PrintWriter out = response.getWriter();
	      out.print(sendJson);
	      
	      out.flush();
	      out.close();
	}
	
	// 채팅방 select
	@RequestMapping("/selectChat")
	public ModelAndView chating(@RequestParam int chatId, ModelAndView mv) {

		
		List<ChatHistory> chList = cService.selectChat(chatId);
		if(chList != null && chList.size() > 0) {
			mv.addObject("chatId", chatId);
			mv.addObject("chList", chList);
			mv.setViewName("chat/chat");
		}else {
			mv.addObject("msg", "채팅 조회실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
}
