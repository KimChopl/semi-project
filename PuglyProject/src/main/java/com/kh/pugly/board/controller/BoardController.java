package com.kh.pugly.board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.board.model.service.BoardService;
import com.kh.pugly.board.model.vo.Board;
import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.common.model.vo.ResponseData;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService boardService;
	private final ModelAndViewUtil mv;
	
	@GetMapping("boards")
	public ModelAndView selectBoardList(@RequestParam(value = "page", defaultValue = "1")int page) {
		Map<String, Object> map = boardService.selectBoardList(page);
		
		return mv.setViewNameAndData("board/list", map);
	}
	
	@GetMapping("boards/{id}")
	public ModelAndView selectById(@PathVariable(name="id") Long boardNo) {
		Map<String, Object> responsData = boardService.selectById(boardNo);
		return mv.setViewNameAndData("board/detail", responsData);
	}
	
	@GetMapping("insertForm")
	public String insertForm() {
		return "board/insert_form";
	}
	
	@PostMapping("boards")
	public ModelAndView save(Board board, MultipartFile upfile, HttpSession session) {
		boardService.insertBoard(board, upfile);
		session.setAttribute("altMsg", "게시글 등록 성공");
		
		return mv.setViewNameAndData("redirect:boards", null);
	}
	
	@PostMapping("boards/delete")
	public ModelAndView deleteBoard(Long boardNo) {
		boardService.deleteBoard(boardNo);
		return mv.setViewNameAndData("redirect:boards", null);
	}
	
	@PostMapping("boards/update-form")
	public ModelAndView updateForm(Long boardNo) {
		Map<String, Object> map = boardService.selectById(boardNo);
		return mv.setViewNameAndData("board/update", map);
	}
	
	@PostMapping("boards/update")
	public ModelAndView updateBoard(Board board, MultipartFile upfile) {
		boardService.updateBoard(board, upfile);
		
		return mv.setViewNameAndData("redirect:/boards/"+board.getBoardNo(), null);
	}
	
	@GetMapping("boards/search")
	public Map<String, Object> searchBoard(@RequestParam("condition") String condition, 
									@RequestParam("keyword") String keyword,
									@RequestParam(value = "page", defaultValue = "1") int page) {
		
		if(keyword == null || keyword.trim().isEmpty()) {
			return Map.of("board/list", Map.of("error", "검색어를 입력해주세요."));
		}
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("page", page);
	    map.put("condition", condition);
	    map.put("keyword", keyword);      
		
		Map<String, Object> searchResult = boardService.searchBoard(map);
		
	   return searchResult;
	}

}
