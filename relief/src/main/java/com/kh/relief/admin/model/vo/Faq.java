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
public class Faq {
	private int fid;
	private String title;
	private String content;
	private Date createDate;
	private Date modifyDate;
	private String status;
	private String fileName;
	private String renameFileName;
	private String aid;
}
