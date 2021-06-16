package com.kh.relief.chat.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.relief.account.model.vo.Account;
import com.kh.relief.admin.model.vo.Report;
import com.kh.relief.chat.model.service.ChatService;
import com.kh.relief.chat.model.vo.Block;
import com.kh.relief.chat.model.vo.Chat;
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
	public void chatList(String accountId, HttpServletResponse response, HttpServletRequest request)
			throws IOException {
		List<ChatHistory> cList = cService.selectList(accountId);

		List<Block> bList = cService.blockUser2(accountId);
		System.out.println(bList);
		String host = request.getRemoteAddr();
		System.out.println(host);
		JSONArray jArr = new JSONArray();

		for (ChatHistory chat : cList) {
			JSONObject jChat = new JSONObject();

			jChat.put("accountId", chat.getAccountId());
			jChat.put("accountId2", chat.getAccountId2());
			jChat.put("content", chat.getContent());
			jChat.put("chatDate", chat.getChatDate().toString());
			jChat.put("chatId", chat.getChatId());
			jChat.put("name", chat.getName());
			jChat.put("chatHistoryId", chat.getChatHistoryId());

			jArr.add(jChat);
		}

		JSONArray jArr2 = new JSONArray();

		if (!bList.isEmpty()) {
			for (Block block : bList) {
				JSONObject jBlock = new JSONObject();

				jBlock.put("blockId", block.getBlockId());
				jBlock.put("accountId", block.getAccountId());
				jBlock.put("accountId2", block.getAccountId2());
				jBlock.put("chatId", block.getChatId());
				jBlock.put("blockDate", block.getBlockDate().toString());

				jArr2.add(jBlock);
			}
		}

		JSONObject sendJson = new JSONObject();
		sendJson.put("cList", jArr);
		if (!bList.isEmpty()) {
			sendJson.put("bList", jArr2);
		}
		PrintWriter out = response.getWriter();
		out.print(sendJson);

		out.flush();
		out.close();
	}

	// 채팅방 select
	@RequestMapping("/selectChat")
	public ModelAndView chating(@RequestParam int chatId, ModelAndView mv, HttpSession session) {

		Account loginUser = (Account) session.getAttribute("loginUser");

		List<ChatHistory> chList = cService.selectChat(chatId);

		Chat c = new Chat();
		c.setChatId(chatId);
		c.setAccountId(loginUser.getAid());

		Block b = cService.blockUser(c);

		if (b != null) {
			mv.addObject("b", b);
		}

		if (chList != null && chList.size() > 0) {
			mv.addObject("chatId", chatId);
			mv.addObject("chList", chList);
			mv.setViewName("chat/chat");
		} else {
			mv.addObject("msg", "채팅 조회실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}

	// 채팅 insert
	@RequestMapping("/createChat")
	public ModelAndView createChat(@RequestParam String accountId2, HttpSession session, ModelAndView mv) {

		Account loginUser = (Account) session.getAttribute("loginUser");
		String accountId = loginUser.getAid();

		Chat c = new Chat();
		c.setAccountId(accountId);
		c.setAccountId2(accountId2);

		Chat checkChat = cService.checkChat(c);
		Chat checkChat2 = cService.checkChat2(c);

		if (checkChat == null && checkChat2 == null) {

			int result = cService.createChat(c);
			Chat checkChat3 = cService.checkChat(c);

			int chatId = checkChat3.getChatId();

			List<ChatHistory> chList = cService.selectChat(chatId);

			mv.addObject("chatId", chatId);
			mv.addObject("chList", chList);
			mv.setViewName("chat/chat");

		} else if (checkChat != null) {

			int chatId = checkChat.getChatId();
			List<ChatHistory> chList = cService.selectChat(chatId);

			mv.addObject("chatId", chatId);
			mv.addObject("chList", chList);
			mv.setViewName("chat/chat");
		} else {

			int chatId = checkChat2.getChatId();
			List<ChatHistory> chList = cService.selectChat(chatId);

			mv.addObject("chatId", chatId);
			mv.addObject("chList", chList);
			mv.setViewName("chat/chat");
		}

		return mv;
	}

	// 채팅 차단
	@RequestMapping("/blockChat")
	public ModelAndView blockChat(@RequestParam int chatId, ModelAndView mv, HttpSession session) {
		int result = 0;
		int result2 = 0;

		Chat c = cService.blockCheck(chatId);

		Account loginUser = (Account) session.getAttribute("loginUser");

		// 로그인유저
		String accountId = loginUser.getAid();
		if (accountId == c.getAccountId()) {
			result = cService.updateBlock(chatId);
			result2 = cService.insertBlock(c);
		} else {
			result = cService.updateBlock2(chatId);
			c.setAccountId2(c.getAccountId());
			c.setAccountId(accountId);
			result2 = cService.insertBlock2(c);
		}
		mv.setViewName("chat/room");
		return mv;
	}

	// 채팅 차단해제
	@RequestMapping("/unBlockChat")
	public ModelAndView unBlockChat(@RequestParam int chatId, ModelAndView mv, HttpSession session) {
		int result = 0;
		int result2 = 0;

		Chat c = cService.blockCheck(chatId);

		Account loginUser = (Account) session.getAttribute("loginUser");

		// 로그인유저
		String accountId = loginUser.getAid();

		if (accountId == c.getAccountId()) {
			result = cService.updateBlock3(chatId);
			result2 = cService.deleteBlock(chatId);
		} else {
			result = cService.updateBlock4(chatId);
			result2 = cService.deleteBlock2(chatId);
		}
		mv.setViewName("chat/room");
		return mv;
	}

	@GetMapping("/reportUser")
	public String reportUser(int chid, Model model, HttpSession session) {

		Account loginUser = (Account) session.getAttribute("loginUser");
		String accountId = loginUser.getAid();

		Chat c = cService.blockCheck(chid);

		if (c.getAccountId() == accountId) {
			model.addAttribute("accountId2", c.getAccountId2());
		} else {
			model.addAttribute("accountId2", c.getAccountId());
		}

		model.addAttribute("accountId", accountId);
		model.addAttribute("chid", chid);

		return "/board/reportPage";
	}

	
	  @RequestMapping("/exitChat") 
	  public String exitChat(@RequestParam int chid, ModelAndView mv, HttpSession session, Model model) {
	  
	  Account loginUser = (Account) session.getAttribute("loginUser");
	  
	  	// 로그인유저
	  	String accountId = loginUser.getAid();
	  
	  List<ChatHistory> chList = cService.selectChat(chid);
	  
	  Chat c = new Chat();
	  c.setChatId(chid);
	  c.setAccountId(loginUser.getAid());

	  Chat chat = cService.selectAccount(c);
	  if(chat.getAccountId() == accountId) {
		  int result = cService.exitChat(chat); 
	  } else {
		  int result = cService.exitChat3(chat);
	  }
	  
	  ChatHistory ch = new ChatHistory();
	  ch.setAccountId(accountId);
	  ch.setChatId(chid);
	  
	  if(ch.getAccountId() == accountId) { 
		  model.addAttribute("accountId2", ch.getAccountId2()); 
		  List<ChatHistory> chList2 = cService.selectChat(chid);
		  int result2 = cService.exitChat2(ch); 
		  } else {
			  model.addAttribute("accountId2", ch.getAccountId()); 
			  List<ChatHistory> chList2 = cService.selectChat(chid); 
			  int result2 = cService.exitChat4(ch); 
		 }
	  model.addAttribute("msg", "채팅방 나감");
	  return "/chat/alertPage"; 
	  }
	 
}
