package com.kh.pugly.book.model.vo;

import java.sql.Date;

import com.kh.pugly.common.model.vo.Image;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Book {
	private Long bookNo;
	private Long farmNo;
	private String nickname;
	private Long memberNo;
	private Date bookDate;
	private Date playDate;
	private int adultNo;
	private int kidNo;
	private String bookContent;
	private String farmTitle;
	private String bookSub;
	private String phone;
	private String decide;
	private String cancel;
	private String play;
	private String pay;
	
	private Image image;
}
