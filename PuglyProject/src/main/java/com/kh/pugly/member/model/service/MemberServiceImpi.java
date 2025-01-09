package com.kh.pugly.member.model.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.login.FailedLoginException;
import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
import com.kh.pugly.exception.ComparedPasswordException;
import com.kh.pugly.exception.ExistingMemberIdException;
import com.kh.pugly.exception.FailDeleteAddressException;
import com.kh.pugly.exception.FailDeleteMemberException;
import com.kh.pugly.exception.FailInsertAddressException;
import com.kh.pugly.exception.FailInsertMemberException;
import com.kh.pugly.exception.FailToFileUploadException;
import com.kh.pugly.exception.FailUpdateMemberException;
import com.kh.pugly.exception.InvalidRequestException;
import com.kh.pugly.exception.NoExistentMemberException;
import com.kh.pugly.exception.TooLargeValueException;
import com.kh.pugly.member.common.ValidateMember;
import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@EnableTransactionManagement
public class MemberServiceImpi implements MemberService {

	private final MemberMapper mapper;
	private final ServletContext context;
	private final PasswordEncoder passwordEncrypt;
	private final ValidateMember validateUser;
	
	
	
	private Image memberImgSave(MultipartFile upfile) {
		if(!upfile.isEmpty()) {
			String fileName = upfile.getOriginalFilename(); // 각 파일의 원본 파일 이름
			String ext = fileName.substring(fileName.lastIndexOf(".")); // 확장자 추출
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			int randomNum = (int)(Math.random() * 90000) + 10000; // 랜덤번호생성
			String changeName = currentTime + randomNum + ext; // 새로운 파일 이름
			String savePath = context.getRealPath("/resources/member_profile/"); // 저장경로
			try {
				upfile.transferTo(new File(savePath + changeName)); //파일을 지정된 경로에 저장
			} catch (IOException e) {
				throw new FailToFileUploadException("파일을 업로드하지 못했습니다.");
			}
			// 이미지 파일 정보
			Image image = new Image();
			image.setOriginImgName(fileName); // 원본 파일
			image.setChangeImgName("/pugly/resources/member_profile/" + changeName);
			return image;
		}
		return null;
	}
	
	private void newImageUpdate(Map<String, Object> newImage, Image image, Long memberNo) {
		newImage.put("originImgName", image.getOriginImgName());
		newImage.put("changeImgName", image.getChangeImgName());
		newImage.put("memberNo", memberNo);
	}
	
	private void oldImageUpdate(Map<String, Object> oldImage, Image memberImage, Long memberNo) {
		oldImage.put("imgNo", memberImage.getImgNo());
		oldImage.put("memberNo", memberNo);
	}
	
	private void encryptionPassword(Member member) {
		String securityPass = passwordEncrypt.encode(member.getMemberPwd());
		member.setMemberPwd(securityPass);
	}
	
	private void changeNickName(Member member) {
		if("".equals(member.getNickname())) {
			member.setNickname(member.getMemberId());
		}
	}
	
	private void updateUser(Member member, Member loginMember) {
		validateUser.validationPassword(member);
		validateUser.invalidRequestMemberNo(member.getMemberNo(), loginMember.getMemberNo());
		encryptionPassword(member);
		changeNickName(member);
	}
	
	private void processUpdateAddress(Map<String, Object> map, Long memberNo, Address address) {
		map.put("memberNo", memberNo);
		map.put("stateCode", address.getStateCode());
		map.put("addressType", address.getAddressType());
		map.put("district", address.getDistrict());
		map.put("addressNo", address.getAddressNo());
	}
	
	private PageInfo getPageInfo(int totalCount, int page, int boardLimit, int pageLimit) {
		return PagiNation.getPageInfo(totalCount, page, boardLimit, pageLimit);
	}
	
	@Override
	public Member selectMember(Member member) {
		// 잠시 테스트
		validateUser.validationMember(member);
		
		Member loginUser = mapper.selectMember(member);
		if("정지".equals(loginUser.getCategoryName())) {
			throw new InvalidRequestException("정지된 사용자입니다.");
		}
		
		validateUser.noExistingMember(loginUser);
		
		if(member.getCategoryNo() != loginUser.getCategoryNo()) {
			throw new NoExistentMemberException("존재하지 않는 회원입니다.");
		}
		
		validateUser.checkPwd(member, loginUser);
		
		// 아이디가 20자가 넘는다.
		// 비밀번호가 25자가 넘는다.
		return loginUser;

	}
	
	
	@Override
	public Map<String, Object> selectCategory() {
		
		Map<String, Object> responseData = new HashMap();
		responseData.put("stateCategory", mapper.selectStateCategory());
		responseData.put("memberCategory", mapper.selectMemberCategory());
		
		return responseData;
	}
	
	@Override
	@Transactional
	public void insertMember(Member member, Address address, MultipartFile upfile) {

		// 아이디가 20자가 넘는다.
		// 비밀번호가 25자가 넘는다.
		// 닉네임을 입력하지 않았다.
		validateUser.existingMemberId(member);
		validateUser.validationMember(member);
		Image image = memberImgSave(upfile);
		
		encryptionPassword(member);
		changeNickName(member);
		
		int memberResult = mapper.insertMember(member);
		int addressResult = mapper.insertAddress(address);
		int imageResult = 1;
		if(image != null) {
			imageResult = mapper.insertMemberImage(image);
		}

		if(memberResult * addressResult * imageResult == 0) {
			throw new FailInsertMemberException("회원 추가 실패");
		}
		
	}
	

	
	
