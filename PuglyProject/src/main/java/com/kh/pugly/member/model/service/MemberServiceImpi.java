package com.kh.pugly.member.model.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.vo.Member;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpi implements MemberService {

	private MemberMapper mapper;
	
	@Override
	public Member selectMember(Member member) {
		if("".equals(member.getMemberId()){
			
		}
		
		Member loginMember = mapper.selectMember(member); 
		return loginMember;
	}

	@Override
	public void insertMember(Member member) {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateMember(Member member) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteMember(Map<String, Object> map) {
		// TODO Auto-generated method stub

	}

}
