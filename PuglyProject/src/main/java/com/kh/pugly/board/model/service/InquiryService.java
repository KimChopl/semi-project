package com.kh.pugly.board.model.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.kh.pugly.board.model.vo.Inquiry;

public interface InquiryService {
	
	// 문의글 생성
	void insertInquiry(Inquiry inquiry, HttpSession session);
	
	// 문의글 삭제
	void deleteInquiry(Long inquiryNo);
	
	// 리스트 조회
	Map<String, Object> selectInquiryList(int currentPage);
	
	// 아이디검색
	Inquiry selectById(Long inquiryNo);
	
	Map<String, Object> searchInquiry(Map<String, Object> map);

	boolean checkPassword(Long inquiryNo, String password);

}
