package com.kh.relief.account.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.account.model.vo.Account;

@Repository
public class AccountDaoImpl implements AccountDao {
	@Autowired
	   private SqlSessionTemplate sqlSession;

	   @Override
	   public Account login(Account a) {
	      return sqlSession.selectOne("accountMapper.login", a);
	   }
}
