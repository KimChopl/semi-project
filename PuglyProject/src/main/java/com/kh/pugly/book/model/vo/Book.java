package com.kh.pugly.book.model.vo;


import java.sql.Date;

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
	private Long bookFarmNo;
	private String userNickname;
	private Date bookDate;
	private Date playDate;
	private String bookCheck;
	private String bookCancel;
	private String bookPay;
	private String playCheck;
	private String bookComplete;
	private int adultNo;
	private int kidNo;
	private String deletePlayer;
	private String deleteSeller;
}
