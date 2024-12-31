package com.kh.pugly.book.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.farm.model.service.FarmService;
import com.kh.pugly.farm.model.vo.Farm;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BookController {

	private final ModelAndViewUtil mv;
	private final FarmService fs;
	
	@PostMapping("book")
	public ModelAndView insertBook(Long farmNo, int kid, int adult, String bookDate) {
		System.out.println(farmNo + ", " + kid + ", " + adult + ", " + bookDate);
		Map<String, Object> map = new HashMap();
		Farm farm = fs.selectBookFarm(farmNo);
		map.put("farm", farm);
		map.put("adult", adult);
		map.put("kid", kid);
		map.put("bookDate", bookDate);
		return mv.setViewNameAndData("book/insert-book", map);
	}
	
	@PostMapping("book/booking")
	public ModelAndView booking(Book book) {
		log.info("{}", book);
		return null;
	}
	
}
