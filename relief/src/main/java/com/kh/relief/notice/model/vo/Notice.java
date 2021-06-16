package com.kh.relief.notice.model.vo;

import java.util.List;

import com.kh.relief.common.PageInfo;

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
	private String notice_id;
	private String account_id;
	private String title;
	private String ncontent;
	private String create_date;
	private String modify_date;
	private String ncount;
	private String status;
	private String fileName;
	private String rename_fileName;
	private String n_status;
	private String a_status;

}
 