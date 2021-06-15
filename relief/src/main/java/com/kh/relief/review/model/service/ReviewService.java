package com.kh.relief.review.model.service;

import java.util.List;

import com.kh.relief.common.PageInfo;
import com.kh.relief.review.model.vo.Review;

public interface ReviewService {

	// 리뷰 작성
	int insertReview(Review review);

	// 리뷰 수정
	int updateReview(Review review);

	// 셀릭트 뷰
	Review selectReview(int review_id, int t_history_id);

	// 리뷰 리스트 카운트
	int selectListCount();

	// 리뷰 셀릭트 리스트
	List<Review> selectList(PageInfo pi);
	
	// 리뷰 삭제
	int deleteReview(int review_id);

}
