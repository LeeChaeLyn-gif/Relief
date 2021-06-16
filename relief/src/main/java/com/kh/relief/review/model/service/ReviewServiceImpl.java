package com.kh.relief.review.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.common.PageInfo;
import com.kh.relief.review.model.dao.ReviewDao;
import com.kh.relief.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	private ReviewDao rDao; 
	
	@Override
	public int insertReview(Review review) {
		return rDao.insertReivew(review);
	}

	@Override
	public int updateReview(Review review) {
		return rDao.updateReview(review);
	}

	@Override
	public Review selectReview(int review_id, int t_history_id) {
		return rDao.selectReview(review_id, t_history_id);
	}

	@Override
	public int selectListCount() {
		return rDao.selectListCount();
	}

	@Override
	public List<Review> selectList(PageInfo pi) {
		return rDao.selectList(pi);
	} 

	@Override
	public int deleteReview(int review_id) {
		return rDao.deleteReview(review_id);
	}

}
