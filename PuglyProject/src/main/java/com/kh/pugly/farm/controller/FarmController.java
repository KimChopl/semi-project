package com.kh.pugly.farm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.farm.model.dto.FarmPrice;
import com.kh.pugly.farm.model.service.FarmService;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.farm.model.vo.FarmProduct;
import com.kh.pugly.farm.model.vo.StateCategory;
import com.kh.pugly.member.model.vo.Member;

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
	
	
	@GetMapping("farms/{farmNo}") // 일로 들어옴(12.31)
	public ModelAndView detailFarm(@PathVariable(name="farmNo") Long farmNo, HttpSession ssn) {
		//log.info("{}",farmNo);
		Map<String, Object> detail = fs.selectDetailFarm(farmNo);
		//log.info("{}", detail);
		return mv.setViewNameAndData("/farm/farm-detail", detail);
	}
	
	@GetMapping("farm/regist")
	public ModelAndView registFarm(HttpSession ssn) {
		Member member = (Member)ssn.getAttribute("loginUser");
		Map<String, Object> map = fs.getRegistInfo(member);
		//log.info("{}", map);
		
		return mv.setViewNameAndData("/farm/regist-farm", map);
	}

	@PostMapping("farm/regist.farm")
	public String insertFarm(Farm farm, int[] facilityNo, HttpSession ssn, MultipartFile[] multi, Address ad) {
		Member loginUser = (Member)ssn.getAttribute("loginUser");
		//log.info("{}", facilityNo);
		fs.insertFarm(farm, multi, loginUser, ad, facilityNo);
		return "redirect:/farms";
	}
	
	@GetMapping("modify/farm")
	public ModelAndView modifyFarm(Long farmNo, HttpSession ssn) {
		//log.info("{}", farmNo);
		Member member = (Member)ssn.getAttribute("loginUser");
		return mv.setViewNameAndData("farm/update_form_farm", fs.selectUpdateForm(farmNo, member));
	}
	
	@GetMapping("farms/{farmNo}/delete.farm")
	public ModelAndView deleteFarm(@PathVariable(name="farmNo") Long farmNo, HttpSession ssn) {
		
		fs.deleteFarm(farmNo, 3);
		
		Map<String, Object> farmAndMi = fs.selectFarmList(0);
		Map<String, Object> farm = new HashMap();
		List<StateCategory> state = fs.selectState();
		FarmPrice mmPrice = fs.selectMmPrice();
		List<FarmProduct> farmProduct = fs.selectFarmProduct();
		farm.put("farm", farmAndMi);
		farm.put("state", state);
		farm.put("mmPrice", mmPrice);
		farm.put("farmProduct", farmProduct);
		ssn.setAttribute("alertMsg", "삭제에 성공하였습니다.");
		return mv.setViewNameAndData("farm/farms", farm);
	}

	
}
