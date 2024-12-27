package com.kh.pugly.product.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter				
@Setter				
@ToString			
@NoArgsConstructor	// 기본생성자
@AllArgsConstructor	// 매개변수 생성자
public class Product {
	
	private Long productNo;					// 상품 번호
	private String productName;				// 상품 이름
	private String productPrice;			// 상품 가격
	private String productContent;			// 상품 설명
	private String productQuantity;			// 상품 수량
	private int productCount;				// 상품 조회수
	private String productStatus;			// 상품 상태
	private Date productDate;				// 상품 등록일
	
	private String productImg;				// 상품사진 이름
	private String newProductImg;			// 상품사진 수정이름
	
	private Long unitNo;					// 상품 단위번호
	private String unitName;				// 상품 단위타입
	
	private Long deliveryNo;				// 배송유무 번호
	private String deliveryPrice;			// 배송금액
	
	private Long categoryNo;				// 상품 카테고리 번호
	private String categoryName;			// 상품 카테고리 타입
	
	

}
