package com.kh.pugly.book.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.book.model.service.BookService;
import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.farm.model.service.FarmService;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BookController {

	private final ModelAndViewUtil mv;
	private final FarmService fs;
	private final BookService bs;
	
	@PostMapping("book")
	public ModelAndView insertBook(Long farmNo, int kid, int adult, String bookDate) {
		//System.out.println(farmNo + ", " + kid + ", " + adult + ", " + bookDate);
		Map<String, Object> map = new HashMap();
		Farm farm = fs.selectBookFarm(farmNo);
		map.put("farm", farm);
		map.put("adult", adult);
		map.put("kid", kid);
		map.put("bookDate", bookDate);
		return mv.setViewNameAndData("book/insert-book", map);
	}
	
	@PostMapping("book/booking")
	public ModelAndView booking(Book book, HttpSession ssn) {
		Member loginUser = (Member)ssn.getAttribute("loginUser");
		//log.info("{}", book);
		bs.insertBook(book, loginUser);
		ssn.setAttribute("alertMsg", "예약 완료. 승인 대기 중입니다.");
		return mv.setViewNameAndData("redirect:/farms", null);
	}
	
	@GetMapping("list.book")
	public ModelAndView bookList(HttpSession ssn) {
		Member m = (Member)ssn.getAttribute("loginUser");
		Map<String, Object> map = bs.selectBookList(m);
		return mv.setViewNameAndData("book/list-book", map);
	}
	
}