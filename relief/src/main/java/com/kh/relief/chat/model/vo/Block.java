package com.kh.relief.chat.model.vo;

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
public class Block {
	private int blockId;
	private String accountId;
	private String accountId2;
	private int chatId;
	private Date blockDate;
}
