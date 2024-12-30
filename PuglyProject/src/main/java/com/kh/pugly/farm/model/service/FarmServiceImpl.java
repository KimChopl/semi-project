package com.kh.pugly.farm.model.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pugly.common.model.dao.ImageMapper;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.ImageBrige;
import com.kh.pugly.common.model.vo.MoreInfo;
import com.kh.pugly.common.template.MoreInfomation;
import com.kh.pugly.common.template.ReplaceXss;
import com.kh.pugly.farm.model.dao.FarmMapper;
import com.kh.pugly.farm.model.dto.FarmPrice;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.farm.model.vo.FarmProduct;
import com.kh.pugly.farm.model.vo.StateCategory;
import com.kh.pugly.member.model.vo.Member;
import com.kh.pugly.review.model.service.ReviewService;
import com.kh.pugly.review.model.vo.Review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FarmServiceImpl implements FarmService {


	private final FarmMapper fm;
	private final ImageMapper im;
	private final ReplaceXss rx;
	private final ReviewService rs;
	
	
	private int countFarm() {
		return fm.countFarm();
	}
	
	private MoreInfo getPageInfo(int plusNo, int boardLimit) {
		int listCount = countFarm();
		if(listCount > 0) {
			return MoreInfomation.getMoreInfo(listCount, plusNo, boardLimit);
		} else {
			return null;
		}
	
	}
	
	private MoreInfo getSuchPageInfo(Map<String, Object> map, int boardLimit) {
		int listCount = fm.countSuchList(map);
		return MoreInfomation.getMoreInfo(listCount, (int)map.get("plusNo"), boardLimit);
	}
	
	private Map<String, Object> checkedMap(List<Farm> farm, MoreInfo mi){
		if(farm != null) {
			Map<String, Object> map = new HashMap();

			map.put("mi", mi);

			map.put("farm", farm);
			return map;
		} else {
			return null;
		}
	}
	
	@Override
	public Map<String, Object> selectFarmList(int plusNo) {
		//log.info("{}", plusNo);
		int boardLimit = 6;
		MoreInfo mi = getPageInfo(plusNo, boardLimit);
		RowBounds rowNum = new RowBounds(mi.getPlusNo(), mi.getBoardLimit());
		List<Farm> farm = fm.selectFarmList(rowNum);
		//log.info("{}", plusNo);
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
	public Map<String, Object> selectDetailFarm(Long farmNo) {
		checkedFarmNo(farmNo);
		checkedFarm(farmNo);
		Farm farm =  checkedDetailFarm(farmNo);
		int moreNo = 0;
		List<Review> review = rs.selectReviewList(moreNo, farmNo);
		log.info("{}", farm);
		Map<String, Object> detail = new HashMap();
		detail.put("farm", farm);
		detail.put("review", review);
		return detail;
	}
	
	
	
	@Override
	public Map<String, Object> suchByKeyword(Map<String, Object> suchMap) {
		int boardLimit = 6;
		MoreInfo mi = getSuchPageInfo(suchMap, boardLimit);
		RowBounds rowNum = new RowBounds(mi.getPlusNo(), mi.getBoardLimit());
		//log.info("{}", rowNum.getOffset());
		
		List<Farm> list = fm.suchByKeyword(suchMap, rowNum);
		Map<String, Object> map = checkedMap(list, mi);
		return map;
		
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
	/*
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
	*/
	private void checkedVacuum(Farm farm) {
		if(farm.getFarmTitle().trim().equals("") || farm.getFarmContent().trim().equals("")) {
			//Exception
		}
	}
	
	private Farm replaceContent(Farm farm) {
		checkedVacuum(farm);
		farm.setFarmTitle(rx.replaceXss(farm.getFarmTitle()));
		farm.setFarmContent(rx.replaceCrlf(rx.replaceXss(farm.getFarmContent())));
		return farm;
	}
	/*
	@Override
	public void insertFarm(Farm farm, Image img, Member member) { // 이미지 이름 변환 만들어야함
		checkedFarmContent(farm, member);
		Farm newFarm = replaceContent(farm);
		int farmNo = checkedInsertFarm(newFarm);
		ImageBrige ib = makedImageBrige(farmNo, newFarm, img);
		int brigeNo = cehckedInsertImageBrige(ib);
		img.setBrigeNo(brigeNo);
		checkedInsertImage(img);
	}
	 */
	@Override
	public void likeFarm(LikeAndAttention like) {
		Farm farm = fm.selectDetailFarm(like.getFarmNo());
		if(farm == null) {
			// Exception
		}
		List<LikeAndAttention> list = fm.checkLike(like.getMemberNo());
		if(!!!list.isEmpty()) {
			fm.deleteLike(like);
		}
		fm.likeFarm(like);
	}

	@Override
	public void attetionFarm(LikeAndAttention attention) {
		Farm farm = fm.selectDetailFarm(attention.getFarmNo());
		if(farm == null) {
			// Exception
		}
		List<LikeAndAttention> list = fm.checkLike(attention.getMemberNo());
		if(!!!list.isEmpty()) {
			fm.deleteLike(attention);
		}
		fm.likeFarm(attention);
	}

	@Override
	public void deleteFarm(ImageBrige ib, Member member) {
		
	}

	@Override
	public void updateFarm(ImageBrige ib, Member member) {
	}

	@Override
	public void insertFarm(Farm farm, Image img, Member member) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public List<StateCategory> selectState() {
		return fm.selectState();
	}

	@Override
	public FarmPrice selectMmPrice() {
		return fm.selectPrice();
	}

	@Override
	public List<FarmProduct> selectFarmProduct() {
		return fm.selectFarmProduct();
	}

}
