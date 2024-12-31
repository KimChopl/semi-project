package com.kh.pugly.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.member.model.vo.Member;

@Mapper
public interface MemberMapper {

	Member selectMember(Member member);
	
	Image selectMemberImage(Long memberNo);
	
	List<Address> selectStateCategory();
	
	List<Address> selectAddresses(Long memberNo);
	
	int insertMember(Member member);
	
	int insertAddress(Address address);
	
	int insertMemberImage(Image image);
	
	int updateMember(Member member);
	
	int updateMemberImage(Map<String, Object> ImageInfo);
	
	int updateMemberInsertImage(Map<String, Object> imageInfo);

	int updateAddress(Map<String, Object> addressInfo);
	
	int deleteMember(Member member);
	
	
	

	
}
