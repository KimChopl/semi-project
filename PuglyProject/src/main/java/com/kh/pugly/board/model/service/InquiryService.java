package com.kh.pugly.board.model.service;

import java.util.List;

import com.kh.pugly.board.model.vo.Inquiry;

public interface InquiryService {
	
	// 문의글 생성
	void insertInquiry(Inquiry inquiry);
	
	// 문의글 삭제
	void deleteInquiry(Long inquiryNo);
	
	// 리스트 조회
	List<Inquiry> selectInquiryList(int currentPage);
	
	// 아이디검색
	Inquiry selectById(Long inquiryNo);
	
	// 검색 조회
	List<Inquiry> selectByKeyword(String keyword);

}
