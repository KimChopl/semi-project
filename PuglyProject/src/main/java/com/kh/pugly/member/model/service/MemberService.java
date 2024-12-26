package com.kh.pugly.member.model.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.member.model.vo.Member;

public interface MemberService {

	Member selectMember(Member member);
	
	void insertMember(Member member);
	
	void updateMember(Member member, HttpSession session);
	
	void deleteMember(Map<String, Object> map);

	List<Address> selectAdresses(Long memberNo);
	
	List<Address> selectStateCategory();

	
}
