package com.kh.pugly.farm.model.service;

import java.util.List;
import java.util.Map;

import com.kh.pugly.common.model.dto.FarmKeyword;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.ImageBrige;
import com.kh.pugly.farm.model.dto.FarmPrice;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.farm.model.vo.FarmProduct;
import com.kh.pugly.farm.model.vo.StateCategory;

import com.kh.pugly.member.model.vo.Member;

public interface FarmService {
	
	Map<String, Object> selectFarmList(int plusNo);
	
	Farm selectDetailFarm(Long farmNo);
	
	List<Farm> suchByKeyword(FarmKeyword keyword);

	void insertFarm(Farm farm, Image img, Member member);
	
	void likeFarm(LikeAndAttention like);

	void attetionFarm(LikeAndAttention attention);
	
	void deleteFarm(ImageBrige ib, Member member);
	
	void updateFarm(ImageBrige ib, Member member);
	

	
	List<FarmProduct> selectFarmProduct();

	FarmPrice selectMmPrice();

	List<StateCategory> selectState();
	
	
}
