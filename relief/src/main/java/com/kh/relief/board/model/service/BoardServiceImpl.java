package com.kh.relief.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.relief.board.model.service.BoardService;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.Search;
import com.kh.relief.board.model.vo.Wish;
import com.kh.relief.board.model.dao.BoardDao;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao bDao;
	
	@Override
	public List<Board> selectTodayList() {
		return bDao.selectTodayList();
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public Board selectBoard(int board_id, boolean flag) {
		if(flag) bDao.updateReadCount(board_id);
		return bDao.selectBoard(board_id);
	}

	@Override
	public Image selectImage(int board_id) {
		return bDao.selectImage(board_id);
	}

	@Override
	public List<Image> selectImageList(int board_id) {
		return bDao.selectImageList(board_id);
	}

	@Override
	public int insertWish(Wish w) {
		return bDao.insertWish(w);
	}

	@Override
	public Wish selectWish(Wish w) {
		return bDao.selectWish(w);
	}

	@Override
	public int wishCount(String aid) {
		return bDao.wishCount(aid);
	}

	/*
	 * @Override public List<Board> searchList(Search search) { return
	 * bDao.searchList(search); }
	 */

//	@Override
//	public List<Wish> selectWlist() {
//		return bDao.selectWlist();
//	}

}
