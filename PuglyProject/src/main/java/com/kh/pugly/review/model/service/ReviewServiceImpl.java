package com.kh.pugly.review.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.pugly.common.model.vo.MoreInfo;
import com.kh.pugly.common.template.MoreInfomation;
import com.kh.pugly.review.model.dao.ReviewMapper;
import com.kh.pugly.review.model.vo.Review;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
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
		MoreInfo mi = MoreInfomation.getMoreInfo(moreNo, reviewCount, reviewLimit);
		return mi;
	}
	
	private RowBounds getRowBounds(MoreInfo mi) {
		RowBounds rb = new RowBounds(mi.getPlusNo(), mi.getBoardLimit());
		return rb;
	}
	
	@Override
	public List<Review> selectReviewList(int moreNo, Long farmNo) {
		int reviewLimit = 3;
		MoreInfo mi = getMoreInfo(farmNo, moreNo, reviewLimit);
		RowBounds rb = getRowBounds(mi);
		List<Review> review = rm.selectReviewList(farmNo, rb);
		checkedReview(review);
		return review;
	}

	@Override
	public Review selectDetailReview(Long reviewNo) {
		return null;
	}

	@Override
	public int updatCount(Long reviewNo) {
		return 0;
	}
	
}
