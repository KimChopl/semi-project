package com.kh.pugly.exception.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.exception.BoardNotFoundException;
import com.kh.pugly.exception.ComparedPasswordException;
import com.kh.pugly.exception.ExistingMemberIdException;
import com.kh.pugly.exception.InvalidParameterException;
import com.kh.pugly.exception.NoExistentMemberException;
import com.kh.pugly.exception.TooLargeValueException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class ExceptionHandlingController {
	
	private ModelAndView createErrorResponse(String errorMsg, Exception e) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("errorMsg", errorMsg)
		  .setViewName("common/error_page");
		log.info("발생예외 : {}", e.getMessage(), e);
		return mv;
	}
	
	@ExceptionHandler(TooLargeValueException.class)
	protected ModelAndView tooLargeValueError(TooLargeValueException e) {
		return createErrorResponse("지나치게 많은 값을 입력하셨습니다", e);
	}
	
	@ExceptionHandler(ExistingMemberIdException.class)
	protected ModelAndView existingMemberIdError(ExistingMemberIdException e) {
		return createErrorResponse("이미 존재하는 아이디입니다.", e);
	}
	
	@ExceptionHandler(NoExistentMemberException.class)
	protected ModelAndView noExistentMemberError(NoExistentMemberException e) {
		return createErrorResponse("회원이 존재하지 않습니다.", e);
	}
	
	@ExceptionHandler(ComparedPasswordException.class)
	protected ModelAndView comparedPasswordError(ComparedPasswordException e) {
		return createErrorResponse("비밀번호가 일치하지 않습니다.", e);
	}
	
	@ExceptionHandler(BoardNotFoundException.class)
	protected ModelAndView noSearchBoardError(BoardNotFoundException e) {
		return createErrorResponse("게시판이 존재하지 않습니다.", e);
	}
	
	@ExceptionHandler(InvalidParameterException.class)
	protected ModelAndView invalidParameterError(InvalidParameterException e) {
		return createErrorResponse("장난으로 입력하시면 오류가 발생합니다.", e);
	}
	
	
	
	
	
	
}
