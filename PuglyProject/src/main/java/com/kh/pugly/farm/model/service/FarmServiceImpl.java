package com.kh.pugly.farm.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	private final FarmMapper fm;
	
	private int countFarm() {
		return fm.countFarm();
	}
	
	private RowBounds getPageInfo(int plusNo) {
		int listCount = countFarm();
		
		if(listCount > 0) {
			int boardLimit = 21;
			int startNo = plusNo + 1;
			int lastNo = startNo + boardLimit - 1;
			if(lastNo > listCount) {
				lastNo = listCount;
			}
			RowBounds rowNum = new RowBounds(startNo, lastNo);
			return rowNum;
		} else {
			return null;
		}
	}
	
	private Map<String, Object> checkedMap(List<Farm> farm){
		
		return null;
	}
	
	@Override
	public Map<String, Object> selectFarmList(int plusNo) {
			
		RowBounds rowNum = getPageInfo(plusNo);
		List<Farm> farm = fm.selectFarmList(rowNum);
		
		if(farm != null) {
			Map<String, Object> map = new HashMap();
			map.put("plusNo", plusNo);
			map.put("farm", farm);
			return map;
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
