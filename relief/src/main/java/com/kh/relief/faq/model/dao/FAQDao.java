package com.kh.relief.faq.model.dao;

import java.util.List;

import com.kh.relief.common.PageInfo;
import com.kh.relief.faq.model.vo.FAQ;

public interface FAQDao {
	
	int selectListCount();

	List<FAQ> selectList(PageInfo pi);

	int insertFAQ(FAQ f);

	FAQ selectFAQ(int faq_id);

	int updateFAQ(FAQ f);

	int deleteFAQ(int faq_id);

}
