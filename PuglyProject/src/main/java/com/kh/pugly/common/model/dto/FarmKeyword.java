package com.kh.pugly.common.model.dto;



import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class FarmKeyword {

	private int stateCode;
	private int farmProduct;
	private int minPrice;
	private int maxPrice;
	private int rating;
	private Date firstDate;
	private Date lastDate;
	
}
