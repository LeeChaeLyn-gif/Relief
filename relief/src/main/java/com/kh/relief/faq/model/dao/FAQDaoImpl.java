package com.kh.relief.faq.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.common.PageInfo;
import com.kh.relief.faq.model.vo.FAQ;

@Repository
public class FAQDaoImpl implements FAQDao{
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int selectListCount() {
		return sqlSession.selectOne("faqMapper.selectListCount");
	}

	@Override
	public List<FAQ> selectList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("faqMapper.selectList", null, rowBounds);
	}

	@Override
	public int insertFAQ(FAQ f) {
		return sqlSession.insert("faqMapper.insertFAQ", f);
	}
 
	@Override
	public FAQ selectFAQ(int faq_id) {
		return sqlSession.selectOne("faqMapper.selectFAQ", faq_id);
	}

	@Override
	public int updateFAQ(FAQ f) {
		return sqlSession.update("faqMapper.updateFAQ", f);
	}

	@Override
	public int deleteFAQ(int faq_id) {
		return sqlSession.update("faqMapper.deleteFAQ", faq_id);
	}
	

}
