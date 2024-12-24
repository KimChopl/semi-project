package com.kh.pugly.farm.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Farm;

@Mapper
public interface FarmMapper {
	List<Farm> selectFarmList();
	
	Farm selectDetailFarm(Long farmNo);
	
	int updateCount(Long farmNo);
	
	int likeFarm(LikeAndAttention like);
	
	int attentionFarm(LikeAndAttention attention);
	
	
}
