package com.kh.relief.review.model.vo;

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
public class Review {
	private int review_id;
	private int t_history_id;
	private String title;
	private String content;
	private String status;
	private String star;
	private Date create_date;
	private Date modify_date;
	
	//T_HISTORY의 판매자 아이디
	private String seller_id;
	 
	//T_HISTORY의 구매자 아이디
	private String consumer_id;
}
