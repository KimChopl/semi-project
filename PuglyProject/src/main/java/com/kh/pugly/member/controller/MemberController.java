package com.kh.pugly.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
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
	public String loginEnrollForm() {
		return "member/login_form";
	}
	
	@PostMapping("login.member")
	public ModelAndView selectMember(Member member, HttpSession session) {
		Member loginUser = memberService.selectMember(member);
		session.setAttribute("loginUser", loginUser);
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	@GetMapping("logout.member")
	public String logout(HttpSession session) {
		session.removeAttribute("loginUser");
		session.removeAttribute("addresses");
		return "redirect:/";
	}
	
	// 서비스 1개만 쓰기
	@GetMapping("my_page.member")
	public ModelAndView myPage(HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		Map<String, Object> map = memberService.selectMemberInfo(loginUser.getMemberNo());
		return mv.setViewNameAndData("member/my_page", map);
	}
	
	// 서비스 1개만 쓰기
	@GetMapping("enroll_form.address")
		public ModelAndView updateFormAddress(HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		Map<String, Object> map = memberService.selectMemberAddresses(loginUser.getMemberNo());
		return mv.setViewNameAndData("member/enroll_form_address", map);


	}
	
	@GetMapping("join_enroll_form.member")
	public ModelAndView joinEnrollForm() {
		Map<String, Object> map = memberService.selectStateCategory();
		return mv.setViewNameAndData("member/join_enroll_form", map);
	}
	
	@PostMapping("insert.member")
	public ModelAndView insertMember(@RequestPart(value="upfile",required = false) MultipartFile upfile, Member member, Address address) {
		memberService.insertMember(member, address, upfile);
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	@PostMapping("insert.address")
	public ModelAndView insertAddress(Long memberNo, Address address) {
		memberService.insertNewAddress(memberNo, address);
		return mv.setViewNameAndData("redirect:/member/enroll_form_address", null);
	}
	
	@PostMapping("update.address")
	public ModelAndView updateAddress(Long memberNo, Address address) {
		memberService.updateAddress(memberNo, address);
		return mv.setViewNameAndData("redirect:/member/enroll_form_address", null);
	}
	
	@GetMapping("update_enroll_form.member")
	public ModelAndView updateEnrollForm() {
		// session에 값이 있어서 따로 뽑을 필요가 없음
		return mv.setViewNameAndData("member/update_enroll_form", null);
	}
	@PostMapping("update.memberInfo")
	public ModelAndView updateMemberInfo(@RequestPart(value="upfile",required = false)MultipartFile upfile, HttpSession session, Member member) {
		Member loginMember = (Member)session.getAttribute("loginUser");
		
		Member loginUser = memberService.updateMember(member, loginMember, upfile);

		session.setAttribute("loginUser", loginUser);

		return mv.setViewNameAndData("redirect:/my_page.member", null);
	}	
	
	@PostMapping("delete.member")
	public ModelAndView deleteMember(Member member, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		session.removeAttribute("loginUser");
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	
}
