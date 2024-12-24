package com.kh.pugly.farm.model.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.pugly.common.model.dao.ImageMapper;
import com.kh.pugly.common.model.dto.FarmKeyword;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.ImageBrige;
import com.kh.pugly.common.model.vo.MoreInfo;
import com.kh.pugly.common.template.MoreInfomation;
import com.kh.pugly.farm.model.dao.FarmMapper;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FarmServiceImpl implements FarmService {

	private final FarmMapper fm;
	private final ImageMapper im;
	
	private int countFarm() {
		return fm.countFarm();
	}
	
	private MoreInfo getPageInfo(int plusNo) {
		int listCount = countFarm();
		if(listCount > 0) {
			return MoreInfomation.getMoreInfo(listCount, plusNo);
		} else {
			return null;
		}
	
	}
	
	private Map<String, Object> checkedMap(List<Farm> farm, MoreInfo mif){
		if(farm != null) {
			Map<String, Object> map = new HashMap();
			map.put("plusNo", mif.getLastNo());
			map.put("farm", farm);
			return map;
		} else {
			return null;
		}
	}
	
	@Override
	public Map<String, Object> selectFarmList(int plusNo) {
			
		MoreInfo mi = getPageInfo(plusNo);
		RowBounds rowNum = new RowBounds(mi.getStartNo(), mi.getLastNo());
		List<Farm> farm = fm.selectFarmList(rowNum);
		Map<String, Object> map = checkedMap(farm, mi);
		
		return map;
	}
	
	private void checkedFarm(Long farmNo) {
		int farm = fm.updateCount(farmNo);
		if(farm < 0) {
			// Exception
		} 
	}
	
	private void checkedFarmNo(Long farmNo) {
		if(farmNo < 1) {
			// 예외 처리
		}
	}
	
	private Farm checkedDetailFarm(Long farmNo) {
		Farm farm = fm.selectDetailFarm(farmNo);
		if(farm == null) {
			return null;
		}
		return farm;
	}
	
	@Override
	public Farm selectDetailFarm(Long farmNo) {
		checkedFarmNo(farmNo);
		checkedFarm(farmNo);
		
		return checkedDetailFarm(farmNo);
	}
	
	private void checkedOption(FarmKeyword keyword) {
		String today = new SimpleDateFormat("yyyyMMddHHmmSS").format(new Date());
		String FirstDate = new SimpleDateFormat("yyyyMMddHHmmss").format(keyword.getFirstDate());
		String lastDate = new SimpleDateFormat("yyyyMMddHHmmss").format(keyword.getLastDate());
		if(keyword.getMinPrice() < 0 || Integer.parseInt(FirstDate) < Integer.parseInt(today) || Integer.parseInt(lastDate) < Integer.parseInt(today) || keyword.getRating() < 0 || keyword.getRating() > 5) {
			
		}
	}
	
	private List<Farm> findByOption(FarmKeyword key){
		List<Farm> farm = fm.suchByKeyword(key);
		if(farm == null) {
			return null;
		} else {
			return farm;
		}
	}
	
	@Override
	public List<Farm> suchByKeyword(FarmKeyword keyword) {
		checkedOption(keyword);
		List<Farm> farm = findByOption(keyword);
		return farm;
	}
	
	private void checkedFarmContent(Farm farm, Member member) {
		if(!!!farm.getSeller().equals(member.getNickName())) {
			
		}
	}
	
	private int checkedInsertFarm(Farm farm) {
		int farmNo = fm.insertFarm(farm); // selectKey사용
		if(farmNo < 1) {
			return 0;
		}
		return farmNo;
	}
	
	private void checkedImg(Image img) {
		if(img == null) {
			// 예외처리
		}
	}
	
	private ImageBrige makedImageBrige(int farmNo, Farm farm, Image img) {
		checkedImg(img);
		ImageBrige ib = new ImageBrige();
		ib.setFarmNo(farmNo);
		ib.setCategoryNo(farm.getCategoryNo());
		return ib;
	}
	
	private int cehckedInsertImageBrige(ImageBrige ib) {
		int brigeNo = im.insertImageBrige(ib);
		if(brigeNo < 1) {
			return 0;
		}
		return brigeNo;
	}
	
	private void checkedInsertImage(Image img){
		int result = im.insertImage(img);
		if(result < 0) {
			// Exception
		}
	}

	@Override
	public void insertFarm(Farm farm, Image img, Member member) { // 글자 변환 안했음
		checkedFarmContent(farm, member);
		int farmNo = checkedInsertFarm(farm);
		ImageBrige ib = makedImageBrige(farmNo, farm, img);
		int brigeNo = cehckedInsertImageBrige(ib);
		img.setBrigeNo(brigeNo);
		checkedInsertImage(img);
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
