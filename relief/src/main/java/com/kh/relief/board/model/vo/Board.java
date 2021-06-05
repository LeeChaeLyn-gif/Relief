package com.kh.relief.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Board {
	private int board_id;
	private String account_id;
	private int category_id;
	private String title;
	private String content;
	private Date create_date;
	private Date modify_date;
	private int count;
	private String status;
	private String product_status;
	private String trade_status;
	private int price;
	private String exchange_status;
	private int amount;
	private Date pull_date;
	private String price_status;
	private String area;
	// 메인이미지용 리네임파일명
    private String renameFileName;
}
