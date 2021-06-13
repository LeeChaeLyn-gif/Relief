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
public class Report {
	private int rpid;
	private int chid;
	private int bid;
	private int rid;
	private String reportReason;
	private String aid;
	private String aid2;
	private Date reportDate;
}
