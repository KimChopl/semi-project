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
	private Long inquiryAnswerNo;
	private String inquiryAnswer;
	private Long refIno;
	private String nickname;
	private String createDate;
	private String status;
}
