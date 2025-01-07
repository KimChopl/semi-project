package com.kh.pugly.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.board.model.service.InquiryService;
import com.kh.pugly.board.model.vo.Inquiry;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class InquiryController {
	private final InquiryService inquiryService;
	
	@GetMapping("inquiries")
	public ModelAndView selectinquiryList(@RequestParam(value = "page", defaultValue = "1")int page) {
		List<Inquiry> inquiryList = inquiryService.selectInquiryList(page);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("inquiry/list");
		mv.addObject("inquiries", inquiryList);
		
		return mv;
	}
	
	@GetMapping("inquiries/{id}")
	public ModelAndView selectById(@PathVariable(name="id") Long inquiryNo) {
		Inquiry responsData = inquiryService.selectById(inquiryNo);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("inquiry/detail");
	    mv.addObject("inquiry", responsData); // 모델에 데이터를 추가
	    return mv;
	}
	
	@GetMapping("insertInquiryForm")
	public String insertForm() {
		return "inquiry/insert_form";
	}
	
	@PostMapping("inquiries")
	public ModelAndView save(Inquiry inquiry, HttpSession session) {
		inquiryService.insertInquiry(inquiry);
		session.setAttribute("altMsg", "문의글 등록 성공");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:inquiries");
		return mv;
	}
	
	@PostMapping("inquiries/delete")
	public ModelAndView deleteInquiry(Long inquiryNo) {
		inquiryService.deleteInquiry(inquiryNo);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:inquiries");
		
		return mv;
	}
	
	@GetMapping("inquiries/search")
	public Map<String, Object> searchInquiry(@RequestParam("condition") String condition, 
									@RequestParam("keyword") String keyword,
									@RequestParam(value = "page", defaultValue = "1") int page) {
		
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("page", page);
	    map.put("condition", condition);
	    map.put("keyword", keyword);      
		
		Map<String, Object> searchResult = inquiryService.searchInquiry(map);
		
	   return searchResult;
	}

}
