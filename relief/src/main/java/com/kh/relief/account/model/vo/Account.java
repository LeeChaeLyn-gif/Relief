package com.kh.relief.account.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Account {
	private String aid;
	private String pwd;
	private String name;
	private String phone;
	private String email;
	private String address;
	private String status;
	private String mstatus;
	private Date sanctions;
	private String authKey;
	private Date createDate;
	
	// 제재 회원 셀렉을 위한 추가
	private int rid;
	private Date reportDate;
}
