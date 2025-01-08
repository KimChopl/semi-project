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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.board.model.service.InquiryService;
import com.kh.pugly.board.model.vo.Inquiry;
import com.kh.pugly.common.model.vo.PageInfo;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class InquiryController {
	private final InquiryService inquiryService;
	
	@GetMapping("inquiries")
	public ModelAndView selectinquiryList(@RequestParam(value = "page", defaultValue = "1")int page) {		
		
		Map<String, Object> result = inquiryService.selectInquiryList(page);
		List<Inquiry> inquiries = (List<Inquiry>)result.get("inquiries");
		PageInfo pageInfo = (PageInfo)result.get("pageInfo");

		ModelAndView mv = new ModelAndView();
		mv.setViewName("inquiry/list");
		mv.addObject("inquiries", inquiries);
	    mv.addObject("pageInfo", pageInfo); 
		
		return mv;
	}
	
	@GetMapping("inquiries/{id}")
	public ModelAndView selectById(@PathVariable(name="id") Long inquiryNo) {
		Inquiry responsData = inquiryService.selectById(inquiryNo);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("inquiry/detail");
	    mv.addObject("inquiry", responsData);
	    return mv;
	}
	
	@GetMapping("insertInquiryForm")
	public String insertForm() {
		return "inquiry/insert_form";
	}
	
	@PostMapping("inquiries")
	public ModelAndView save(Inquiry inquiry, HttpSession session) {
		inquiryService.insertInquiry(inquiry, session);
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
	@ResponseBody
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
	
	@PostMapping("inquiries/checkPassword")
	@ResponseBody
    public Map<String, Object> checkPassword(@RequestParam("inquiryNo") Long inquiryNo, 
			 								 @RequestParam("password") String password) {
        boolean valid = inquiryService.checkPassword(inquiryNo, password);
        
        Map<String, Object> response = new HashMap<>();
        response.put("valid", valid);
        return response;
    }

}
