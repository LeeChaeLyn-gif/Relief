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
public class ChatHistory {

	private int chatHistoryId;
	private int chatId;
	private String accountId;
	private String accountId2;
	private String content;
	private Date chatDate;
	private String status;
	private String notice;
	private String name;
}
