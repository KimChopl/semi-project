package com.kh.pugly.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.pugly.review.model.vo.Review;

public interface ReviewService {
	
	List<Review> selectReviewList(int moreNo, Long farmNo);
	
	Map<String, Object> selectMoreReview(int moreNo, Long farmNo);
	
	Review selectDetailReview(Long reviewNo);
	
	int updateCount(Long reviewNo);
	
	

}
