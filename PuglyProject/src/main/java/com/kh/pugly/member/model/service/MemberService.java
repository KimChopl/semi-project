package com.kh.pugly.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.member.model.vo.Member;

public interface MemberService {

	Member selectMember(Member member);
	
	void insertMember(Member member, Address address, MultipartFile upfile);

	Member updateMember(Member member, Member loginMember, MultipartFile upfile);
	
	void deleteMember(Member member, Member loginUser);
	
	Map<String, Object> selectCategory();
	
	Map<String, Object> findMemberId(Member member);
	
	Map<String, Object> findMemberPassword(Member member);
	
	void changePassword(Member member);

	void updateAddress(Long memberNo, Long userNo, Address address);
	
	void insertNewAddress(Long memberNo, Long userNo, Address address);

	Map<String, Object> selectMemberAddresses(Long memberNo);
	
	Map<String, Object> selectMemberInfo(Long memberNo);

	void deleteAddress(Long memberNo, Long userNo, Long addressNo);

	



	
}
