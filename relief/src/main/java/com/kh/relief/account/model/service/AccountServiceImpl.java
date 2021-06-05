package com.kh.relief.account.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.account.model.dao.AccountDao;
import com.kh.relief.account.model.vo.Account;

@Service
public class AccountServiceImpl implements AccountService {

	@Autowired
	   private AccountDao aDao;
	   
	   @Override
	   public Account login(Account a) {
	      return aDao.login(a);
	   }

}
