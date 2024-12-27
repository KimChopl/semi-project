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
	
	@PostMapping(value="suchFarm", produces="application/json; charset=UTF-8")
	public void suchFarmList(@RequestBody String such) {
		JsonParser parser = new JsonParser();
		JsonElement jel = parser.parse(such);
		JsonObject jo = jel.getAsJsonObject();
		JsonElement stateEl = jo.get("state");
		JsonArray productEl = jo.get("product").getAsJsonArray();
		String optionEl = jo.get("option").getAsString();
		int plusNo = jo.get("plusNo").getAsInt();
		Map<String, Object> suchMap = new HashMap();
		suchMap.put("state", stateEl);
		suchMap.put("product", productEl);
		suchMap.put("option", optionEl);
		suchMap.put("plusNo", plusNo);
		List<Farm> farm = fs.suchByKeyword(suchMap);
		
		log.info("{}", farm);
	}

}
