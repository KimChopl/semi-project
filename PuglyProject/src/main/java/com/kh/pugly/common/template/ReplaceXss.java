package com.kh.pugly.common.template;


import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ReplaceXss {

	public String replaceXss(String content) {
		String newContent = content.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		return newContent;
	}
	
	public String replaceCrlf(String content) {
		String newContent = content.replaceAll("\n", "<br>");
		return newContent;
		
	}
	
	public String replaceBr(String content) {
		String newContent = content.replaceAll("<br>", "\n");
		return newContent;
	}

}
