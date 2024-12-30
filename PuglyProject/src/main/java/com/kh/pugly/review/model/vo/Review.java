package com.kh.pugly.review.model.vo;

import java.sql.Date;
import java.util.List;

import com.kh.pugly.common.model.vo.Image;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class Review {
	
	private Long reviewNo;
	private String reviewer;
	private int reviewCategoryNo;
	private String reviewCategoryName;
	private String reviewTitle;
	private String reviewContent;
	private int rating;
	private Long reviewPostNo;
	private Date reviewCreateDate;
	private Date reviewModifyFate;
	private List<Image> imgList;

}
