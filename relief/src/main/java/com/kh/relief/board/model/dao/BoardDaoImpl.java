package com.kh.relief.board.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.admin.model.vo.Report;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.BoardImage;
import com.kh.relief.board.model.vo.CategoryBoard;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.PageInfo;
import com.kh.relief.board.model.vo.SearchBoard;

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
	
	@Override
	public int selectbListCount(SearchBoard sb) {
		return sqlSession.selectOne("boardMapper.selectbListCount", sb);
	}

	@Override
	public List<Board> selectbList(SearchBoard sb, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("boardMapper.selectbList", sb, rowBounds);
	}

	@Override
	public Image selectiList(int board_id) {
		return sqlSession.selectOne("boardMapper.selectiList", board_id);
	}

	@Override
	public List<Board> descbList(SearchBoard sb, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("boardMapper.selectdescbList", sb, rowBounds);
	}

	@Override
	public List<Board> ascbList(SearchBoard sb, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("boardMapper.selectascbList", sb, rowBounds);
	}

	@Override
	public List<Category> selectcList() {
		return sqlSession.selectList("boardMapper.selectcList");
	}

	@Override
	public Category selectCategory1(int cid) {
		return sqlSession.selectOne("boardMapper.selectCategory1", cid);
	}

	@Override
	public List<Category> selectcListFromCid2(int cid) {
		return sqlSession.selectList("boardMapper.selectcListFromCid2", cid);
	}

	@Override
	public List<Category> selectcListFromiList(List<Integer> iList) {
		return sqlSession.selectList("boardMapper.selectcListFromiList", iList);
	}

	@Override
	public int selectbListFromCategoryCount(CategoryBoard cb) {
		return sqlSession.selectOne("boardMapper.selectbListFromCategoryCount", cb);
	}

	@Override
	public List<Board> selectbListFromCategory(CategoryBoard cb, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("boardMapper.selectbListFromCategory", cb, rowBounds);
	}

	@Override
	public int selectbListFromCategoryCount2(CategoryBoard cb) {
		return sqlSession.selectOne("boardMapper.selectbListFromCategoryCount2", cb);
	}

	@Override
	public List<Board> selectbListFromCategory2(CategoryBoard cb, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("boardMapper.selectbListFromCategory2", cb, rowBounds);
	}

	@Override
	public List<Category> selectCategory() {
		return sqlSession.selectList("boardMapper.selectCategory");
	}

	@Override
	public List<Category> selectCategory2(int cid) {
		return sqlSession.selectList("boardMapper.selectCategory2", cid);
	}

	@Override
	public int insertBoard(Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}

	@Override
	public int insertImage(BoardImage bi) {
		return sqlSession.insert("boardMapper.insertImage", bi);
	}

	@Override
	public int selectbId() {
		return sqlSession.selectOne("boardMapper.selectbId");
	}

	@Override
	public int reportUser(Report r) {
		return sqlSession.insert("boardMapper.reportUser", r);
	}
	
	@Override
	public int reportUser2(Report r) {
		return sqlSession.insert("boardMapper.reportUser2", r);
	}
	
	@Override
	public int reportUser3(Report r) {
		return sqlSession.insert("boardMapper.reportUser3", r);
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
