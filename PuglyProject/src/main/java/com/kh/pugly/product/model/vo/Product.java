package com.kh.pugly.product.model.vo;

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
@ToString			
@NoArgsConstructor	
@AllArgsConstructor	
@Builder			
public class Product {
	
	private Long productNo;					// 상품 번호
	private String productName;				// 상품 이름
	private String productPrice;			// 상품 가격
	private String productContent;			// 상품 설명
	private String productQuantity;			// 상품 수량
	private int productCount;				// 상품 조회수
	private String productStatus;			// 상품 상태
	private String productDate;				// 상품 등록일
	private String unitName;				// 상품단위
	private String deliveryPrice;			// 배송비
	private String productType;				// 상품타입
	
	private Image image;					
	private List<Image> imageList;
}
