package com.kh.pugly.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.member.model.service.MemberService;
import com.kh.pugly.member.model.vo.Member;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class MemberController {
	
	private MemberService memberService;
	private ModelAndView mv;
	
	@GetMapping("login_form.member")
	public String loginEnrollForm() {
		return "member/login_form";
	}
	
	@PostMapping("login.member")
	public ModelAndView selectMember(Member member, HttpSession session) {
		Member loginUser = memberService.selectMember(member);
		session.setAttribute("loginUser", loginUser);
		mv.setViewName("redirect:/");
		return mv;
	}
	
	
}
