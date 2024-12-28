package com.kh.pugly.board.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
@AllArgsConstructor
@Builder
public class Inquiry {
	private int inquiryNo;
	private int inquiryWriter;
	private String writerNickname;
	private String inquiryTitle;
	private String inquiryContent;
	private String createDate;
	private String answerStatus;
	private String status;
}
