package com.kh.pugly.farm.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.farm.model.dto.FarmPrice;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Facility;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.farm.model.vo.FarmProduct;
import com.kh.pugly.farm.model.vo.StateCategory;

@Mapper
public interface FarmMapper {
	
	int countFarm();
	
	List<Farm> selectFarmList(RowBounds rowNum);
	
	Farm selectDetailFarm(Long farmNo);
	
	int updateCount(Long farmNo);
	
	int likeFarm(LikeAndAttention like);
	
	int attentionFarm(LikeAndAttention attention);
	
	int checkdeAuthority(Long memberNo);

	int insertFarm(Farm farm);
	
	List<StateCategory> selectState();
	
	List<Farm> suchByKeyword(Map<String, Object> suchMap, RowBounds rowNum);
	
	int deleteFarm(Long farmNo);
	
	int updateFarm(Farm farm);
	
	List<LikeAndAttention> checkLike(Long memberNo);
	
	int deleteLike(LikeAndAttention like);
	
	int delteAttention(LikeAndAttention attention);
	
	FarmPrice selectPrice();
	
	List<FarmProduct> selectFarmProduct();
	
	int countSuchList(Map<String, Object> suchMap);
	
	List<Facility> selectFacility();

	int insertFacility(Facility facility);


	int deleteFacility(Facility facility);

	
}
