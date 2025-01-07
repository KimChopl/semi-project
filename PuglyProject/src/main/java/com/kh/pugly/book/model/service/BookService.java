package com.kh.pugly.book.model.service;

import java.util.Map;


import com.kh.pugly.book.model.dto.BookCondition;
import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.member.model.vo.Member;

public interface BookService {
	
	void insertBook(Book book, Member loginUser);
	
	void insertDecide(Long bokkNo, Member member);
	
	void insertPay(BookCondition condition);
	
	void insertCancel(BookCondition condition);
	
	void insertPlay(Long bookNo);
	
	Map<String, Object> selectBookList(Member loginUser);

	Book selectByNo(Long bookNo, Member member);
}
