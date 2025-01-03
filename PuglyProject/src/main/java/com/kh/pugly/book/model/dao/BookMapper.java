package com.kh.pugly.book.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.book.model.dto.BookCondition;
import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.book.model.vo.BookStatus;

@Mapper
public interface BookMapper {
	
	int insertBook(Book book);
	
	int insertDecide(BookCondition condition);
	
	int insertPay(BookCondition condition);
	
	int insertCancel(BookCondition condition);
	
	int insertPlay(Long bookNo);
	
	List<Book> selectBookList(RowBounds rb, Long memberNo);
	
	int bookListCount(Long MemberNo);
	
	BookStatus selectBookDecide(Long bookNo);
	
	BookStatus selectBookCancel(Long bookNo);
	
	BookStatus selectBookPay(Long bookNo);
	
	Long selectBookPlay(Long bookNo);

	List<Book> selectBookListFarmer(RowBounds rb, Long memberNo);

	int selectBookCountFarmer(Long memberNo);

}
