package com.kh.pugly.member.mypage.model.service;

import java.util.Map;

public interface MyPageService {

	
	Map<String, Object> selectCart(Long memberNo, int currentPage);
	
	Map<String, Object> selectMyFarmList(Long memberNo, int currentPage);
	
	Map<String, Object> selectMyBookList(Long memberNo, int currentPage);
	
	Map<String, Object> selectMyBoardList(Long memberNo, int currentPage);

	Map<String, Object> selectMyReplyList(Long memberNo, int currentPage);
	
	Map<String, Object> selectMyProductList(Long memberNo, int currentPage);
	
	Map<String, Object> selectMyAttentionList(Long memberNo, int currentPage);
}
