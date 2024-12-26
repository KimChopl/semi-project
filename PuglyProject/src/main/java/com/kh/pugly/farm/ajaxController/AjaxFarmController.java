package com.kh.pugly.farm.ajaxController;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.pugly.farm.model.service.FarmService;

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
		log.info("{}", plusNo);
		plusNo += 6;
		Map<String, Object> map = fs.selectFarmList(plusNo);
		log.info("{} : " , map);
		return map;
	}


}
