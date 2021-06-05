package com.kh.relief.board.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.board.model.dao.BoardDao;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.Search;
import com.kh.relief.board.model.vo.Wish;

@Repository
public class BoardDaoImpl implements BoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Board> selectTodayList() {
		return sqlSession.selectList("boardMapper.selectTodayList");
	}

	@Override
	public void updateReadCount(int board_id) {
		sqlSession.update("boardMapper.updateReadCount", board_id);
		
	}

	@Override
	public Board selectBoard(int board_id) {
		return sqlSession.selectOne("boardMapper.selectBoard", board_id);
	}

	@Override
	public Image selectImage(int board_id) {
		return sqlSession.selectOne("boardMapper.selectImage", board_id);
	}

	@Override
	public List<Image> selectImageList(int board_id) {
		return sqlSession.selectList("boardMapper.selectImageList", board_id);
	}

	@Override
	public int insertWish(Wish w) {
		return sqlSession.insert("boardMapper.insertWish", w);
	}

	@Override
	public Wish selectWish(Wish w) {
		return sqlSession.selectOne("boardMapper.selectWish", w);
	}

	@Override
	public int wishCount(String aid) {
		return sqlSession.selectOne("boardMapper.wishCount", aid);
	}

	/*
	 * @Override public List<Board> searchList(Search search) { return
	 * sqlSession.selectList("boardMapper.searchList", search); }
	 */

//	@Override
//	public List<Wish> selectWlist() {
//		return sqlSession.selectList("boardMapper.selectWlist");
//	}
}
