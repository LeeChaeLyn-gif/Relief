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
public class Notice {
	private int nid;
	private String aid;
	private String title;
	private String ncontent;
	private Date createDate;
	private Date modifyDate;
	private int ncount;
	private String status;
	private String fileName;
	private String renameFileName;
	private String nstatus;
	private String astatus;
}
