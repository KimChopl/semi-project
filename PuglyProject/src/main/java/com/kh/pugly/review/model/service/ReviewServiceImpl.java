package com.kh.pugly.review.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.book.model.service.BookService;
import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.common.model.dao.ImageMapper;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.MoreInfo;
import com.kh.pugly.common.template.ChangeImage;
import com.kh.pugly.common.template.ChangeStringContext;
import com.kh.pugly.common.template.MoreInfomation;
import com.kh.pugly.exception.FailDeleteException;
import com.kh.pugly.exception.FailToFileUploadException;
import com.kh.pugly.exception.NotFoundDetailFarmException;
import com.kh.pugly.exception.NotFoundObjectException;
import com.kh.pugly.exception.NotMatchUserInfomationException;
import com.kh.pugly.farm.model.dao.FarmMapper;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.vo.Member;
import com.kh.pugly.review.model.dao.ReviewMapper;
import com.kh.pugly.review.model.vo.Review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReviewServiceImpl implements ReviewService {
	
	private final ReviewMapper rm;
	private final FarmMapper fm;
	private final MemberMapper mm;
	private final BookService bs;
	private final ChangeImage ci;
	private final ImageMapper im;
	private final ChangeStringContext xss;

	private void checkedReview(List<Review> review) {
		if(review == null) {
			throw new NotFoundObjectException("리뷰 없음");
		}
	}
	
	private void checkedMember(Member loginUser) {
		Member checkMember = mm.selectMemberInfo(loginUser.getMemberNo());
		if(!!!loginUser.getMemberId().equals(checkMember.getMemberId()) || loginUser.getMemberNo() != checkMember.getMemberNo() || !!!loginUser.getNickname().equals(checkMember.getNickname())
				|| !!!loginUser.getMemberName().equals(checkMember.getMemberName())) {
			throw new NotMatchUserInfomationException("유저 정보가 일치하지 않습니다.(리뷰)");
		}
		
	}
	
	private int reviewCount(Long farmNo) {
		int reviewCount = rm.reviewCount(farmNo);
		if(reviewCount < 0) {
			throw new NotFoundObjectException("해당 리뷰 없음");
		}
		return reviewCount;
	}
	
	private MoreInfo getMoreInfo(Long farmNo, int moreNo, int reviewLimit) {
		int reviewCount = reviewCount(farmNo);
		MoreInfo mi = MoreInfomation.getMoreInfo(reviewCount, moreNo, reviewLimit);
		return mi;
	}
	
	private RowBounds getRowBounds(MoreInfo mi) {
		RowBounds rb = new RowBounds(mi.getPlusNo(), mi.getBoardLimit());
		return rb;
	}
	
	private List<Review> selectReview(MoreInfo mi, Long farmNo) {
		
		RowBounds rb = getRowBounds(mi);
		List<Review> review = rm.selectReviewList(farmNo, rb);
		checkedReview(review);
		return review;
	}
	
	private Farm checkedFarm(Farm farm) {
		if(farm == null) {
			throw new NotFoundDetailFarmException("리뷰 달라 했는데 농장이 사라졌어잉");
		}
		return farm;
	}
	
	@Override
	public List<Review> selectReviewList(int moreNo, Long farmNo) {
		int reviewLimit = 3;
		MoreInfo mi = getMoreInfo(farmNo, moreNo, reviewLimit);
		return makingReviewTitle(selectReview(mi, farmNo));
	}

	@Override
	public Review selectDetailReview(Long reviewNo) {
		return null;
	}

	@Override
	public int updateCount(Long reviewNo) {
		return 0;
	}

	private List<Review> makingReviewTitle(List<Review> reviews) {
		if(reviews != null && !(reviews.isEmpty())){
			for(int i = 0; i < reviews.size(); i++) {
				if(reviews.get(i).getReviewContent().length() > 30) {
					
					reviews.get(i).setReviewTitle(reviews.get(i).getReviewContent().substring(0, 30) + "...");
				} else {
					reviews.get(i).setReviewTitle(reviews.get(i).getReviewContent());
				}
				//log.info("{}", reviews.get(i).getReviewTitle());
			}
		}
		return reviews;
	}

	@Override
	public Map<String, Object> selectMoreReview(int moreNo, Long farmNo) {
		int reviewLimit = 5;
		MoreInfo mi = getMoreInfo(farmNo, moreNo, reviewLimit);
		List<Review> review= makingReviewTitle(selectReview(mi, farmNo));
		Map<String, Object> map = new HashMap();
		map.put("review", review);
		mi.setPlusNo(mi.getPlusNo()+reviewLimit);
		map.put("mi", mi);
		return map;
	}


	@Override
	public Map<String, Object> loadReivew(Long farmNo, Long bookNo, Member member) {
		checkedMember(member);
		Farm farm = checkedFarm(fm.selectDetailFarm(farmNo));
		Book book = bs.selectByNo(bookNo, member);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("farm", farm);
		map.put("book", book);
		return map;
	}
	
	
	private List<Image> insertCategoryNo(List<Image> img, Long postNo){
		for(int i = 0; i < img.size(); i++) {
			img.get(i).setCategoryNo(Long.parseLong("4"));
			img.get(i).setPostNo(postNo);
		}
		return img;
	}
	
	private Review insertCategoryByReview(Review review) {
		review.setPostCategoryNo(3);
		review.setReviewCategoryNo(4);
		return review;
	}
	
	private Review settingReviewer(Review review, Member member) {
		review.setReviewer(String.valueOf(member.getMemberNo()));
		return review;
	}
	
	private Review changeXss(Review review) {
		review.setReviewContent(xss.changeInsertFormat(review.getReviewContent()));
		return review;
	}
	
	@Override
	public void insertReview(Review review, MultipartFile[] files, Member member) {
		checkedMember(member);
		//log.info("{}", files);
		checkedInsertReview(rm.insertReview(changeXss(insertCategoryByReview(settingReviewer(review, member)))));
		Long postNo = review.getReviewNo();
		List<Image> img = ci.changeImgName(files);
		if(img != null) {
			insertImage(insertCategoryNo(img, postNo));
		}
		
		
	}

	private void checkedInsertReview(int result) {
		
		if(result == 0) {
			throw new FailToFileUploadException("리뷰 등록 실패");
		}
		
	}

	private void insertImage(List<Image> img) {
		int result = 1;
		for(int i = 0; i < img.size(); i++) {
			result = result * im.insertImage(img.get(i));
		}
		if(result== 0) {
			ci.deleteImage(img);
			throw new FailToFileUploadException("리뷰사진 업로드 실패");
		}
	}

	@Override
	public List<Review> selectReviewAll(Long farmNo) {
		return rm.selectReviewList(farmNo);
	}
	
	

	@Override
	public void deleteReview(Long farmNo) {
		//log.info("들어와서 : {}", farmNo);
		List<Review> list = rm.selectReviewList(farmNo);
		if(list != null && !(list.isEmpty())) {
			int result = rm.deleteReview(farmNo);
			if(result == 0) {
				throw new FailDeleteException("리뷰 삭제 실패");
			}
		}
	}
	
}
