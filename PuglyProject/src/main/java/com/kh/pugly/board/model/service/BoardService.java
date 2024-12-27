package com.kh.pugly.board.model.service;

<<<<<<< Updated upstream

import java.util.Map;

=======
import java.util.Map;

>>>>>>> Stashed changes
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.board.model.vo.Board;

public interface BoardService {
		
	// 게시판 생성
	void insertBoard(Board board, MultipartFile upfile);
	
	// 게시판 수정
	void updateBoard(Board board, MultipartFile upfile);
	
	// 게시판 삭제
	void deleteBoard(Long boardNo, String changeName);
	
	// 리스트 조회
	Map<String, Object> selectBoardList(int currentPage);
	
	// 아이디검색
	Map<String, Object> selectById(Long boardNo);
	
	// 검색 조회
	Map<String, Object> selectByKeyword(String keyword);
}
