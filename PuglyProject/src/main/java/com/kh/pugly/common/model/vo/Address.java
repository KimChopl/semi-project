package com.kh.pugly.common.model.vo;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Address {

	private Long addressNo;
	private String stateCode;
	private String stateName;
	private int addressType;
	private String district;
	
}
