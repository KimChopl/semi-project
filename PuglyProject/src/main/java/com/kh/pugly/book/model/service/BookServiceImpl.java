package com.kh.pugly.book.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.pugly.book.model.dao.BookMapper;
import com.kh.pugly.book.model.dto.BookCondition;
import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.book.model.vo.BookStatus;
import com.kh.pugly.common.model.vo.MoreInfo;
import com.kh.pugly.common.template.MoreInfomation;
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
		book.setNickname(String.valueOf(loginUser.getMemberNo()));
		
		return book;
	}
	
	@Override
	public void insertBook(Book book, Member loginUser) {
		checkedMember(loginUser);
		Book newBook = insertBookToMember(book, loginUser);
		int result = bm.insertBook(newBook);
		//log.info("{}", newBook);
		checkedInsertBook(result);
		}

	@Override
	public void insertDecide(Long bookNo, Member member) {
		checkedMember(member);
		int result = bm.insertDecide(bookNo);
		checkedInsert(result);
	}

	private void checkedInsert(int result) {
		if(result < 1) {
			//Exception
		}
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
	
	private MoreInfo checkedListCount(int bookLimit, int moreNo, int listCount) {
		if(listCount == 0) {
			return null;
		}
		MoreInfo mi = MoreInfomation.getMoreInfo(listCount, moreNo, bookLimit);
		return mi;
	}
	
	
	
	
	private List<Book> makeTitle(List<Book> books){
		for(int i = 0; i < books.size(); i++) {
			String bookSub = books.get(i).getBookContent();
			if(bookSub.length() > 30) {
				books.get(i).setBookSub(bookSub.substring(0, 30));
			} else {
				books.get(i).setBookSub(bookSub);
			}
		}
		return books;
	}
	
	private Map<String, Object> selectbookStatus(List<Book> books) {
		log.info("{}", books);
		Map<String, Object> bookStatus = new HashMap();
		bookStatus.put("books", books);
		
		return bookStatus;
	}
	
	private MoreInfo checkedType(Member member) {
		int category = member.getCategoryNo();
		int listCount = 0;
		int bookLimit = 5;
		int moreNo = 0;
		Long memberNo = member.getMemberNo();
		if(category == 2) {
			listCount = bm.selectBookCountFarmer(memberNo);
		} else {
			listCount = bm.bookListCount(memberNo);
		}
		return checkedListCount(bookLimit, moreNo, listCount);
	}
	
	private List<Book> checkedMember(Member member, RowBounds rb) {
		int category = member.getCategoryNo();
		Long memberNo = member.getMemberNo();
		List<Book> books = null;
		if(category == 2) {
			books = selectBookListFarmer(memberNo, rb);
		} else {
			books = selectBookListBooker(memberNo, rb);
		}
		//log.info("{} : {}", books, category);
		
		return books;
	}
	
	private List<Book> selectBookListFarmer(Long memberNo, RowBounds rb) {
		return bm.selectBookListFarmer(rb, memberNo);
	}
	
	private List<Book> selectBookListBooker(Long memberNo, RowBounds rb) {
		return bm.selectBookList(rb, memberNo);
	}
	
	@Override
	public Map<String, Object> selectBookList(Member loginUser) {
		checkedMember(loginUser);
		MoreInfo mi = checkedType(loginUser);
		RowBounds rb = makeRowBounds(mi);
		Map<String, Object> map = selectbookStatus(makeTitle(checkedMember(loginUser, rb)));
		map.put("mi", mi);
		//log.info("{}", map);
		
		
		
		return map;
	}

	private RowBounds makeRowBounds(MoreInfo mi) {
		return new RowBounds(mi.getPlusNo(), mi.getBoardLimit());
	}

	@Override
	public Book selectByNo(Long bookNo, Member member) {
		checkedMember(member);
		Book book = checkedContent(bookNo);
		book.setPhone(member.getPhone());
		//log.info("{}", book);
		return book;
	}

	private Book checkedContent(Long bookNo) {
		Book book = bm.selectByNo(bookNo);
		if(book == null) {
			//Exception
		}
		return book;
	}

}
