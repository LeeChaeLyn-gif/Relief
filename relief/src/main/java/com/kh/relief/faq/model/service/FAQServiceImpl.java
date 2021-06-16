package com.kh.relief.faq.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.common.PageInfo;
import com.kh.relief.faq.model.dao.FAQDao;
import com.kh.relief.faq.model.vo.FAQ;


@Service
public class FAQServiceImpl implements FAQService{
	@Autowired
	private FAQDao fDao;
	
	@Override
	public int selectListCount() {
		return fDao.selectListCount();
	}

	@Override
	public List<FAQ> selectList(PageInfo pi) {
		return fDao.selectList(pi);
	}

	@Override
	public int insertFAQ(FAQ f) {
		return fDao.insertFAQ(f);
	} 

	@Override
	public FAQ selectFAQ(int faq_id) {
		return fDao.selectFAQ(faq_id);
	}

	@Override
	public int updateFAQ(FAQ f) {
		return fDao.updateFAQ(f);
	}

	@Override
	public int deleteFAQ(int faq_id) {
		return fDao.deleteFAQ(faq_id);
	}

}
