package com.kh.relief.admin.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Comment {
	private int cmid;
	private int bid;
	private String aid;
	private String title;
	private Date createDate;
	private Date modifyDate;
	private String status;
	private int cmid2;
}
