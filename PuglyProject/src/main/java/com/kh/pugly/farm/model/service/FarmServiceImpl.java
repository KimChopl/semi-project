package com.kh.pugly.farm.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.dao.AddressMapper;
import com.kh.pugly.common.model.dao.ImageMapper;
import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.MoreInfo;
import com.kh.pugly.common.template.ChangeImage;
import com.kh.pugly.common.template.MoreInfomation;
import com.kh.pugly.common.template.ReplaceXss;
import com.kh.pugly.farm.model.dao.FarmMapper;
import com.kh.pugly.farm.model.dto.FarmPrice;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Facility;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.farm.model.vo.FarmProduct;
import com.kh.pugly.farm.model.vo.StateCategory;
import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.service.MemberService;
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
	private final ChangeImage ci;
	private final MemberMapper mm;
	private final AddressMapper am;
	
	
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
		//log.info("{}", farm);
		moreNo += 3;
		Map<String, Object> detail = new HashMap();
		detail.put("farm", farm);
		detail.put("review", review);
		detail.put("plusNo", moreNo);
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
		if(!!!farm.getSeller().equals(member.getNickname())) {
			
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

	private Long checkAddress(Address ad, Member member) {
		List<Address> list = mm.selectAddresses(member.getMemberNo());
		for(int i = 0; i < list.size(); i++) {
			if(list.get(i).getStateCode().equals(ad.getStateCode()) && list.get(i).getDistrict().equals(ad.getDistrict()) && list.get(i).getMemberNo().equals(member.getMemberNo())) {
				return Long.parseLong("0");
			}
		}
		return Long.parseLong("1");
	}
	
	private Long checkedNewAddress(Address ad, Member member) {
		Long result = checkAddress(ad, member);
		if(result == 1) {
			am.insertAddress(ad);
			return ad.getAddressNo();
		} else {
			return ad.getAddressNo();
		}
		
	}
	
	private Farm plusFarm(Farm farm, Long addressNo) {
		farm.setAddress(String.valueOf(addressNo));
		return farm;
	}
	
	private Long checkedInsert(Farm newFarm, List<Image> list) {
		int result = fm.insertFarm(newFarm);
		if(result < 1) {
			
			ci.deleteImage(list);
			// Exception
		}
		log.info("{}", newFarm.getFarmNo());
		return newFarm.getFarmNo();
	}
	
	private int insertImageList(List<Image> img, Long farmNo) {
		int result = 0;
		for(int i = 0; i < img.size(); i ++) {
			img.get(i).setPostNo(farmNo);
			result = 1 * im.insertImage(img.get(i));
		}
		return result;
	}
	
	private void checkedInsertImg(List<Image> img, Long farm) {
		int result = insertImageList(img, farm);
		if(result != 1) {
			ci.deleteImage(img);
			//Exception
		}
	}
	
	private void insertFac(int[] facilityNo, Farm farm, List<Image> list) {
		int result = 0;
		for(int i = 0; i < facilityNo.length; i++) {
			Facility fac = new Facility();
			fac.setFacilityName(String.valueOf(facilityNo[i]));
			fac.setFacilityNo(Integer.parseInt(String.valueOf(farm.getFarmNo())));
			result = 1 * fm.insertFacility(fac);
		}
		if(result == 0) {
			ci.deleteImage(list);
			//Exception
		}
	}
	
	@Override
	public void insertFarm(Farm farm, MultipartFile[] multi, Member member, Address ad, int[] facilityNo) {
		List<Image> img = ci.changeImgName(multi);
		Long addressNo = checkedNewAddress(ad, member);
		Farm newFarm = plusFarm(farm, addressNo);
		log.info("{}", newFarm);
		Long farmNo = checkedInsert(newFarm, img);
		checkedInsertImg(img, farmNo);
		insertFac(facilityNo, newFarm, img);
		
		
		
		//log.info("{}", addressNo);
		
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

	@Override
	public Farm selectBookFarm(Long farmNo) {
		return checkedDetailFarm(farmNo);
	}
	
	private List<Facility> selectFacility(){
		return fm.selectFacility();
	}
	
	private Address returnAddress(List<Address> ad) {
		for(int i = 0; i < ad.size(); i++) {
			if(ad.get(i).getAddressType() == 1) {
				return ad.get(i);
			}
		}
		
		return null;
	}
	
	@Override
	public Map<String, Object> getRegistInfo(Member member) {
		List<FarmProduct> product = selectFarmProduct();
		List<StateCategory> state = selectState();
		List<Facility> facility = selectFacility();
		List<Address> adList = mm.selectAddresses(member.getMemberNo());
		Address ad = returnAddress(adList);	
		Map<String, Object> map = new HashMap();
		map.put("product", product);
		map.put("state", state);
		map.put("facility", facility);
		map.put("address", ad);
		return map;
	}

}
