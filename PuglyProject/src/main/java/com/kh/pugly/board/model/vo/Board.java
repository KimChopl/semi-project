package com.kh.pugly.board.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {
	private Long boardNo;
	private int boardWriter;
	private String nickName;
	private String boardTitle;
	private String boardContent;
	private int mainCategory;
	private int count;
	private String createDate;
	private String status;
}
