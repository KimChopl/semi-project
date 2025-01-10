package com.kh.pugly.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.member.model.vo.Member;

@Mapper
public interface MemberMapper {

	// 로그인
	Member selectMember(Member member);
	
	// 로그인유저의 프로필사진 가져오기
	Image selectMemberImage(Long memberNo);
	
	// 전체 stateCategory 가져오기
	List<Address> selectStateCategory();
	
	// 전체 memberType 가져오기
	List<Member> selectMemberCategory();
	
	// 로그인 유저의 전체 주소 리스트 가져오기(주소 수정페이지)
	List<Address> selectAddresses(Long memberNo, RowBounds rowBounds);
	
	// 로그인 유저의 리스트(마이페이지 출력)
	List<Address> selectInfoAddresses(Long memberNo);
	
	int checkMemberId(Member member);
	
	// 페이징 처리(주소)
	int selectAddressCount(Long memberNo);
	
	// 아이디 찾기
	List<Member> findMemberId(Member member);
	
	// 회원가입(회원추가)
	int insertMember(Member member);
	// 회원가입(주소추가)
	int insertAddress(Address address);
	// 회원가입(프로필사진추가)
	int insertMemberImage(Image image);
	
	// 회원 정보수정(회원)
	int updateMember(Member member);
	// 회원정보수정(전의 프로필사진 삭제(status = 'N'))
	int updateMemberImage(Map<String, Object> ImageInfo);
	// 회원정보수정(프로필사진추가)
	int updateMemberInsertImage(Map<String, Object> imageInfo);
	
	// 주소변경
	int updateAddress(Map<String, Object> map);
	// 새 주소 추가
	int insertNewAddress(Map<String, Object> address);
	// 주소 삭제
	int deleteAddress(Map<String, Object> map);
	// 메인주소로 바뀔 때 필요한 작업
	int updateAddressType(Long memberNo);
	
	List<Address> selectAddresses(Long memberNo);
	// 회원탈퇴
	int deleteMember(Member member);
	
	// 유저 정보 가져오기
	Member selectMemberInfo(Long memberNo);
	

	
}
