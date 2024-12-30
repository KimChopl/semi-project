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

	void updateMember(Member member, Member loginMember);
	
	void deleteMember(Map<String, Object> map);

	List<Address> selectAdresses(Long memberNo);
	
	Image selectMemberImage(Long memberNo);
	
	Map<String, Object> selectStateCategory();

	



	
}
