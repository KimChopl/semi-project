package com.kh.pugly.review.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.member.model.vo.Member;
import com.kh.pugly.review.model.vo.Review;

public interface ReviewService {
	
	List<Review> selectReviewList(int moreNo, Long farmNo);
	
	Map<String, Object> selectMoreReview(int moreNo, Long farmNo);
	
	Review selectDetailReview(Long reviewNo);
	
	int updateCount(Long reviewNo);

	Map<String, Object> loadReivew(Long farmNo, Long bookNo, Member member);

	void insertReview(Review review, MultipartFile[] files, Member member);

	List<Review> selectReviewAll(Long farmNo);
	
	void deleteReview(Long farmNo);

}
