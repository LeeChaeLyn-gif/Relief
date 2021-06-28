package com.kh.relief.chat.model.dao;

import java.util.List;

import com.kh.relief.chat.model.vo.Block;
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
	// 해당 채팅차단확인
	Chat blockCheck(int chatId);
	// 해당 채팅 차단1
	int updateBlock(int chatId);
	// 해당 채팅 차단2
	int updateBlock2(int chatId);
	// 해당 채팅 차단1
	int insertBlock(Chat c);
	// 해당 채팅 차단2
	int insertBlock2(Chat c);
	// 차단 여부 확인
	Block blockUser(Chat c);
	// 차단 후 리스트 조회
	List<Block> blockUser2(String accountId);
	// 해당 채팅 차단해제1
	int updateBlock3(int chatId);
	// 해당 채팅 차단해제2
	int updateBlock4(int chatId);
	// 해당 채팅 차단해제1
	int deleteBlock(int chatId);
	// 해당 채팅 차단해제2
	int deleteBlock2(int chatId);
	// 채팅확인
	Chat checkChat2(Chat c);
	int exitChat(Chat c);
	int exitChat2(ChatHistory ch);
	int exitChat3(Chat c);
	int exitChat4(ChatHistory ch);
	Chat selectAccount(Chat c);
}
