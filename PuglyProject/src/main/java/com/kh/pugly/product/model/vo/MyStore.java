package com.kh.pugly.product.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter				// 겟
@Setter				// 셋
@ToString			// 투스트링
@NoArgsConstructor	// 기본생성자
@AllArgsConstructor	// 매개변수 생성자
@Builder			// 빌더패턴
public class MyStore {
	
	private Long storeNo;			// 내상점 번호
	private String storeTitle;		// 상점 이름
	private String storeContent;	// 상점 소개
	private int storeCount;		// 상점 조회수
	
	private Long userNo;
}
