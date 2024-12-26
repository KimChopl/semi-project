package com.kh.pugly.member.model.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.exception.ExistingMemberIdException;
import com.kh.pugly.exception.TooLargeValueException;
import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpi implements MemberService {

	private final MemberMapper mapper;
	
	@Override
	public Member selectMember(Member member, HttpSession session) {
		if(20 <= member.getMemberId().length() || 25 <= member.getMemberPwd().length()) {
			// 다른 클래스로 뺄 것
			throw new TooLargeValueException("지나치게 큰 값");
		}
		
		Member loginUser = mapper.selectMember(member);
		
		if(loginUser == null) {
			throw new NoMemberException
		}
		
		session.setAttribute("loginUser", loginUser);
		session.setAttribute("addresses", selectAdresses(loginUser.getMemberNo()));
		
		// 아이디가 20자가 넘는다.
		// 비밀번호가 25자가 넘는다.
		
		return 
	}
	
	@Override
	public List<Address> selectAdresses(Long memberNo) {
		return mapper.selectAddresses(memberNo);
	}
	
	@Override
	public List<Address> selectStateCategory() {
		return mapper.selectStateCategory();
	}
	
	@Override
	public void insertMember(Member member) {
		// 아이디가 20자가 넘는다.
		// 비밀번호가 25자가 넘는다.
		// 닉네임을 입력하지 않았다.
		Member checkMember = selectMember(member);
		if(checkMember != null) {
			throw new ExistingMemberIdException("이미 존재하는 아이디입니다.");
		}
		
		

	}

	@Override
	public void updateMember(Member member, HttpSession session) {
		// 경우의 수 member의 비밀번호가 25자를 넘어간다. 
		// hidden 으로 넘긴 memberNo가 session의 memberNo와 일치하지 않는다.
	}

	@Override
	public void deleteMember(Map<String, Object> map) {
		// TODO Auto-generated method stub

	}


}
