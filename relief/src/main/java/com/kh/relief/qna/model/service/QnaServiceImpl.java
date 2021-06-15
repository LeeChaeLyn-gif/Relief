package com.kh.relief.qna.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.qna.model.dao.QnaDao;
import com.kh.relief.qna.model.vo.PageInfo;
import com.kh.relief.qna.model.vo.Qna;

@Service
public class QnaServiceImpl implements QnaService {
	@Autowired
	private QnaDao qDao;
	
	@Override
	public int selectQlistCount() {
		return qDao.selectQlistCount();
	}

	@Override
	public List<Qna> selectQlist(PageInfo pi) {
		return qDao.selectQlist(pi);
	}

	@Override
	public int insertQna(Qna q) {
		return qDao.insertQna(q);
	}

	@Override
	public List<Qna> selectReplyList(int qid) {
		return qDao.selectReplyList(qid);
	}

	@Override
	public Qna selectQboard(int qid) {
		return qDao.selectQboard(qid);
	}

	@Override
	public int updateQna(Qna q) {
		return qDao.updateQna(q);
	}

	@Override
	public int deleteQna(int qid) {
		return qDao.deleteQna(qid);
	}


}
