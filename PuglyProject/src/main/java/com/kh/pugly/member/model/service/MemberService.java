package com.kh.pugly.member.model.service;

import java.util.Map;

import com.kh.pugly.member.model.vo.Member;

public interface MemberService {

	Member selectMember(Member member);
	
	void insertMember(Member member);
	
	void updateMember(Member member);
	
	void deleteMember(Map<String, Object> map);
	
}
