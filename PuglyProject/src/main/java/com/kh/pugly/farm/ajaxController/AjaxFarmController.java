package com.kh.pugly.farm.ajaxController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.farm.model.service.FarmService;
import com.kh.pugly.farm.model.vo.Farm;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AjaxFarmController {

	private final FarmService fs;
	
	@GetMapping(value="plus", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> selectMoreFarm(int plusNo){
		//log.info("{}", plusNo);
		plusNo += 6;
		Map<String, Object> map = fs.selectFarmList(plusNo);
		//log.info("{} : " , map);
		return map;
	}
	
	@PostMapping(value="plus", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> suchFarmList(@RequestBody Map<String, Object> such) {
		List<String> state = (List<String>) such.get("state");
		List<Integer> product = (List<Integer>)such.get("product");
		String option = (String)such.get("option");
		double str = (double)such.get("plusNo");
		int plusNo = (int)str;
		Map<String, Object> map = new HashMap();
		map.put("state", state);
		map.put("product", product);
		map.put("option", option);
		map.put("plusNo", plusNo);
		//log.info("{}", map);
		Map<String, Object>list = fs.suchByKeyword(map);
		//log.info("{}", list);
		return list;
		
	}

}
