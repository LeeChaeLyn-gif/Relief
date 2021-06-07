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
public class T_History {
	private int t_history_id;
	private int board_id;
	
	private String title;
	private String price;
	private String area;
	
	private Date t_date;
	private String consumer_id;
	private String seller_id;
	private String status;
	private String hide_status;
	
	// 이미지 경로
	private String rename_fileName;
	
	// 게시판 수정일
	private Date modify_date;
	
}
