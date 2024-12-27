package com.kh.pugly.farm.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.common.model.dto.FarmKeyword;
import com.kh.pugly.farm.model.dto.FarmPrice;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
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
	
	List<Farm> suchByKeyword(FarmKeyword keyword);
	
	int deleteFarm(Long farmNo);
	
	int updateFarm(Farm farm);
	
	List<LikeAndAttention> checkLike(Long memberNo);
	
	int deleteLike(LikeAndAttention like);
	
	int delteAttention(LikeAndAttention attention);
	
	FarmPrice selectPrice();
	
	List<FarmProduct> selectFarmProduct();

}
