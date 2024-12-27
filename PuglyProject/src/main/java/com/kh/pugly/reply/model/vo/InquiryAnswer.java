package com.kh.pugly.reply.model.vo;

import lombok.NoArgsConstructor;

import lombok.Setter;
import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Setter
@NoArgsConstructor
@ToString
@AllArgsConstructor
@Builder
public class InquiryAnswer {
	private int inquiryAnswerNo;
	private String inquiryAnswer;
	private int refIno;
	private String writer;
	private String createDate;
	private String status;
}

