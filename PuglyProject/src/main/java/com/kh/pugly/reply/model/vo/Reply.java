package com.kh.pugly.reply.model.vo;

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
public class Reply {
	private Long replyNo;
	private int refBno;
	private String Nicname;
	private String reply_content;
	private String createDate;
	private String status;

}
