package com.kh.relief.notice.model.service;

import java.util.List;

import com.kh.relief.common.PageInfo;
import com.kh.relief.notice.model.vo.Notice;


public interface NoticeService {
	// 게시글 갯수 조회
	int selectListCount();

	// 리스트
	List<Notice> selectList(PageInfo pi);
	
	// 게시글 등록
	int insertNotice(Notice n);

	// 게시글 상세
	Notice selectNotice(int notice_id, boolean flag);
	
	// 게시글 수정
	int updateNotice(Notice n);
 
	// 게시글 삭제
	int deleteNotice(int notice_id);
}
