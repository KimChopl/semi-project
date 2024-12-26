package com.kh.pugly.farm.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.farm.model.service.FarmService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FarmController {
	private final FarmService fs;
	private final ModelAndViewUtil mv;
	
	@GetMapping("farms")
	public ModelAndView farmsPage() {
		Map<String, Object> list = fs.selectFarmList(1);
		//log.info("{}", list);
		
		return mv.setViewNameAndData("/farm/farms", list);
	}
}
