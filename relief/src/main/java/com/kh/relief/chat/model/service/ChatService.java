package com.kh.relief.chat.model.service;

import java.util.List;

import com.kh.relief.chat.model.vo.Chat;
import com.kh.relief.chat.model.vo.ChatHistory;

public interface ChatService {

	// 채팅방 목록조회
	List<ChatHistory> selectList(String accountId);
	// 채팅방 상세조회
	List<ChatHistory> selectChat(int chatId);
	// 채팅방 생성 유무 확인
	Chat checkChat(Chat c);
	// 채팅 존재하지 않으면 채팅방 insert
	int createChat(Chat c);
	// 채팅(메세지) insert
	int insertChat(ChatHistory ch);
}
