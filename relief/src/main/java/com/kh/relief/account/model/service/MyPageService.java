package com.kh.relief.account.model.service;

import java.util.List;

import com.kh.relief.account.model.vo.Account;
import com.kh.relief.account.model.vo.T_Status;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.common.PageInfo;

public interface MyPageService {
	// 찜 리스트 카운트
	int selectWishListCount(String account_id);
	
	// 찜 리스트
	List<Board> selectWishList(PageInfo pi, String account_id);
	
	// 찜 리스트 삭제
	int deleteWish(int pk_Id);
	
	// 구매 이력 카운드
	int selectPHListCount(String consumer_id);
	
	// 구매 이력 리스트
	List<Board> selectPHList(PageInfo pi, String consumer_id);
	
	// T_HISTORY 공용 삭제 함수
	int deleteT_History(int t_history_id);

	// 숨긴 게시물 카운트
	int selectHiddenListCount(String seller_id);

	// 숨긴 게시물 리스트
	List<Board> selectHiddenList(PageInfo pi, String seller_id);
	
	// 숨김해제
	int unHide(int t_history_id);
	
	// 판매 내역 카운트
	int selectSalesListCount(String seller_id);

	// 판매 내역 리스트
	List<Board> selectSalesList(PageInfo pi, String seller_id);
	
	// 판매 상태 업데이트
	int statusUpdate(T_Status t_status);
	
	// 회원 패스워드 확인
	String matchesPwd(Account account);

	// 회원 정보 검색
	Account memberInfo(Account a);

	// 회원 삭제 
	int deleteMember(String aid);

	// 회원 업데이트
	int updateMember(Account a, boolean flag);

	
	
}
