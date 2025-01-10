package com.kh.pugly.farm.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.dao.AddressMapper;
import com.kh.pugly.common.model.dao.ImageMapper;
import com.kh.pugly.common.model.vo.Address;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.MoreInfo;
import com.kh.pugly.common.model.vo.SelectImageByFarm;
import com.kh.pugly.common.template.ChangeImage;
import com.kh.pugly.common.template.ChangeStringContext;
import com.kh.pugly.common.template.MoreInfomation;
import com.kh.pugly.exception.FailDeleteException;
import com.kh.pugly.exception.FailDeleteObjectException;
import com.kh.pugly.exception.FailInsertFarmException;
import com.kh.pugly.exception.FailInsertObjectException;
import com.kh.pugly.exception.FailUpdateException;
import com.kh.pugly.exception.InvalidRequestException;
import com.kh.pugly.exception.NotFoundObjectException;
import com.kh.pugly.exception.NotFoundUserInfomation;
import com.kh.pugly.exception.NotMatchUserInfomationException;
import com.kh.pugly.farm.model.dao.FarmMapper;
import com.kh.pugly.farm.model.dto.FarmPrice;
import com.kh.pugly.farm.model.dto.LikeAndAttention;
import com.kh.pugly.farm.model.vo.Facility;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.farm.model.vo.FarmProduct;
import com.kh.pugly.farm.model.vo.StateCategory;
import com.kh.pugly.member.model.dao.MemberMapper;
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
	private final ReviewService rs;
	private final ChangeImage ci;
	private final MemberMapper mm;
	private final AddressMapper am;
	private final ChangeStringContext xss;
	
	private void checkedUpdateFarm(Farm farm) {
		int result = fm.updateFarm(farm);
		if(result == 0) {
			throw new FailDeleteObjectException("농장 수정 실패");
		}
	}
	
	private int deleteFacility(Farm farm) {
		int result = 1;
		for(int i = 0; i < farm.getFacility().size(); i++) {
			farm.getFacility().get(i).setFacilityName(String.valueOf(farm.getFarmNo()));
			result = result * fm.deleteFacility(farm.getFacility().get(i));
		}
		return result;
	}
	
	private int insertFacility(int[] facilityNo, Farm farm) {
		int result = 1;
		for(int i = 0; i < facilityNo.length; i++) {
			Facility facility = new Facility();
			facility.setFacilityNo(facilityNo[i]);
			facility.setFacilityName(String.valueOf(farm.getFarmNo()));
			result = result * fm.insertFacility(facility);
		}
		return result;
	}
	
	private void updateFacility(int[] facilityNo, Farm farm) {
		if(facilityNo != null) {
			int delete = deleteFacility(farm);
			int insert = insertFacility(facilityNo, farm);
			if(delete * insert == 0) {
				throw new FailDeleteObjectException("시설 목록 수정 실패");
			}
		}
	}
	
	private int countFarm() {
		return fm.countFarm();
	}
	
	private MoreInfo getPageInfo(int plusNo, int boardLimit) {
		int listCount = countFarm();
		return MoreInfomation.getMoreInfo(listCount, plusNo, boardLimit);
	
	}
	
	private MoreInfo getSuchPageInfo(Map<String, Object> map, int boardLimit) {
		int listCount = fm.countSuchList(map);
		return MoreInfomation.getMoreInfo(listCount, (int)map.get("plusNo"), boardLimit);
	}
	
	private Map<String, Object> checkedMap(List<Farm> farm, MoreInfo mi){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mi", mi);
			map.put("farm", farm);
			return map;
	}
	
	@Override
	public Map<String, Object> selectFarmList(int plusNo) {
		int boardLimit = 6;
		MoreInfo mi = getPageInfo(plusNo, boardLimit);
		RowBounds rowNum = new RowBounds(mi.getPlusNo(), mi.getBoardLimit());
		List<Farm> farm = checkedSelectListFormat(fm.selectFarmList(rowNum));
		Map<String, Object> map = checkedMap(farm, mi);
		return map;
	}
	
	private void checkedFarm(Long farmNo) {
		int farm = fm.updateCount(farmNo);
		if(farm < 0) {
			throw new FailUpdateException("조회수 증가 실패");
		} 
	}
	
	private void checkedFarmNo(Long farmNo) {
		if(farmNo < 1) {
			throw new InvalidRequestException("농장에서 장난질?");
		}
	}
	
	private Farm checkedDetailFarm(Long farmNo) {
		Farm farm = fm.selectDetailFarm(farmNo);
		if(farm == null) {
			throw new NotFoundObjectException("농장 없는데?");
		}
		return farm;
	}
	
	@Override
	public Map<String, Object> selectDetailFarm(Long farmNo) {
		checkedFarmNo(farmNo);
		checkedFarm(farmNo);
		Farm farm =  checkedSelectFormat(checkedDetailFarm(farmNo));
		int moreNo = 0;
		List<Review> review = rs.selectReviewList(moreNo, farmNo);
		moreNo += 3;
		Map<String, Object> detail = new HashMap<String, Object>();
		detail.put("farm", farm);
		detail.put("review", review);
		detail.put("plusNo", moreNo);
		return detail;
	}
	
	
	
	@Override
	public Map<String, Object> suchByKeyword(Map<String, Object> suchMap) {
		int boardLimit = 6;
		MoreInfo mi = getSuchPageInfo(suchMap, boardLimit);
		int plusNo = (int)suchMap.get("plusNo");
		RowBounds rowNum = new RowBounds(mi.getStartNo(), mi.getBoardLimit());
		List<Farm> list = checkedSelectListFormat(fm.suchByKeyword(suchMap, rowNum));
		Map<String, Object> map = checkedMap(list, mi);
		map.put("plusNo", plusNo);
		return map;
		
	}
	
	private void checkedFarmContent(Farm farm, Member member) {
		if(!!!farm.getSeller().equals(String.valueOf(member.getMemberNo()))) {
			throw new NotMatchUserInfomationException("유저 정보 불일치");
		}
	}
	
	private void checkedVacuum(Farm farm) {
		if(farm.getFarmTitle().trim().equals("") || farm.getFarmContent().trim().equals("")) {
			throw new InvalidRequestException("빈칸만 넣어???");
		}
	}
	
	
	@Override
	public void likeFarm(LikeAndAttention like) {
		Farm farm = fm.selectDetailFarm(like.getFarmNo());
		if(farm == null) {
			throw new FailUpdateException("조회수 증가 실패");
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
			throw new NotFoundObjectException("관심목록 넣을 농장 없음");
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
			ad.setDistrict(xss.changeInsertFormat(ad.getDistrict()));
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
			throw new FailInsertObjectException("농장 등록 실패");
		}
		return newFarm.getFarmNo();
	}
	
	private int insertImageList(List<Image> img, Long farmNo) {
		int result = 0;
		for(int i = 0; i < img.size(); i ++) {
			img.get(i).setCategoryNo(Long.parseLong("3"));
			img.get(i).setPostNo(farmNo);
			result = 1 * im.insertImage(img.get(i));
		}
		return result;
	}
	
	private void checkedInsertImg(List<Image> img, Long farm) {
		int result = insertImageList(img, farm);
		if(result != 1) {
			ci.deleteImage(img);
			throw new FailInsertFarmException("이미지 등록 실패");
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
			throw new FailInsertFarmException("시설 등록 실패");
		}
	}
	
	
	private List<Farm> checkedSelectListFormat(List<Farm> farms){
		for(int i = 0; i < farms.size(); i++) {
			farms.get(i).setFarmTitle(xss.changeSelectFormat(farms.get(i).getFarmTitle()));
			farms.get(i).setAddress(xss.changeSelectFormat(farms.get(i).getAddress()));
		}
		return farms;
	}
	
	private Farm checkedChangeFormat(Farm farm) {
		farm.setFarmTitle(xss.changeInsertFormat(farm.getFarmTitle()));
		farm.setFarmContent(xss.changeInsertFormat(farm.getFarmContent()));
		farm.setBewareList(xss.changeInsertFormat(farm.getBewareList()));
		return farm;
	}
	
	private Farm checkedSelectFormat(Farm farm) {
		farm.setFarmTitle(xss.changeSelectFormat(farm.getFarmTitle()));
		farm.setFarmContent(xss.changeSelectFormat(farm.getFarmContent()));
		farm.setAddress(xss.changeSelectFormat(farm.getAddress()));
		farm.setBewareList(xss.changeSelectFormat(farm.getBewareList()));
		return farm;
	}
	@Override
	public void insertFarm(Farm farm, MultipartFile[] multi, Member member, Address ad, int[] facilityNo) {
		checkedFarmContent(farm, member);
		checkedVacuum(farm);
		List<Image> img = ci.changeImgName(multi);
		Farm newFarm = checkedChangeFormat(plusFarm(farm, checkedNewAddress(ad, member)));
		Long farmNo = checkedInsert(newFarm, img);
		checkedInsertImg(img, farmNo);
		insertFac(facilityNo, newFarm, img);
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
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("product", product);
		map.put("state", state);
		map.put("facility", facility);
		map.put("address", ad);
		return map;
	}

	private void checkedMember(Member loginUser) {
		if(loginUser == null) {
			throw new NotFoundUserInfomation("로그인 확인");
		}
		Member checkMember = mm.selectMemberInfo(loginUser.getMemberNo());
		if(!!!loginUser.getMemberId().equals(checkMember.getMemberId()) || loginUser.getMemberNo() != checkMember.getMemberNo() || !!!loginUser.getNickname().equals(checkMember.getNickname())
				|| !!!loginUser.getMemberName().equals(checkMember.getMemberName())) {
			throw new NotMatchUserInfomationException("유저 정보가 일치하지 않습니다.(농장)");
		}
		
	}
	@Override
	public Map<String, Object> selectUpdateForm(Long farmNo, Member member) {
		checkedMember(member);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("product", selectFarmProduct());
		map.put("state", selectState());
		map.put("facility", selectFacility());
		map.put("farm", fm.selectDetailFarm(farmNo));
		
		return map;
	}
	
	private List<Image> checkedFarm(List<Image> img, List<Image> beforeImg) {
		if(img != null && !(img.isEmpty())) {
			
		Set<Image> imgListSet = new HashSet<>(img);
		Set<Image> beforeImgSet = new HashSet<>(beforeImg);

		// A - B 차집합 구하기 (beforeImgSet - imgListSet)
		Set<Image> aa = new HashSet<>(beforeImgSet);
		aa.removeAll(imgListSet);  // A - B (beforeImgSet - imgListSet)

		List<Image> delete = new ArrayList<Image>(aa);
		return  delete;//deleteImg; //삭제용
		}
		return null;
	}

	private List<Image> checkedImage(MultipartFile[] files) {
		return ci.changeImgName(files);
		
	}
	
	private List<Image> settingImage(List<String> change, List<String> origin, String path, List<String> imgLevel){
		List<Image> imgList = new ArrayList<Image>();
		
		if(change == null) {
			return null;
		}
		for(int i = 0; i < change.size(); i++) {
			Image img = new Image();
			img.setImgPath(path);
			img.setChangeImgName(change.get(i));
			img.setOriginImgName(origin.get(i));
			int num = Integer.parseInt(imgLevel.get(i));
			img.setImgLevel(num);
			imgList.add(img);
		}
		return imgList;
	}
	
	private String deletePath(String path) {
		if(path == null || path.equals("")) {
			return null;
		}
		return path.substring(7);
	}
	
	
	private int deleteImage(List<Image> img) {
		int result = 1;
		for(int i = 0; i < img.size(); i++) {
			result = result * im.deleteImage(img.get(i).getChangeImgName());
		}
		
		return result;
	}
	
	private void checkedDeleteImage(List<Image> img) {
		int result = deleteImage(img);
		if(result == 0) {
			throw new FailDeleteObjectException("사진 저장 실패");
		}
		ci.deleteImage(img);
	}
	
	private int settingNewImage(List<Image> img, Farm farm) {
		int result = 1;
		for(int i = 0; i < img.size(); i++) {
			img.get(i).setPostNo(farm.getFarmNo());
			img.get(i).setCategoryNo(Long.parseLong(String.valueOf(farm.getCategoryNo())));
			
			result = result * im.insertImage(img.get(i));
		}
		
		return result;
	}
	
	private void checkedNewImage(List<Image> img, Farm farm) {
		int result = settingNewImage(img, farm);
		if(result == 0) {
			throw new FailDeleteObjectException("사진 삭제 실패");
		}
	}
	
	private int checkedImgLevel(List<Image> delete) {
		for(int i = 0; i < delete.size(); i++) {
			if(delete.get(i).getImgLevel() == 1) {
				return 0;
			}
		}
		return 1;
	}
	
	private List<Image> settingImgLevel(List<Image> delete, List<Image> newImage) {
		int result = checkedImgLevel(delete);
		if(result == 0) {
			for(int i = 0; i < newImage.size(); i++) {
				newImage.get(i).setImgLevel(2);
			}
		}
		return newImage;
	}
	
	
	private List<Image> settingRest(List<Image> rest){
		if(rest.size() != 0) {
			for(int i = 0; i < rest.size(); i++) {
				if(rest.get(i).getImgLevel() == 1) {
					return rest;
				}
			}
			rest.get(0).setImgLevel(1);
		}
		return rest;
	}
	
	private int settingRestImage(List<Image> img, Farm farm) {
		int result = 1;
		for(int i = 0; i < img.size(); i++) {
			img.get(i).setPostNo(farm.getFarmNo());
			img.get(i).setCategoryNo(Long.parseLong(String.valueOf(farm.getCategoryNo())));
			
			result = result * im.updateImage(img.get(i));
		}
		
		return result;
	}
	
	private void checkedRest(int result) {
		if(result == 0) {
			throw new FailUpdateException("기존 사진 수정 실패.");
		}
	}
	
	private void processImage(List<String> change, List<String> origin, String path, List<String> imgLevel, MultipartFile[] files, List<Image> beImg, Farm farm) {
		List<Image> newImgList = checkedImage(files);
		List<Image> restImg = settingImage(change, origin, deletePath(path), imgLevel);
		List<Image> delete = checkedFarm(restImg, beImg);
		if(delete != null && !(delete.isEmpty())) { // 삭제할 사진이 있을 때
			if(newImgList != null && !(newImgList.isEmpty())) {
				checkedNewImage(settingImgLevel(delete, newImgList), farm); // 지우기 체우기 둘 다
			}
			checkedDeleteImage(delete); // 지우기만
			checkedRest(settingRestImage(settingRest(restImg),farm));
		} else { // 삭제할 사진이 없을 때
			if(newImgList != null && !(newImgList.isEmpty())) {
				if(beImg != null && !(beImg.isEmpty())) { // 기존 사진이 있을 떄
					checkedNewImage(settingImgLevel(beImg, newImgList), farm); // 채우기만
				} else { // 기존 사진이 없을 떄
					checkedNewImage(newImgList, farm);
				}
			}
		}
	}
	
	@Override
	public void updateFarm(Map<String, Object> map) {
		Member member = (Member)map.get("member");
		checkedMember(member);
		Farm farm = (Farm)map.get("farm");
		SelectImageByFarm no = new SelectImageByFarm();
		no.setFarmNo(farm.getFarmNo());
		no.setCategoryNo(3);
		List<Image> beforeImg = im.selectByFarmNo(no);
		List<String> change = (List<String>)map.get("change");
		List<String> origin = (List<String>)map.get("origin");
		List<String> imgLevel = (List<String>)map.get("imgLevel");
		String path = (String)map.get("path");
		Farm beFarm = fm.selectDetailFarm(farm.getFarmNo());
		MultipartFile[] files = (MultipartFile[])map.get("files");
		Address ad = (Address)map.get("address");
		farm.setAddressNo(checkedNewAddress(ad, member));
		int[] facility = (int[])map.get("facilityNo");
		processImage(change, origin, path, imgLevel, files, beforeImg, beFarm);
		updateFacility(facility, beFarm);
		checkedUpdateFarm(checkedChangeFormat(plusFarm(farm, checkedNewAddress(ad, member))));
		
	}
	
	private void deleteFarmByNo(Long farmNo) {
		int result = fm.deleteFarm(farmNo);
		if(result == 0) {
			throw new FailDeleteException("삭제 실패");
		}
	}
	
	private Map<String, Object> makingDeleteImage(Long farmNo, int categoryNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("farmNo", farmNo);
		map.put("categoryNo", categoryNo);
		return map;
	}
	
	private void deleteImg(Map<String, Object> map) {
		int result = im.deleteFarmImg(map);
		if(result == 0) {
			throw new FailDeleteException("사진 삭제 실패");
		}
	}
	
	private List<Review> selectReview(Long farmNo) {
		return rs.selectReviewAll(farmNo);
	}
	
	private List<Image> makingImgNo(List<Review> list){
		List<Image> imgNo = new ArrayList<Image>();
		if(list != null && !(list.isEmpty())) {
			for(int i = 0; i < list.size(); i++) {
				if(list.get(i).getImgList() != null && !(list.get(i).getImgList().isEmpty())) {
					for(int j = 0; j < list.get(i).getImgList().size(); j++) {
						imgNo.add(list.get(i).getImgList().get(j));
					}
				}
			}
		}
		return imgNo;
	}
	
	private int deleteReviewImg(List<Image> imgNo) {
		int result = 1;
		if(imgNo.isEmpty()) {
			return 1;
		}
		for(int i = 0; i < imgNo.size(); i++) {
			result = result * im.deleteImgNo(imgNo.get(i).getImgNo());
		}
		ci.deleteImage(imgNo);
		return result;
	}
	
	private void checkedDeleteImg(List<Image> imgNo) {
		int result = deleteReviewImg(imgNo);
		if(result == 0) {
			throw new FailDeleteException("리뷰 사진 삭제 실패");
		}
	}
	
	private void deleteFarmImage(List<Image> list) {
		ci.deleteImage(list);
	}
	
	@Override
	public void deleteFarm(Long farmNo, int i) {
		List<Image> farmImg = fm.selectDetailFarm(farmNo).getImgList();
		deleteFarmByNo(farmNo);
		//log.info("{}", farmNo);
		deleteImg(makingDeleteImage(farmNo, i));
		deleteFarmImage(farmImg);
		//log.info("리뷰 가기 전 : {}", farmNo);
		rs.deleteReview(farmNo);
		checkedDeleteImg(makingImgNo(selectReview(farmNo)));
	}

}
