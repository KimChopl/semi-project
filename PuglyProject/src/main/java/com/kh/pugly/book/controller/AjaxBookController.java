package com.kh.pugly.book.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.pugly.book.model.service.BookService;
import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AjaxBookController {

	private final BookService bs;
	
	@GetMapping(value="book.content", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Book selectByNo(Long bookNo, HttpSession ssn){
		//log.info("{} : {}", bookNo, ssn);
		Member member = (Member)ssn.getAttribute("loginUser");
		Book book = bs.selectByNo(bookNo, member);
		return book;
	}
	
	
	
}
