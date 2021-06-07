package com.kh.relief.board.model.service;

import java.util.List;
<<<<<<< HEAD

=======
>>>>>>> branch 'jihun-L' of https://github.com/chae-lyn/Relief

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.relief.board.model.service.BoardService;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.Search;
import com.kh.relief.board.model.vo.Wish;
import com.kh.relief.board.model.dao.BoardDao;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.board.model.dao.BoardDao;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.CategoryBoard;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.PageInfo;
import com.kh.relief.board.model.vo.SearchBoard;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardDao bDao;

	@Override
	public int selectbListCount(SearchBoard sb) {
		return bDao.selectbListCount(sb);
	}

	@Override
	public List<Board> selectbList(SearchBoard sb, PageInfo pi) {
		return bDao.selectbList(sb,pi);
	}

	@Override
	public Image selectiList(int board_id) {
		return bDao.selectiList(board_id);
	}

	@Override
	public List<Board> descbList(SearchBoard sb, PageInfo pi) {
		return bDao.descbList(sb,pi);
	}

	@Override
	public List<Board> ascbList(SearchBoard sb, PageInfo pi) {
		return bDao.ascbList(sb,pi);
	}

	@Override
	public List<Category> selectcList() {
		return bDao.selectcList();
	}

	@Override
	public Category selectCategory1(int cid) {
		return bDao.selectCategory1(cid);
	}

	@Override
	public List<Category> selectcListFromCid2(int cid) {
		return bDao.selectcListFromCid2(cid);
	}

	@Override
	public List<Category> selectcListFromiList(List<Integer> iList) {
		return bDao.selectcListFromiList(iList);
	}

	@Override
	public int selectbListFromCategoryCount(CategoryBoard cb) {
		return bDao.selectbListFromCategoryCount(cb);
	}

	@Override
	public List<Board> selectbListFromCategory(CategoryBoard cb, PageInfo pi) {
		return bDao.selectbListFromCategory(cb, pi);
	}
	
	@Override
	public int selectbListFromCategoryCount2(CategoryBoard cb) {
		return bDao.selectbListFromCategoryCount2(cb);
	}

	@Override
	public List<Board> selectbListFromCategory2(CategoryBoard cb, PageInfo pi) {
		return bDao.selectbListFromCategory2(cb, pi);
	}
	
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

	
}
