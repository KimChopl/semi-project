package com.kh.pugly.member.mypage.model.service;

import java.util.Map;

public interface MyPageService {

	
	Map<String, Object> selectCart(Long memberNo, int currentPage);
	
	Map<String, Object> selectMyFarmList(Long memberNo, int currentPage);
}
