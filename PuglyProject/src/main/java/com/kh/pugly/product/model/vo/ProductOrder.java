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
public class ProductOrder {
	
	private Long orderNo;			// 주문 결제번호
	private String requestTitle;	// 주문 요청메시지
	private String buyQuantity;		// 구매 수량
	private Date buyDate;			// 결제 날짜
	
	private Long requestNo;			// 요청사항 번호
	private String requestName;		// 요청사항 타입 

}

