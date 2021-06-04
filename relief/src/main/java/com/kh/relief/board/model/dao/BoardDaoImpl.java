package com.kh.relief.board.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.CategoryBoard;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.PageInfo;
import com.kh.relief.board.model.vo.SearchBoard;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSession sqlSession;
	
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

}
