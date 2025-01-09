package com.kh.pugly.review.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.pugly.review.model.service.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AjaxReviewController {

	private final ReviewService rs;
	
	@GetMapping(value="review", produces="application/json; charset=UTF-8") //일로 와야할게(12.31)
	@ResponseBody
	public Map<String, Object> selectMoreReview(int plusNo, Long farmNo) {
		return rs.selectMoreReview(plusNo, farmNo);
	}
	
}
