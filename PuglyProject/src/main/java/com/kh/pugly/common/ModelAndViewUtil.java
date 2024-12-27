package com.kh.pugly.common;

import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

@Component
public class ModelAndViewUtil {
	
	public ModelAndView setViewNameAndData(String viewName, Map<String, Object> data) { // 모든 컨트롤러에서 사용할 컨트롤러
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		if(data != null) {
			
		mv.addAllObjects(data);
		}
		return mv;
	}

}
