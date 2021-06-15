package com.kh.relief.review.model.dao;

import java.util.List;

import com.kh.relief.common.PageInfo;
import com.kh.relief.review.model.vo.Review;

public interface ReviewDao {

	int insertReivew(Review review);

	int updateReview(Review review);

	Review selectReview(int review_id, int t_history_id);

	int selectListCount();

	List<Review> selectList(PageInfo pi);

	int deleteReview(int review_id);

}
