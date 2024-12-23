package com.kh.pugly.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

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
	
	
	@GetMapping("login_form.member")
	public String loginEnrollForm() {
		return "member/login_form";
	}
	
	@PostMapping("login.member")
	public ModelAndView selectMember(Member member, HttpSession session, ModelAndView mv) {
		Member loginUser = memberService.selectMember(member);
		List<Address> addresses = memberService.selectAdresses(loginUser.getMemberNo());
		session.setAttribute("loginUser", loginUser);
		session.setAttribute("addresses", addresses);
		//log.info("{}", loginUser);
		//log.info("{}", addresses);
		mv.setViewName("redirect:/");
		return mv;
	}
	
	@GetMapping("my_page.member")
	public String myPage() {
		return "member/my_page";
	}
	
	@GetMapping("update.member")
	public ModelAndView updateFormAddress(ModelAndView mv) {
		List<Address> category = memberService.selectStateCategory();
		mv.addObject("stateCategory", category);
		mv.setViewName("member/update_enroll_form");
		return mv;
	}
	
	
}
