package com.kh.relief.board.model.service;

import java.util.List;

import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.Search;
import com.kh.relief.board.model.vo.Wish;

public interface BoardService {

	// 오늘의 추천 상품
	List<Board> selectTodayList();
	// 검색
//	List<Board> searchList(Search search);

	// 상품 조회
	Board selectBoard(int board_id, boolean flag);

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
	
//	// 찜목록
//	List<Wish> selectWlist();

}
