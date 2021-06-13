package com.kh.relief.qna.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.qna.model.vo.PageInfo;
import com.kh.relief.qna.model.vo.Qna;

@Repository
public class QnaDaoImpl implements QnaDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int selectQlistCount() {
		return sqlSession.selectOne("qnaMapper.selectQlistCount");
	}
	
	@Override
	public List<Qna> selectQlist(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("qnaMapper.selectQlist", pi);
	}

	@Override
	public int insertQna(Qna q) {
		return sqlSession.insert("qnaMapper.insertQna", q);
	}

	@Override
	public List<Qna> selectReplyList(int qid) {
		return sqlSession.selectList("qnaMapper.selectReplyList", qid);
	}

	@Override
	public Qna selectQboard(int qid) {
		return sqlSession.selectOne("qnaMapper.selectQboard", qid);
	}

	@Override
	public int updateQna(Qna q) {
		return sqlSession.update("qnaMapper.updateQna", q);
	}

	@Override
	public int deleteQna(int qid) {
		return sqlSession.update("qnaMapper.deleteQna", qid);
	}



}
