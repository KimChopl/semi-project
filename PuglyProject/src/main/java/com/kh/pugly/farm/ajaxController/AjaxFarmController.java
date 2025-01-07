package com.kh.pugly.farm.ajaxController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.farm.model.service.FarmService;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AjaxFarmController {

	private final FarmService fs;
	private final Gson gson = new Gson();
	
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
		log.info("{}", list);
		return list;
		
	}
	
	
	@PostMapping("modify/update.farm")
	@ResponseBody
	public void updateFarm(Farm farm, MultipartFile[] files, HttpSession ssn, int[] facilityNo, Address ad, @RequestParam("originNames") String originNames) {
		Map<String, Object> updateInfo = new HashMap<String, Object>();
		if(!!!originNames.equals("")) {
		Map<String, Object> map = gson.fromJson(originNames, Map.class);
		List<String> changeImgName = (List<String>)map.get("change");
		List<String> origin = (List<String>)map.get("origin");
		String path = (String)map.get("path");
		updateInfo.put("changeImg", changeImgName);
		updateInfo.put("origin", origin);
		updateInfo.put("path", path);
		}
		//log.info("{}", facilityNo);
		Member member = (Member)ssn.getAttribute("loginUser");
		updateInfo.put("member", member);
		updateInfo.put("facilityNo", facilityNo);
		updateInfo.put("address", ad);
		updateInfo.put("farm", farm);
		updateInfo.put("files", files);
		//log.info("{}", updateInfo.get("facilityNo"));
		fs.updateFarm(updateInfo);
	}

}
