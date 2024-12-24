package com.kh.pugly.farm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.pugly.farm.model.service.FarmService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FarmController {
	private final FarmService fs;
	
	@GetMapping("farms")
	public String farmsPage() {
		
		return "farms";
	}
}
