package com.kh.pugly.book.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.book.model.dto.BookCondition;
import com.kh.pugly.book.model.vo.Book;

public interface BookService {
	
	void insertBook(Book book);
	
	void insertDecide(BookCondition condition);
	
	void insertPay(BookCondition condition);
	
	void insertCancel(BookCondition condition);
	
	void insertPlay(Long bookNo);
	
	List<Book> selectBookList(RowBounds rb, Long memberNo);
}
