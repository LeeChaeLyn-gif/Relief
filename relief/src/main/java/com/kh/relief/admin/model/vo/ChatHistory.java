package com.kh.relief.admin.model.vo;

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
public class ChatHistory {
	private int hid;
	private int chid;
	private String aid;
	private String content;
	private Date chatDate;
	private String status;
	private String notice;
}
