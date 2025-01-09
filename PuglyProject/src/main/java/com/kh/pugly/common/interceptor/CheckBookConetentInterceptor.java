package com.kh.pugly.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CheckBookConetentInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)	throws Exception {
		HttpSession ssn = request.getSession();
		String date = request.getParameter("playDate");
		String adult = request.getParameter("adultNo");
		String kid = request.getParameter("kidNo");
		String phone = request.getParameter("phone");
		String content = request.getParameter("bookContent");
		Long farmNo = Long.parseLong(request.getParameter("farmNo"));
		System.out.println(date + adult + kid + phone + content);
		if(date == null || adult== null || kid == null || phone == null || content == null ||date.equals("") || adult.equals("") || kid.equals("") || kid.equals("") || phone.equals("") || content.trim().equals("")) {
			ssn.setAttribute("alertMsg", "충분하지 않은 값입니다.");
			response.sendRedirect("/pugly/farms/" + farmNo);
			return false;
		}
		return true;
	}

}
