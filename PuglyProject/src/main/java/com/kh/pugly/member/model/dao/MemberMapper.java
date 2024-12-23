package com.kh.pugly.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.member.model.vo.Member;

@Mapper
public interface MemberMapper {

	Member selectMember(Member member);
	
	int insertMember(Member member);
	
	int updateMember(Member member);
	
	int deleteMember(Map<String, Object> map);
	
	List<Address> selectAddresses(Long memberNo);
	
	List<Address> selectStateCategory();
	
}
