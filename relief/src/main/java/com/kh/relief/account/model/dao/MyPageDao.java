package com.kh.relief.account.model.dao;

import java.util.List;

import com.kh.relief.account.model.vo.Account;
import com.kh.relief.account.model.vo.T_Status;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.common.PageInfo;

public interface MyPageDao {
	
	int selectWishListCount(String account_id);

	List<Board> selectWishList(PageInfo pi, String account_id);

	int deleteWish(int pk_Id);

	int selectPHListCount(String consumer_id);

	List<Board> selectPHList(PageInfo pi, String consumer_id);

	int deleteT_History(int t_history_id);

	int selectHiddenListCount(String seller_id);

	List<Board> selectselectHiddenList(PageInfo pi, String seller_id);

	int unHide(int t_history_id);

	int selectSalesListCount(String seller_id);

	List<Board> selectSalesList(PageInfo pi, String seller_id);

	int statusUpdate(T_Status t_status);

	String matchesPwd(Account account);

	int deleteMember(String aid);

	Account memberInfo(Account a);

	int updateMember(Account a, boolean flag);

	int updatePull_Date(int board_id);
}
