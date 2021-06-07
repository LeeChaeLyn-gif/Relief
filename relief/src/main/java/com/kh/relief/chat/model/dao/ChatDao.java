package com.kh.relief.chat.model.dao;

import java.util.List;

import com.kh.relief.chat.model.vo.Chat;
import com.kh.relief.chat.model.vo.ChatHistory;


public interface ChatDao {

	// 채팅방 목록조회
	List<ChatHistory> selectList(String accountId);
	// 채팅방 상세조회
	List<ChatHistory> selectChat(int chatId);
	// 채팅 insert
	int createChat(Chat c);
	// 채팅방 생성유무 확인
	Chat checkChat(Chat c);
	// 채팅(메세지) insert
	int insertChat(ChatHistory ch);

}
