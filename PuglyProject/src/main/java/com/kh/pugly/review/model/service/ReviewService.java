package com.kh.pugly.review.model.service;

import java.util.List;

import com.kh.pugly.review.model.vo.Review;

public interface ReviewService {
	
	List<Review> selectReviewList(int moreNo, Long farmNo);
	
	Review selectDetailReview(Long reviewNo);
	
	int updatCount(Long reviewNo);
	
	

}
