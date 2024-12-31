package com.kh.pugly.review.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.pugly.common.model.vo.MoreInfo;
import com.kh.pugly.common.template.MoreInfomation;
import com.kh.pugly.review.model.dao.ReviewMapper;
import com.kh.pugly.review.model.vo.Review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReviewServiceImpl implements ReviewService {
	
	private final ReviewMapper rm;

	private void checkedReview(List<Review> review) {
		if(review == null) {
			//Exception
		}
	}
	
	
	private int reviewCount(Long farmNo) {
		int reviewCount = rm.reviewCount(farmNo);
		if(reviewCount < 0) {
			//Exception
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
		//log.info("{}", mi);
		checkedReview(review);
		return review;
	}
	
	@Override
	public List<Review> selectReviewList(int moreNo, Long farmNo) {
		int reviewLimit = 3;
		MoreInfo mi = getMoreInfo(farmNo, moreNo, reviewLimit);
		return selectReview(mi, farmNo);
	}

	@Override
	public Review selectDetailReview(Long reviewNo) {
		return null;
	}

	@Override
	public int updateCount(Long reviewNo) {
		return 0;
	}


	@Override
	public Map<String, Object> selectMoreReview(int moreNo, Long farmNo) {
		int reviewLimit = 5;
		MoreInfo mi = getMoreInfo(farmNo, moreNo, reviewLimit);
		List<Review> review= selectReview(mi, farmNo);
		Map<String, Object> map = new HashMap();
		map.put("review", review);
		mi.setPlusNo(mi.getPlusNo()+reviewLimit);
		map.put("mi", mi);
		return map;
	}
	
}
