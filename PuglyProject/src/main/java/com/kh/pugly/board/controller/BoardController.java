package com.kh.pugly.board.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.board.model.service.BoardService;
import com.kh.pugly.common.ModelAndViewUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {
	
	private final BoardService boardService;
	private final ModelAndViewUtil mv;
	
	
	@GetMapping("boards")
	public ModelAndView selectBoardList(@RequestParam(value = "page", defaultValue = "1")int page) {
		//Map<String, Object> map = boardService.selectBoardList(page);
		
		return mv.setViewNameAndData("board/list2", null);
	}

}
