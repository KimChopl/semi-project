package com.kh.pugly.member.common;

import org.springframework.stereotype.Component;

import com.kh.pugly.exception.ComparedPasswordException;
import com.kh.pugly.exception.ExistingMemberIdException;
import com.kh.pugly.exception.InvalidRequestException;
import com.kh.pugly.exception.NoExistentMemberException;
import com.kh.pugly.exception.TooLargeValueException;
import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.service.PasswordEncoder;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ValidateMember {

	private final MemberMapper mapper;
	private final PasswordEncoder passwordEncrypt;
	
	public void validationMember(Member member) {
		if(20 <= member.getMemberId().length() || 25 <= member.getMemberPwd().length()) {
			throw new TooLargeValueException("지나치게 큰 값");
		}
		
		if("".equals(member.getMemberId().trim()) || "".equals(member.getMemberPwd().trim())) {
			throw new InvalidRequestException("유효하지 않은 값");
		}
	}
	
	public void noExistingMember(Member member) {
		if(member == null) {
			throw new NoExistentMemberException("존재하지 않는 회원입니다.");
		}
	}
	
	public void invalidRequestMemberNo(Long memberNo, Long userNo) {
		if(memberNo != userNo) {
			throw new InvalidRequestException("유효하지 않은 요청");
		}
	}
	
	public void validationPassword(Member member) {
		if(member.getMemberPwd().length() >= 25) {
			throw new TooLargeValueException("비밀번호가 너무 김");
		}
		
		if("".equals(member.getMemberPwd().trim())) {
			throw new InvalidRequestException("유효하지 않은 값");
		}
	}
	
	public void existingMemberId(Member member) {
		if(mapper.checkMemberId(member) != 0) {
			throw new ExistingMemberIdException("이미 있는 아이디 입니다.");
		}
	}
	
	public void checkPwd(Member member, Member loginUser) {
		if(!(passwordEncrypt.matches(member.getMemberPwd(), loginUser.getMemberPwd()))) {
			throw new ComparedPasswordException("비밀번호가 일치하지 않습니다.");
		}
	}
	
	public void checkMember(Member member, Member loginMember) {
		if(loginMember == null ||
		   loginMember.getCategoryNo() != member.getCategoryNo() ||
		  !loginMember.getPhone().equals(member.getPhone())) {
				throw new NoExistentMemberException("회원을 찾을 수 없습니다.");
		}
	}
	
}
