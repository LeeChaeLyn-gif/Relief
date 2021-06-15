package com.kh.relief.qna.model.service;

import java.util.List;

import com.kh.relief.qna.model.vo.PageInfo;
import com.kh.relief.qna.model.vo.Qna;

public interface QnaService {

	// 게시글 수
	int selectQlistCount();
	// QNA 리스트
	List<Qna> selectQlist(PageInfo pi);
	// QNA 등록
	int insertQna(Qna q);
	// QNA 댓글 리스트
	List<Qna> selectReplyList(int qid);
	// QNA 조회
	Qna selectQboard(int qid);
	// QNA 수정
	int updateQna(Qna q);
	// QNA 삭제
	int deleteQna(int qid);


}
