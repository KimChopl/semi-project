package com.kh.pugly.common.model.vo;


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
public class MoreInfo {
	private int plusNo;
	private int listCount;
	private int startNo;
	private int lastNo;
	private int boardLimit;
}
