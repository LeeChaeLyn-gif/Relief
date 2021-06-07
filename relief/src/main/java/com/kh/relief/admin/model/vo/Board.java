package com.kh.relief.admin.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Board {
	private int bid;
	private String aid;
	private String cid;
	private String title;
	private String content;
	private Date createDate;
	private Date modifyDate;
	private int count;
	private String status;
	private String productStatus;
	private String tradeStatus;
	private int price;
	private String exchangeStatus;
	private int amount;
	private Date pullDate;
	private String priceStatus;
	private String area;
}
