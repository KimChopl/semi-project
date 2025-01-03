package com.kh.pugly.farm.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.farm.model.dto.FarmPrice;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.farm.model.vo.FarmProduct;
import com.kh.pugly.farm.model.vo.StateCategory;

import com.kh.pugly.member.model.vo.Member;

public interface FarmService {
	
	Map<String, Object> selectFarmList(int plusNo);
	
	Map<String, Object> selectDetailFarm(Long farmNo);
	
	Map<String, Object> suchByKeyword(Map<String, Object> suchMap);

	void insertFarm(Farm farm, MultipartFile[] multi, Member member, Address ad, int[] facilityNo);
	
	void likeFarm(LikeAndAttention like);

	void attetionFarm(LikeAndAttention attention);
	
	
	List<FarmProduct> selectFarmProduct();

	FarmPrice selectMmPrice();

	List<StateCategory> selectState();
	
	Farm selectBookFarm(Long farmNo);

	Map<String, Object> getRegistInfo(Member member);
	
	
}
