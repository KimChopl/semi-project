package com.kh.pugly.board.model.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.board.model.vo.Board;

public interface BoardService {
		
	// 게시판 생성
	void insertBoard(Board board, MultipartFile upfile);
	
	// 게시판 수정
	void updateBoard(Board board, MultipartFile upfile);
	
	// 게시판 삭제
	void deleteBoard(Long boardNo);
	
	// 리스트 조회
	Map<String, Object> selectBoardList(int currentPage, String sortType);
	
	// 아이디검색
	Map<String, Object> selectById(Long boardNo);
	
	Map<String, Object> searchBoard(Map<String, Object> map);

}
