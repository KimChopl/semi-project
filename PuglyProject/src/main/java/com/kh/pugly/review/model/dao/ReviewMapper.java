package com.kh.pugly.review.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.review.model.vo.Review;

@Mapper
public interface ReviewMapper {
	List<Review> selectReviewList(Long farmNo, RowBounds rn);
	
	Review selectDetailReview(Long reviewNo);
	
	int updateCount(Long reviewNo);
	
	int reviewCount(Long farmNo);

	int insertReview(Review review);
	
	
}
