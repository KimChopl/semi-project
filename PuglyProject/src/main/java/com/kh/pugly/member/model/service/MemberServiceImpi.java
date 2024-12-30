package com.kh.pugly.member.model.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.exception.ComparedPasswordException;
import com.kh.pugly.exception.ExistingMemberIdException;
import com.kh.pugly.exception.FailInsertMemberException;
import com.kh.pugly.exception.FailToFileUploadException;
import com.kh.pugly.exception.InvalidRequestException;
import com.kh.pugly.exception.NoExistentMemberException;
import com.kh.pugly.exception.TooLargeValueException;
import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@EnableTransactionManagement
public class MemberServiceImpi implements MemberService {

	private final MemberMapper mapper;
	private final ServletContext context;
	private final PasswordEncoder passwordEncrypt;
	
	private void validationMember(Member member) {
		if(20 <= member.getMemberId().length() || 25 <= member.getMemberPwd().length()) {
			throw new TooLargeValueException("지나치게 큰 값");
		}
		
		if("".equals(member.getMemberId().trim()) || "".equals(member.getMemberPwd().trim())) {
			throw new InvalidRequestException("유효하지 않은 요청");
		}
	}
	
	private void noExistingMember(Member member) {
		if(member == null) {
			throw new NoExistentMemberException("존재하지 않는 회원입니다.");
		}
	}
	
	private void invalidRequestMemberNo(Member member, Member loginMember) {
		if(member.getMemberNo() != loginMember.getMemberNo()) {
			throw new InvalidRequestException("유효하지 않은 요청");
		}
	}
	
	private void validationPassword(Member member) {
		if(member.getMemberPwd().length() >= 25) {
			throw new TooLargeValueException("비밀번호가 너무 김");
		}
		
		if("".equals(member.getMemberPwd().trim())) {
			throw new InvalidRequestException("유효하지 않은 요청");
		}
	}
	
	private void existingMemberId(Member member) {
		Member checkMember = mapper.selectMember(member);
		if(checkMember != null) {
			throw new ExistingMemberIdException("이미 존재하는 아이디입니다.");
		}
	}
	
	private void checkPwd(Member member, Member loginUser) {
		if(!(passwordEncrypt.matches(member.getMemberPwd(), loginUser.getMemberPwd()))) {
			throw new ComparedPasswordException("비밀번호가 일치하지 않습니다.");
		}
	}
	
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
	
	private void encryptionPassword(Member member) {
		String securityPass = passwordEncrypt.encode(member.getMemberPwd());
		member.setMemberPwd(securityPass);
	}
	
	private void changeNickName(Member member) {
		if("".equals(member.getNickName())) {
			member.setNickName(member.getMemberId());
		}
	}
	
	private void updateUser(Member member, Member loginMember) {
		validationPassword(member);
		invalidRequestMemberNo(member, loginMember);
		encryptionPassword(member);
		changeNickName(member);
	}
	
	@Override
	public Member selectMember(Member member) {
		// 잠시 테스트
		
		validationMember(member);
		
		
		
		Member loginUser = mapper.selectMember(member);
		
		noExistingMember(loginUser);
		
		checkPwd(member, loginUser);
		
		// 아이디가 20자가 넘는다.
		// 비밀번호가 25자가 넘는다.
		
		return loginUser;
	}
	
	@Override
	public List<Address> selectAdresses(Long memberNo) {
		return mapper.selectAddresses(memberNo);
	}
	
	@Override
	public Image selectMemberImage(Long memberNo) {
		return mapper.selectMemberImage(memberNo);
	}
	
	
	@Override
	public Map<String, Object> selectStateCategory() {
		
		Map<String, Object> responseData = new HashMap();
		List<Address> category = mapper.selectStateCategory();
		responseData.put("stateCategory", category);
		
		return responseData;
	}
	
	@Override
	@Transactional
	public void insertMember(Member member, Address address, MultipartFile upfile) {
		// 아이디가 20자가 넘는다.
		// 비밀번호가 25자가 넘는다.
		// 닉네임을 입력하지 않았다.
		existingMemberId(member);
		validationMember(member);
		Image image = memberImgSave(upfile);
		
		encryptionPassword(member);
		changeNickName(member);
		//String securityPass = passwordEncrypt.encode(member.getMemberPwd());
		//member.setMemberPwd(securityPass);
		
		/*
		if("".equals(member.getNickName())) {
			member.setNickName(member.getMemberId());
		}
		*/
		
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
	public void updateMember(Member member, Member loginMember, MultipartFile upfile) {
		// 경우의 수 member의 비밀번호가 25자를 넘어간다. 
		// hidden 으로 넘긴 memberNo가 session의 memberNo와 일치하지 않는다.
		
		updateUser(member, loginMember);
		Image image = memberImgSave(upfile);
		
		
		
	}

	@Override
	public void deleteMember(Map<String, Object> map) {
		

	}





}
