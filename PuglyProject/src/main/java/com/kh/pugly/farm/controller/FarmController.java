package com.kh.pugly.farm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.farm.model.dto.FarmPrice;
import com.kh.pugly.farm.model.service.FarmService;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.farm.model.vo.FarmProduct;
import com.kh.pugly.farm.model.vo.StateCategory;
import com.kh.pugly.review.model.service.ReviewService;
import com.kh.pugly.review.model.vo.Review;

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
		Map<String, Object> farmAndMi = fs.selectFarmList(0);
		Map<String, Object> farm = new HashMap();
		List<StateCategory> state = fs.selectState();
		FarmPrice mmPrice = fs.selectMmPrice();
		List<FarmProduct> farmProduct = fs.selectFarmProduct();
		farm.put("farm", farmAndMi);
		farm.put("state", state);
		farm.put("mmPrice", mmPrice);
		farm.put("farmProduct", farmProduct);
		//log.info("{}", farm);

		
		return mv.setViewNameAndData("/farm/farms", farm);
	}
	
	
	@GetMapping("farms/{farmNo}")
	public ModelAndView detailFarm(@PathVariable(name="farmNo") Long farmNo, HttpSession ssn) {
		Map<String, Object> detail = fs.selectDetailFarm(farmNo);
		log.info("{}", detail);
		return mv.setViewNameAndData("/farm/farm-detail", detail);
	}
	
		

	
}
