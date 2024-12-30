package com.kh.pugly.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.member.model.service.MemberService;
import com.kh.pugly.member.model.service.PasswordEncoder;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {
	private final MemberService memberService;
	private final ModelAndViewUtil mv;
	private final PasswordEncoder passEncrypt;
	
	
	@GetMapping("login_form.member")
	public String loginEnrollForm() {
		return "member/login_form";
	}
	
	@PostMapping("login.member")
	public ModelAndView selectMember(Member member, HttpSession session) {

		Member loginUser = memberService.selectMember(member);
		//String memberPwd = passEncrypt.encode(member.getMemberPwd());
		
		session.setAttribute("loginUser", loginUser);
		session.setAttribute("addresses", memberService.selectAdresses(loginUser.getMemberNo()));
		session.setAttribute("memberImage", memberService.selectMemberImage(loginUser.getMemberNo()));
		
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	@GetMapping("logout.member")
	public String logout(HttpSession session) {
		session.removeAttribute("loginUser");
		session.removeAttribute("addresses");
		return "redirect:/";
	}
	
	@GetMapping("my_page.member")
	public String myPage() {
		return "member/my_page";
	}
	
	@GetMapping("enroll_form.address")
		public ModelAndView updateFormAddress() {
		Map<String, Object> map = memberService.selectStateCategory();
		
		return mv.setViewNameAndData("member/enroll_form_address", map);
	}
	
	@GetMapping("join_enroll_form.member")
	public ModelAndView joinEnrollForm() {
		
		Map<String, Object> map = memberService.selectStateCategory();
		
		return mv.setViewNameAndData("member/join_enroll_form", map);
	}
	
	@PostMapping("insert.member")
	public ModelAndView insertMember(Member member, Address address, MultipartFile upfile) {
		
		memberService.insertMember(member, address, upfile);
		
		return mv.setViewNameAndData("redirect:/", null);
	}
	
	@GetMapping("update_enroll_form.member")
	public ModelAndView updateEnrollForm() {
		return mv.setViewNameAndData("member/update_enroll_form", null);
	}
	@PostMapping("update.memberInfo")
	public ModelAndView updateMemberInfo(ModelAndView mv, HttpSession session, Member member) {
		Member loginMember = (Member)session.getAttribute("loginUser");
		memberService.updateMember(member, loginMember);
		return mv;
	}	
}
