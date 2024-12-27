package com.kh.pugly.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.exception.ExistingMemberIdException;
import com.kh.pugly.exception.InvalidRequestException;
import com.kh.pugly.exception.NoExistentMemberException;
import com.kh.pugly.exception.TooLargeValueException;
import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpi implements MemberService {

	private final MemberMapper mapper;
	//private final PasswordEncoder passwordEncrypt;
	
	private void validationMember(Member member) {
		if(20 <= member.getMemberId().length() || 25 <= member.getMemberPwd().length()) {
			throw new TooLargeValueException("지나치게 큰 값");
		}
		
		if("".equals(member.getMemberPwd().trim())) {
			throw new InvalidRequestException("유효하지 않은 요청");
		}
	}
	
	private void existingMemberId(Member member) {
		Member checkMember = selectMember(member);
		if(checkMember != null) {
			throw new ExistingMemberIdException("이미 존재하는 아이디입니다.");
		}
	}
	
	
	
	@Override
	public Member selectMember(Member member) {
		// 잠시 테스트
		
		validationMember(member);
		
		
		
		Member loginUser = mapper.selectMember(member);
		
		if(loginUser == null) {
			throw new NoExistentMemberException("존재하지 않는 회원입니다.");
		}
		
		
		// 암호화를 모두 끝내면 하기
		/*
		if(passwordEncoder.matches(member.getMemberPwd(), loginUser.getMemberPwd())) {
			throw new ComparedPasswordException("비밀번호가 일치하지 않습니다.");
		}
		*/
		
		
		// 아이디가 20자가 넘는다.
		// 비밀번호가 25자가 넘는다.
		
		return loginUser;
			}
	
	@Override
	public List<Address> selectAdresses(Long memberNo) {
		return mapper.selectAddresses(memberNo);
	}
	
	@Override
	public Map<String, Object> selectStateCategory() {
		
		Map<String, Object> responseData = new HashMap();
		List<Address> category = mapper.selectStateCategory();
		responseData.put("stateCategory", category);
		
		return responseData;
	}
	
	@Override
	public void insertMember(Member member) {
		// 아이디가 20자가 넘는다.
		// 비밀번호가 25자가 넘는다.
		// 닉네임을 입력하지 않았다.
		existingMemberId(member);
		
		

	}
	
	
	@Override
	public void insertAddress(Address address) {
		
		
	}

	@Override
	public void updateMember(Member member, Member loginMember) {
		// 경우의 수 member의 비밀번호가 25자를 넘어간다. 
		// hidden 으로 넘긴 memberNo가 session의 memberNo와 일치하지 않는다.
		
		if(member.getMemberPwd().length() >= 25) {
			throw new TooLargeValueException("비밀번호가 너무 김");
		}
		
		if("".equals(member.getMemberPwd().trim())) {
			throw new InvalidRequestException("유효하지 않은 요청");
		}
		
		if(member.getMemberNo() != loginMember.getMemberNo()) {
			throw new InvalidRequestException("유효하지 않은 요청");
		}
		
		
		
	}

	@Override
	public void deleteMember(Map<String, Object> map) {
		

	}



}
