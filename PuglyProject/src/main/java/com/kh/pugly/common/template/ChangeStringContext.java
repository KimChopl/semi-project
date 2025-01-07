package com.kh.pugly.common.template;

import org.springframework.stereotype.Component;

@Component
public class ChangeStringContext {
	
	public String changeInsertFormat(String originString) {
		return originString.replaceAll("&","&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("<br>", "\n");
	}
	
	public String changeSelectFormat(String changeString) {
		return changeString.replaceAll("\n", "<br>"); // 개행만 바꿔줌
	}
	
}
