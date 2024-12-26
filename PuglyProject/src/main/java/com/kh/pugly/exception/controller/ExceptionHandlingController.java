package com.kh.pugly.exception.controller;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.exception.TooLargeValueException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ExceptionHandlingController {

	
	private ModelAndView createErrorResponse(String errorMsg, Exception e) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("errorMsg", errorMsg)
		  .setViewName("common/error_page");
		log.info("발생예외 : {}", e.getMessage(), e);
		return mv;
	}
	
	@ExceptionHandler(TooLargeValueException.class)
	protected ModelAndView TooLargeValueError(TooLargeValueException e) {
		return createErrorResponse("지나치게 많은 값을 입력하셨습니다", e);
	}
	
	
	
	
	
	
	
}
