package com.kh.relief.board.model.vo;

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
public class Reply {
	   private int reply_id;
	   private int bid;
	   private String aid;
	   private String title;
	   private Date create_date;
	   private Date modify_date;
	   private String status;
	   private int reply_id2;
}
