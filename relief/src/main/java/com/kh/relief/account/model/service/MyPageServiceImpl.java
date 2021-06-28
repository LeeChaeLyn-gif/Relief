package com.kh.relief.account.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.account.model.dao.MyPageDao;
import com.kh.relief.account.model.vo.Account;
import com.kh.relief.account.model.vo.T_History;
import com.kh.relief.account.model.vo.T_Status;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.chat.model.vo.Chat;
import com.kh.relief.common.PageInfo;

@Service
public class MyPageServiceImpl implements MyPageService{
	@Autowired
	private MyPageDao myDao;
	
	@Override
	public int selectWishListCount(String account_id) {
		return myDao.selectWishListCount(account_id);
	}
	
	@Override
	public List<Board> selectWishList(PageInfo pi, String account_id) {
		return myDao.selectWishList(pi, account_id);
	}

	@Override
	public int deleteWish(int pk_Id) {
		return myDao.deleteWish(pk_Id);
	}

	@Override
	public int selectPHListCount(String consumer_id) {
		return myDao.selectPHListCount(consumer_id);
	}

	@Override
	public List<Board> selectPHList(PageInfo pi, String consumer_id) {
		return myDao.selectPHList(pi, consumer_id);
	}

	@Override
	public int deleteT_History(int t_history_id) {
		return myDao.deleteT_History(t_history_id);
	}

	@Override
	public int selectHiddenListCount(String seller_id) {
		return myDao.selectHiddenListCount(seller_id);
	}

	@Override
	public List<Board> selectHiddenList(PageInfo pi, String seller_id) {
		return myDao.selectHiddenList(pi, seller_id);
	}

	@Override
	public int unHide(int t_history_id) {
		return myDao.unHide(t_history_id);
	}

	@Override
	public int selectSalesListCount(String seller_id) {
		return myDao.selectSalesListCount(seller_id);
	}

	@Override
	public List<Board> selectSalesList(PageInfo pi, String seller_id) {
		return myDao.selectSalesList(pi, seller_id);
	}

	@Override
	public int statusUpdate(T_Status t_status) {
		return myDao.statusUpdate(t_status);
	}

	@Override
	public String matchesPwd(Account account) {
		return myDao.matchesPwd(account);
	}

	@Override
	public int deleteMember(String aid) {
		return myDao.deleteMember(aid);
	}

	@Override
	public Account memberInfo(Account a) {
		return myDao.memberInfo(a);
	}

	@Override
	public int updateMember(Account a, boolean flag) {
		return myDao.updateMember(a, flag);
	}

	@Override
	public int updatePull_Date(int board_id) {
		return myDao.updatePull_Date(board_id);
	}

	@Override
	public List<Chat> selectConsumer(Account account) {
		return myDao.selectConsumer(account);
	}

	@Override
	public int T_Complete(T_History t) {
		return myDao.T_Complete(t);
	}

	@Override
	public int Hide(int t_history_id) {
		return myDao.Hide(t_history_id);
	}

	@Override
	public int getbid(int tid) {
		return myDao.getbid(tid);
	}

	@Override
	public int updateBoard(int bid) {
		return myDao.updateBoard(bid);
	}

}
