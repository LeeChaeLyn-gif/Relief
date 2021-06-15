package com.kh.relief.account.model.dao;

public class AccountDaoImpl {

import com.kh.relief.account.model.vo.Account;

@Repository
public class AccountDaoImpl implements AccountDao{
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Account login(Account a) {
		return sqlSession.selectOne("accountMapper.login", a);
	}

	@Override
	public int checkId(String aid) {
		return sqlSession.selectOne("accountMapper.checkId", aid);
	}

	@Override
	public int insertAccount(Account a) {
		return sqlSession.insert("accountMapper.insertAccount", a);
	}

	@Override
	public int insertNaverAccount(Account loginUser) {
		return sqlSession.insert("accountMapper.insertNaverAccount", loginUser);
	}

	@Override
	public int updateAuthKey(Account a) {
		return sqlSession.update("accountMapper.updateAuthKey", a);
	}

	@Override
	public int updateAuthStatus(String email) {
		return sqlSession.update("accountMapper.updateAuthStatus", email);
	}

	@Override
	public int updateNaverAccount(Account a) {
		return sqlSession.update("accountMapper.updateNaverAccount", a);
	}

	@Override
	public Account findId(Account a) {
		return sqlSession.selectOne("accountMapper.findId", a);
	}

	@Override
	public Account findIdResult(Account a) {
		return sqlSession.selectOne("accountMapper.findIdResult", a);
	}

	@Override
	public int checkEmail(Account a) {
		return sqlSession.selectOne("accountMapper.checkEmail", a);
	}

	@Override
	public Account findPwd(Account a) {
		return sqlSession.selectOne("accountMapper.findPwd", a);
	}

	@Override
	public int findPwdUpdate(Account a) {
		return sqlSession.update("accountMapper.findPwdUpdate", a);
	}
	// 1
}
