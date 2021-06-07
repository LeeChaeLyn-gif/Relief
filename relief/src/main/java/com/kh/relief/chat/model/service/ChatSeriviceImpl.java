package com.kh.relief.chat.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.chat.model.dao.ChatDao;
import com.kh.relief.chat.model.vo.Chat;
import com.kh.relief.chat.model.vo.ChatHistory;

@Service
public class ChatSeriviceImpl implements ChatService {

	@Autowired
	private ChatDao cDao;
	
	@Override
	public List<ChatHistory> selectList(String accountId) {
		return cDao.selectList(accountId);
	}

	@Override
	public List<ChatHistory> selectChat(int chatId) {
		return cDao.selectChat(chatId);
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

}
