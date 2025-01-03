package com.kh.pugly.book.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.pugly.book.model.dao.BookMapper;
import com.kh.pugly.book.model.dto.BookCondition;
import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.exception.BoardNotFoundException;
import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BookServiceImpl implements BookService {

	private final BookMapper bm;
	private final MemberMapper mm;
	
	
	private void checkedMember(Member loginUser) {
		Member checkMember = mm.selectMemberInfo(loginUser.getMemberNo());
		
		if(!!!loginUser.getMemberId().equals(checkMember.getMemberId()) || loginUser.getMemberNo() != checkMember.getMemberNo() || !!loginUser.getNickName().equals(checkMember.getNickName())
				|| !!!loginUser.getMemberName().equals(checkMember.getMemberName())) {
			//Exception
		}
		
	}
	
	private void checkedInsertBook(int result) {
		if(result < 1) {
			throw new BoardNotFoundException("??");
		}
	}
	
	private Book insertBookToMember(Book book, Member loginUser) {
		book.setUserNickname(String.valueOf(loginUser.getMemberNo()));
		
		return book;
	}
	
	@Override
	public void insertBook(Book book, Member loginUser) {
		checkedMember(loginUser);
		Book newBook = insertBookToMember(book, loginUser);
		int result = bm.insertBook(newBook);
		log.info("{}", newBook);
		checkedInsertBook(result);
		}

	@Override
	public void insertDecide(BookCondition condition) {

	}

	@Override
	public void insertPay(BookCondition condition) {

	}

	@Override
	public void insertCancel(BookCondition condition) {

	}

	@Override
	public void insertPlay(Long bookNo) {

	}

	@Override
	public List<Book> selectBookList(RowBounds rb, Long memberNo) {
		return null;
	}

}
