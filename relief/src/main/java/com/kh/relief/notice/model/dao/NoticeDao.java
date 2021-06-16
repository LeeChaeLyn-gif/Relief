package com.kh.relief.notice.model.dao;

import java.util.List;

import com.kh.relief.common.PageInfo;
import com.kh.relief.notice.model.vo.Notice;


public interface NoticeDao {
	int selectListCount();

	List<Notice> selectList(PageInfo pi);

	int insertNotice(Notice n);

	Notice selectNotice(int Notice_id);
 
	int updateNotice(Notice n);

	void updateReadCount(int notice_id);

	int deleteNotice(int notice_id);

}
