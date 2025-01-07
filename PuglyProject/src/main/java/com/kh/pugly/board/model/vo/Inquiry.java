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

	private Long inquiryNo;
	private Long inquiryWriter;

	private String nickname;
	private String inquiryTitle;
	private String inquiryContent;
	private String createDate;
	private String answerStatus;
	private int inquiryGroup;
	private String status;
	private int count;
	private String inquiryPassword;
}
