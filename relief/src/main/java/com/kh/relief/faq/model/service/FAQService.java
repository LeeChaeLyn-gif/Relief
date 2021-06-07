package com.kh.relief.faq.model.service;

import java.util.List;

import com.kh.relief.common.PageInfo;
import com.kh.relief.faq.model.vo.FAQ;

public interface FAQService {

	// 게시글 갯수 조회
	int selectListCount();

	// 리스트
	List<FAQ> selectList(PageInfo pi);
	
	// 게시글 등록
	int insertFAQ(FAQ f);

	// 게시글 상세
	FAQ selectFAQ(int faq_id);
	
	// 게시글 수정
	int updateFAQ(FAQ f);
	
	// 게시글 삭제
	int deleteFAQ(int faq_id);
	
	
}
