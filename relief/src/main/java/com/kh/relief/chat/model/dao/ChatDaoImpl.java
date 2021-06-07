package com.kh.relief.chat.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.chat.model.vo.Chat;
import com.kh.relief.chat.model.vo.ChatHistory;


@Repository
public class ChatDaoImpl implements ChatDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<ChatHistory> selectList(String accountId) {
		return sqlSession.selectList("chatMapper.selectList", accountId);
	}

	@Override
	public List<ChatHistory> selectChat(int chatId) {
		return sqlSession.selectList("chatMapper.selectChat", chatId);
	}

	@Override
	public int createChat(Chat c) {
		return sqlSession.insert("chatMapper.insertChat", c);
	}

	@Override
	public Chat checkChat(Chat c) {
		return sqlSession.selectOne("chatMapper.checkChat", c);
	}

	@Override
	public int insertChat(ChatHistory ch) {
		return sqlSession.insert("chatMapper.insertChat", ch);
	}

}