	@Override
	@Transactional
	public Member updateMember(Member member, Member loginMember, MultipartFile upfile) {
		// 경우의 수 member의 비밀번호가 25자를 넘어간다. 
		// hidden 으로 넘긴 memberNo가 session의 memberNo와 일치하지 않는다.
		// 프로필 사진이 없던 사람이 프로필사진을 추가
		// 프로필 사진이 있던 사람이 그대로 유지
		// 프로필 사진이 있던 사람이 프로필사진을 추가
		// 프로필 사진이 없던 사람이 그대로 유지
		
		updateUser(member, loginMember);
		Image image = memberImgSave(upfile);
		Image memberImage = mapper.selectMemberImage(loginMember.getMemberNo());
		
		int memberResult = mapper.updateMember(member);
		int imageResult = 1;
		int updateImageResult = 1;
		
		if(image != null) {
			Map<String, Object> newImage = new HashMap();
			
			newImageUpdate(newImage, image, loginMember.getMemberNo());
			imageResult = mapper.updateMemberInsertImage(newImage);
			if(memberImage != null) {
				Map<String, Object> oldImage = new HashMap();
				
				oldImageUpdate(oldImage, memberImage, loginMember.getMemberNo());
				
				updateImageResult = mapper.updateMemberImage(oldImage);
			}
		}
		
		if(memberResult * imageResult * updateImageResult == 0) {
			throw new FailUpdateMemberException("회원수정실패");
		}
		loginMember = mapper.selectMember(loginMember);
		
		return loginMember;
	}

	@Override
	public void deleteMember(Member member, Member loginUser) {
		validateUser.checkPwd(member, loginUser);
		if(mapper.deleteMember(member) == 0) {
			throw new FailDeleteMemberException("회원탈퇴 실패");
		}
	}

	@Override
	@Transactional
	public void updateAddress(Long memberNo, Long userNo, Address address) {
		
		validateUser.invalidRequestMemberNo(memberNo, userNo);
		
		Map<String, Object> map = new HashMap();
		
		processUpdateAddress(map, memberNo, address);
		
		
		if(mapper.updateAddress(map) == 0) {
			throw new FailDeleteAddressException("주소 수정 실패");
		}
		
	}
	
	@Override
	public Map<String, Object> findMemberId(Member member) {
		Map<String, Object> map = new HashMap();
		List<Member> memberId = mapper.findMemberId(member);
		
		if(memberId == null) {
			throw new NoExistentMemberException("회원을 찾을 수 없습니다.");
		}	
		
		map.put("memberId", memberId);
		
		return map;
	}
	
	@Override
	public Map<String, Object> findMemberPassword(Member member) {
		Map<String, Object> map = new HashMap();
		Member loginMember = mapper.selectMember(member);
		//log.info("{}, {}", loginMember, member);
		validateUser.checkMember(member, loginMember);
		map.put("loginMember", loginMember);
		
		return map;
	}
	
	@Override
	public void changePassword(Member member) {
		Member loginMember = mapper.selectMember(member);
		encryptionPassword(member);
		loginMember.setMemberPwd(member.getMemberPwd());
		if(mapper.updateMember(loginMember) == 0) {
			throw new FailUpdateMemberException("비밀번호 수정 실패");
		}
		
	}
	
	
	@Override
	@Transactional
	public void insertNewAddress(Long memberNo, Long userNo, Address address) {
		// 경우의 수
		// memberNo와 loginUser의 memberNo가 일치하지 않을 때
		
		validateUser.invalidRequestMemberNo(memberNo, userNo);
		
		Map<String, Object> map = new HashMap();
		
		processUpdateAddress(map, memberNo, address);
		
	
		if(mapper.insertNewAddress(map) == 0) {
			throw new FailInsertAddressException("주소 추가 실패");
		}
		
	}
	
	@Override
	public void deleteAddress(Long memberNo, Long userNo, Long addressNo) {
		validateUser.invalidRequestMemberNo(memberNo, userNo);
		
		Map<String, Object> map = new HashMap();
		map.put("memberNo", memberNo);
		map.put("addressNo", addressNo);
		if(mapper.deleteAddress(map) == 0) {
			throw new FailDeleteAddressException("주소 삭제 실패");
		}
		
	}
	
	
	@Override
	public Map<String, Object> selectMemberAddresses(Long memberNo, int currentPage) {
		Map<String, Object> responseData = new HashMap();
		
		PageInfo pi = getPageInfo(mapper.selectAddressCount(memberNo), currentPage, 2, 3);
		int offset =(pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		responseData.put("stateCategory", mapper.selectStateCategory());
		
		responseData.put("addresses", mapper.selectAddresses(memberNo, rowBounds));
		
		responseData.put("pageInfo", pi);
		
		return responseData;
	}

	@Override
	public Map<String, Object> selectMemberInfo(Long memberNo) {
		Map<String, Object> responseData = new HashMap();
		responseData.put("addresses", mapper.selectInfoAddresses(memberNo));
		responseData.put("memberImage", mapper.selectMemberImage(memberNo));
		responseData.put("memberCategory", mapper.selectMemberCategory());
		return responseData;
	}




	



}
