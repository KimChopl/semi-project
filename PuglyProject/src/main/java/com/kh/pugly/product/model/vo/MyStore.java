package com.kh.pugly.product.model.vo;

import java.util.Date;

import com.kh.pugly.common.model.vo.Image;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter				
@Setter				
@ToString			
@NoArgsConstructor	
@AllArgsConstructor	
@Builder			
public class MyStore {
	
	private Long storeNo;			// 내상점 번호
	private String storeTitle;		// 상점 이름
	private String storeContent;	// 상점 소개
	private int storeCount;		// 상점 조회수
	
	private Long userNo;		// 회원번호식별
	
	private Image image;
}
