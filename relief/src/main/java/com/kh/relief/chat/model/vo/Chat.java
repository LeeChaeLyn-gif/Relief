package com.kh.relief.chat.model.vo;

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
public class Chat {
	private int chatId;
	private String accountId;
	private String accountId2;
	private String chatStatus;
	private String chatStatus2;
	private String name;
}
