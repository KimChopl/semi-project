package com.kh.pugly.common.template;

import org.springframework.stereotype.Component;

import com.kh.pugly.exception.FailInsertObjectException;

@Component
public class ChangeStringContext {
	
	public String changeInsertFormat(String originString) {
		if(originString.trim().equals("")) {
			throw new FailInsertObjectException("문자열 장난질?");
		}
		return originString.replaceAll("&","&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("<br>", "\n");
	}
	
	public String changeSelectFormat(String changeString) {
		return changeString.replaceAll("\n", "<br>"); // 개행만 바꿔줌
	}
	
}
