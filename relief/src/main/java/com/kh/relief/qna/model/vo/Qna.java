package com.kh.relief.qna.model.vo;

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
public class Qna {
	private int qid;
	private String aid;
	private String qtitle;
	private String qcontent;
	private String atitle;
	private String acontent;
	private String status;
	private String astatus;
	private String star;
}