package com.kh.pugly.review.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.member.model.vo.Member;
import com.kh.pugly.review.model.service.ReviewService;
import com.kh.pugly.review.model.vo.Review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ReviewController {
	
	private final ReviewService rs;
	private final ModelAndViewUtil mv;
	
	@GetMapping("review/post/{farmNo}/{bookNo}")
	public ModelAndView loadReview(@PathVariable(name="farmNo") Long farmNo, @PathVariable(name="bookNo") Long bookNo, HttpSession ssn) {
		Member member = (Member)ssn.getAttribute("loginUser");
		Map<String, Object> map = rs.loadReivew(farmNo, bookNo, member);
		
		
		return mv.setViewNameAndData("review/insert_review", map);
	}
	
	@PostMapping("insert.review")
	public String insertReview(Review review, MultipartFile[] files, HttpSession ssn) {
		Member member = (Member)ssn.getAttribute("loginUser");
		rs.insertReview(review, files, member);
		ssn.setAttribute("alertMsg", "리뷰 등록에 성곻했습니다.");
		return "redirect:/farms";
	}
	
	
	
}
