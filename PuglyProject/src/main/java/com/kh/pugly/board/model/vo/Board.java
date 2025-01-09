package com.kh.pugly.board.model.vo;

import com.kh.pugly.common.model.vo.Image;

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
	private Long boardWriter;
	private String nickname;
	private String boardTitle;
	private String boardContent;
	private int mainCategory;
	private int count;
	private String createDate;
	private String status;
	private Image image;
}