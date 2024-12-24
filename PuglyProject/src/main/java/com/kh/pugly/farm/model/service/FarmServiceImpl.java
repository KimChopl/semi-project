package com.kh.pugly.farm.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.pugly.common.model.dto.FarmKeyword;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.farm.model.dao.FarmMapper;
import com.kh.pugly.farm.model.dto.ImageBrige;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Farm;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FarmServiceImpl implements FarmService {

	private final FarmMapper mp;
	
	private int countFarm() {
		return mp.countFarm();
	}
	
	@Override
	public List<Farm> selectFarmList(RowBounds rowNum) {
		int count = countFarm();
		
		if(count > 0) {
			
		} else {
			
		}
		
		return null;
	}

	@Override
	public Farm selectDetailFarm(Long farmNo) {
		return null;
	}

	@Override
	public List<Farm> suchByKeyword(FarmKeyword keyword) {
		return null;
	}

	@Override
	public int insertFarm(Farm farm, Image img) {
		return 0;
	}

	@Override
	public int likeFarm(LikeAndAttention like) {
		return 0;
	}

	@Override
	public int attetionFarm(LikeAndAttention attention) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteFarm(ImageBrige ib) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateFarm(ImageBrige ib) {
		// TODO Auto-generated method stub
		return 0;
	}

}
