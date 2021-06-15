package com.kh.relief.review.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.common.PageInfo;
import com.kh.relief.review.model.vo.Review;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public int insertReivew(Review review) {
		int result = sqlSession.update("mypageMapper.updateR_Status", review.getT_history_id());
		if(result > 0) {
			return sqlSession.insert("reviewMapper.insertReview", review);
		} else {
			return 0;
		}
		
	}

	@Override
	public int updateReview(Review review) {
		return sqlSession.update("reviewMapper.updateReview", review);
	}

	@Override
	public Review selectReview(int review_id, int t_history_id) {
		if(review_id != 0) {
			return sqlSession.selectOne("reviewMapper.selectReview_rid", review_id);
		} else {
			return sqlSession.selectOne("reviewMapper.selectReview_tid", t_history_id);
		}
	}

	@Override
	public int selectListCount() {
		return sqlSession.selectOne("reviewMapper.selectListCount");
	}

	@Override
	public List<Review> selectList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("reviewMapper.selectList", null, rowBounds);
	}

	@Override
	public int deleteReview(int review_id) {
		int result = sqlSession.update("reviewMapper.delete_r_status", review_id);
		if(result > 0) {
			return sqlSession.update("reviewMapper.deleteReview", review_id);
		} else {
			return 0;
		}
		
	}

}
