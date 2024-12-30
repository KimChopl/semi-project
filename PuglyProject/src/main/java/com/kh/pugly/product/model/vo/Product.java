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
public class Product {
	
	private Long productNo;					// 상품 번호
	private String productName;				// 상품 이름
	private String productPrice;			// 상품 가격
	private String productContent;			// 상품 설명
	private String productQuantity;			// 상품 수량
	private int productCount;				// 상품 조회수
	private String productStatus;			// 상품 상태
	private Date productDate;				// 상품 등록일
	private String unitName;				// 상품단위
	private String deliveryPrice;			// 배송비
	
	
	private String productImg;				// 사진
	private String newProductImg;			// 사진수정
	
	

	
	

}
