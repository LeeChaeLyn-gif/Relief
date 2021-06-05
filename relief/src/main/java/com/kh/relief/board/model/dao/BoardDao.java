package com.kh.relief.board.model.dao;

import java.util.List;

import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.Search;
import com.kh.relief.board.model.vo.Wish;

public interface BoardDao {
	// 오늘의 추천 상품
	List<Board> selectTodayList();
	// 조회수
	void updateReadCount(int board_id);
	// 상품 조회
	Board selectBoard(int board_id);
	// 이미지
	Image selectImage(int board_id);
	// 이미지 여러개
	List<Image> selectImageList(int board_id);
	// 찜목록 추가
	int insertWish(Wish w);
	// 찜목록 확인
	Wish selectWish(Wish w);
	// 찜목록 개수
	int wishCount(String aid);

//	List<Board> searchList(Search search);

//	List<Wish> selectWlist();


}
