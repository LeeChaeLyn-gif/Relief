package com.kh.relief.admin.model.vo;

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
public class Category {
	private int cid;
	private String cname;
	private int cid2;
	private int cgroup;
	private String cstatus;
}
