package com.kh.relief.notice.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.common.PageInfo;
import com.kh.relief.notice.model.dao.NoticeDao;
import com.kh.relief.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	private NoticeDao nDao;

	@Override
	public int selectListCount() {
		return nDao.selectListCount();
	}

	@Override
	public List<Notice> selectList(PageInfo pi) {
		return nDao.selectList(pi);
	}

	@Override
	public int insertNotice(Notice n) {
		return nDao.insertNotice(n);
	}
 
	@Override
	public Notice selectNotice(int notice_id, boolean flag) {
		if(flag) nDao.updateReadCount(notice_id);
		
		return nDao.selectNotice(notice_id);
	}

	@Override
	public int updateNotice(Notice n) {
		return nDao.updateNotice(n);
	}

	@Override
	public int deleteNotice(int notice_id) {
		return nDao.deleteNotice(notice_id);
	}

}
