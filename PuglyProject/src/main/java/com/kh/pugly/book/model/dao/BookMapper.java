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
	
	int insertDecide(Long bookNo);
	
	int insertPay(Long bookNo);
	
	int insertCancel(BookCondition condition);
	
	int insertPlay(Long bookNo);
	
	List<Book> selectBookList(RowBounds rb, Long memberNo);
	
	int bookListCount(Long MemberNo);
	
	List<Book> selectBookListFarmer(RowBounds rb, Long memberNo);

	int selectBookCountFarmer(Long memberNo);

	Book selectByNo(Long bookNo);

}
