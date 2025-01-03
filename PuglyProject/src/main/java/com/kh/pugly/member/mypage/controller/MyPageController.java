package com.kh.pugly.member.mypage.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.member.mypage.model.service.MyPageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MyPageController {

	private final ModelAndViewUtil mv;
	private final MyPageService myPageService;
	
	@GetMapping("select.cart")
	public ModelAndView selectCartList(Long memberNo, @RequestParam(defaultValue="1") int currentPage) {
		//log.info("{}", currentPage);
		
		Map<String, Object> map = myPageService.selectCart(memberNo, currentPage);
		return mv.setViewNameAndData("member/my_cart", map);
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
