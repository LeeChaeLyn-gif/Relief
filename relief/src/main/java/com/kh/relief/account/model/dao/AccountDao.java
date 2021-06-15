package com.kh.relief.account.model.dao;

import com.kh.relief.account.model.vo.Account;


public interface AccountDao {

	Account login(Account a);

	int checkId(String aid);

	int insertAccount(Account a);

	int insertNaverAccount(Account loginUser);

	int updateAuthKey(Account a);

	int updateAuthStatus(String email);

	int updateNaverAccount(Account a);

	Account findId(Account a);

	Account findIdResult(Account a);

	int checkEmail(Account a);

	Account findPwd(Account a);

	int findPwdUpdate(Account a);

}
