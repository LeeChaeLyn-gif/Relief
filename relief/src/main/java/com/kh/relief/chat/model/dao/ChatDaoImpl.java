package com.kh.relief.chat.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.chat.model.vo.Block;
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
		return sqlSession.insert("chatMapper.createChat", c);
	}

	@Override
	public Chat checkChat(Chat c) {
		return sqlSession.selectOne("chatMapper.checkChat", c);
	}

	@Override
	public int insertChat(ChatHistory ch) {
		return sqlSession.insert("chatMapper.insertChat", ch);
	}

	@Override
	public Chat blockCheck(int chatId) {
		return sqlSession.selectOne("chatMapper.blockCheck", chatId);
	}

	@Override
	public int updateBlock(int chatId) {
		return sqlSession.update("chatMapper.updateBlock", chatId);
	}
	
	@Override
	public int updateBlock2(int chatId) {
		return sqlSession.update("chatMapper.updateBlock2", chatId);
	}

	@Override
	public int insertBlock(Chat c) {
		return sqlSession.update("chatMapper.insertBlock", c);
	}

	@Override
	public int insertBlock2(Chat c) {
		return sqlSession.update("chatMapper.insertBlock2", c);
	}

	@Override
	public Block blockUser(Chat c) {
		return sqlSession.selectOne("chatMapper.blockUser", c);
	}

	@Override
	public List<Block> blockUser2(String accountId) {
		return sqlSession.selectList("chatMapper.blockUser2", accountId);
	}

	@Override
	public int updateBlock3(int chatId) {
		return sqlSession.update("chatMapper.updateBlock3", chatId);
	}

	@Override
	public int updateBlock4(int chatId) {
		return sqlSession.update("chatMapper.updateBlock4", chatId);
	}

	@Override
	public int deleteBlock(int chatId) {
		return sqlSession.delete("chatMapper.deleteBlock", chatId);
	}

	@Override
	public int deleteBlock2(int chatId) {
		return sqlSession.delete("chatMapper.deleteBlock2", chatId);
	}

	@Override
	public Chat checkChat2(Chat c) {
		return sqlSession.selectOne("chatMapper.checkChat2", c);
	}

	@Override
	public int exitChat(Chat c) {
		return sqlSession.update("chatMapper.exitChat", c);
	}

	@Override
	public int exitChat2(ChatHistory ch) {
		return sqlSession.update("chatMapper.exitChat2", ch);
	}

	@Override
	public int exitChat3(Chat c) {
		return sqlSession.update("chatMapper.exitChat3", c);
	}

	@Override
	public int exitChat4(ChatHistory ch) {
		return sqlSession.update("chatMapper.exitChat4", ch);
	}

	@Override
	public Chat selectAccount(Chat c) {
		return sqlSession.selectOne("chatMapper.selectAccount", c);
	}



}
