package com.kh.relief.faq.model.vo;

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
public class FAQ {
	private int faq_id;
	private String title;
	private String content;
	private Date create_date;
	private Date modify_date;
	private String status;
	private String fileName;
	private String rename_fileName;
	private String account_id;
	
}
