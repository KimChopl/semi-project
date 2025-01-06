package com.kh.pugly.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.member.model.service.MemberService;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {
	private final MemberService memberService;
	private final ModelAndViewUtil mv;
	
	
	@GetMapping("login_form.member")
	public ModelAndView loginEnrollForm() {
		Map<String, Object> responseData = memberService.selectCategory();
		return mv.setViewNameAndData("/member/login_form", responseData);
	}
	
	@PostMapping("login.member")
	public ModelAndView selectMember(Member member, HttpSession session) {
		Member loginUser = memberService.selectMember(member);
		session.setAttribute("loginUser", loginUser);
		session.setAttribute("alertMsg", "로그인에 성공하셨습니다!");
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	@GetMapping("logout.member")
	public String logout(HttpSession session) {
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
	
	@GetMapping("find_id.member")// 아이디찾기 폼
	public ModelAndView findIdEnrollForm() {
		Map<String, Object> responseData = memberService.selectCategory();
		return mv.setViewNameAndData("member/find_member_id_form", responseData);
	}
	
	@PostMapping("find_id.member")// 아이디찾기
	public ModelAndView findMemberId(Member member) {
		Map<String, Object> responseData = memberService.findMemberId(member);
		return mv.setViewNameAndData("/member/find_member_id_form", responseData);
	}
	
	@GetMapping("find_pwd.member")
	public ModelAndView findPwdEnrollForm() {
		Map<String, Object> responseData = memberService.selectCategory();
		return mv.setViewNameAndData("member/find_member_pwd_form", responseData);
	}
	
	@PostMapping("find_pwd.member")
	public ModelAndView findMemberPassword(Member member, HttpSession session) {
		
		Map<String, Object> responseData = memberService.findMemberPassword(member);
		session.setAttribute("alertMsg", "새로운 비밀번호를 입력해주세요!");
		return mv.setViewNameAndData("/member/new_password_form", responseData);
	}
	
	@PostMapping("change_password.member")
	public ModelAndView changeNewPassword(Member member, HttpSession session) {
		memberService.changePassword(member);
		session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");
		return mv.setViewNameAndData("redirect:/login_form.member", null);
	}
	
	@GetMapping("my_page.member")
	public ModelAndView myPage(HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		Map<String, Object> map = memberService.selectMemberInfo(loginUser.getMemberNo());
		return mv.setViewNameAndData("member/my_page", map);
	}
	
	@GetMapping("enroll_form.address")
		public ModelAndView updateFormAddress(HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		Map<String, Object> map = memberService.selectMemberAddresses(loginUser.getMemberNo());
		return mv.setViewNameAndData("member/enroll_form_address", map);
	}
	
	@GetMapping("join_enroll_form.member")
	public ModelAndView joinEnrollForm() {
		Map<String, Object> map = memberService.selectCategory();
		return mv.setViewNameAndData("member/join_enroll_form", map);
	}
	
	@PostMapping("insert.member")
	public ModelAndView insertMember(@RequestPart(value="upfile",required = false) MultipartFile upfile, Member member, Address address, HttpSession session) {
		memberService.insertMember(member, address, upfile);
		session.setAttribute("alertMsg", "회원가입에 성공했습니다!");
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	@PostMapping("insert.address")
	public ModelAndView insertAddress(Long memberNo, Address address, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		memberService.insertNewAddress(memberNo, loginUser.getMemberNo(), address);
		session.setAttribute("alertMsg", "주소 추가에 성공했습니다!");
		return mv.setViewNameAndData("redirect:/enroll_form.address", null);
	}
	
	@PostMapping("update.address")
	public ModelAndView updateAddress(Long memberNo, Address address, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		memberService.updateAddress(memberNo, loginUser.getMemberNo(), address);
		session.setAttribute("alertMsg", "주소 수정에 성공했습니다!");
		return mv.setViewNameAndData("redirect:/enroll_form.address", null);
	}
	
	@PostMapping("delete.address")
	public ModelAndView deleteAddress(Long memberNo, Long addressNo, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		memberService.deleteAddress(memberNo, loginUser.getMemberNo(),addressNo);
		session.setAttribute("alertMsg", "주소를 삭제했습니다.");
		return mv.setViewNameAndData("redirect:/enroll_form.address", null);
	}
	
	@GetMapping("update_enroll_form.member")
	public ModelAndView updateEnrollForm() {
		// session에 값이 있어서 따로 뽑을 필요가 없음 (회원정보수정)
		return mv.setViewNameAndData("member/update_enroll_form", null);
	}
	@PostMapping("update.memberInfo")
	public ModelAndView updateMemberInfo(@RequestPart(value="upfile",required = false)MultipartFile upfile, HttpSession session, Member member) {
		Member loginMember = (Member)session.getAttribute("loginUser");
		
		Member loginUser = memberService.updateMember(member, loginMember, upfile);

		session.setAttribute("loginUser", loginUser);
		session.setAttribute("alertMsg", "정보 수정에 성공했습니다!");

		return mv.setViewNameAndData("redirect:/my_page.member", null);
	}	
	
	@PostMapping("delete.member")
	public ModelAndView deleteMember(Member member, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		memberService.deleteMember(member, loginUser);
		session.removeAttribute("loginUser");
		session.setAttribute("alertMsg", "탈퇴하셨습니다.");
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	
}
