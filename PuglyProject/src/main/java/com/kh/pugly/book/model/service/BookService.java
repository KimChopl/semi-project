package com.kh.pugly.book.model.service;

import java.util.Map;


import com.kh.pugly.book.model.dto.BookCondition;
import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.member.model.vo.Member;

public interface BookService {
	
	void insertBook(Book book, Member loginUser);
	
	void insertDecide(Long bokkNo, Member member);
	
	void insertPay(BookCondition condition);
	
	void insertPlay(Long bookNo, Member member);
	
	Map<String, Object> selectBookList(Member loginUser, int plusNo);

	Book selectByNo(Long bookNo, Member member);

	void insertCancel(Long bookNo, String content, Member member);
}
