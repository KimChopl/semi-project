package com.kh.pugly.farm.model.service;

import java.util.List;
import java.util.Map;

import com.kh.pugly.common.model.dto.FarmKeyword;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.farm.model.dto.ImageBrige;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Farm;

public interface FarmService {
	
	Map<String, Object> selectFarmList(int plusNo);
	
	Farm selectDetailFarm(Long farmNo);
	
	List<Farm> suchByKeyword(FarmKeyword keyword);

	int insertFarm(Farm farm, Image img);
	
	int likeFarm(LikeAndAttention like);

	int attetionFarm(LikeAndAttention attention);
	
	int deleteFarm(ImageBrige ib);
	
	int updateFarm(ImageBrige ib);

}
