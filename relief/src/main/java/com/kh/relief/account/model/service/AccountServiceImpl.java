package com.kh.relief.account.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.account.model.dao.AccountDao;
import com.kh.relief.account.model.vo.Account;

@Service
public class AccountServiceImpl implements AccountService{

	@Autowired
	private AccountDao aDao;
	
	@Override
	public Account login(Account a) {
		return aDao.login(a);
	}

	@Override
	public int checkId(String aid) {
		return aDao.checkId(aid);
	}

	@Override
	public int insertAccount(Account a) {
		return aDao.insertAccount(a);
	}

	@Override
	public int insertNaverAccount(Account loginUser) {
		return aDao.insertNaverAccount(loginUser);
	}

	@Override
	public int updateAuthKey(Account a) {
		return aDao.updateAuthKey(a);
		
	}

	@Override
	public int updateAuthStatus(String email) {
		
		return aDao.updateAuthStatus(email);
	}

	@Override
	public int updateNaverAccount(Account a) {
		return aDao.updateNaverAccount(a);
	}

	@Override
	public Account findId(Account a) {
		return aDao.findId(a);
	}

	@Override
	public Account findIdResult(Account a) {
		return aDao.findIdResult(a);
	}

	@Override
	public int checkEmail(Account a) {
		return aDao.checkEmail(a);
	}

	@Override
	public Account findPwd(Account a) {
		return aDao.findPwd(a);
	}

	@Override
	public int findPwdUpdate(Account a) {
		return aDao.findPwdUpdate(a);
	}

	

	
}
