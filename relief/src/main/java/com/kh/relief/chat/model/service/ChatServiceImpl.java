package com.kh.relief.chat.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.chat.model.dao.ChatDao;
import com.kh.relief.chat.model.vo.Block;
import com.kh.relief.chat.model.vo.Chat;
import com.kh.relief.chat.model.vo.ChatHistory;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao cDao;
	
	@Override
	public List<ChatHistory> selectList(String accountId) {
		return cDao.selectList(accountId);
	}

	@Override
	public List<ChatHistory> selectChat(Chat c) {
		return cDao.selectChat(c);
	}

	@Override
	public int createChat(Chat c) {
		return cDao.createChat(c);
	}

	@Override
	public Chat checkChat(Chat c) {
		return cDao.checkChat(c);
	}


	@Override
	public int insertChat(ChatHistory ch) {
		return cDao.insertChat(ch);
	}

	@Override
	public Chat blockCheck(int chatId) {
		return cDao.blockCheck(chatId);
	}

	@Override
	public int updateBlock(int chatId) {
		return cDao.updateBlock(chatId);
	}

	@Override
	public int updateBlock2(int chatId) {
		return cDao.updateBlock2(chatId);
	}

	@Override
	public int insertBlock(Chat c) {
		return cDao.insertBlock(c);
	}

	@Override
	public int insertBlock2(Chat c) {
		return cDao.insertBlock2(c);
	}

	@Override
	public Block blockUser(Chat c) {
		return cDao.blockUser(c);
	}

	@Override
	public List<Block> blockUser2(String accountId) {
		return cDao.blockUser2(accountId);
	}

	@Override
	public int updateBlock3(int chatId) {
		return cDao.updateBlock3(chatId);
	}

	@Override
	public int updateBlock4(int chatId) {
		return cDao.updateBlock4(chatId);
	}

	@Override
	public int deleteBlock(int chatId) {
		return cDao.deleteBlock(chatId);
	}

	@Override
	public int deleteBlock2(int chatId) {
		return cDao.deleteBlock2(chatId);
	}

	@Override
	public Chat checkChat2(Chat c) {
		return cDao.checkChat2(c);
	}

	@Override
	public int exitChat(Chat c) {
		return cDao.exitChat(c);
	}

	@Override
	public int exitChat2(ChatHistory ch) {
		return cDao.exitChat2(ch);
	}

	@Override
	public int exitChat3(Chat c) {
		return cDao.exitChat3(c);
	}

	@Override
	public int exitChat4(ChatHistory ch) {
		return cDao.exitChat4(ch);
	}

	@Override
	public Chat selectAccount(Chat c) {
		return cDao.selectAccount(c);
	}

	@Override
	public int insertChat2(ChatHistory ch) {
		return cDao.insertChat2(ch);
	}

	@Override
	public int insertChat3(ChatHistory ch) {
		return cDao.insertChat3(ch);
	}

	@Override
	public int updateChatStatus(Chat c) {
		return cDao.updateChatStatus(c);
	}




}
