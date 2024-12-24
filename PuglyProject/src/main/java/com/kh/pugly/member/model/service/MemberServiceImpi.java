package com.kh.pugly.member.model.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpi implements MemberService {

	private final MemberMapper mapper;
	
	@Override
	public Member selectMember(Member member) {
		return mapper.selectMember(member);
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
