package com.kh.pugly.farm.model.vo;

import java.sql.Date;
import java.util.List;

import com.kh.pugly.common.model.vo.Image;

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
public class Farm {
	private Long farmNo;
	private String seller;
	private String categoryName;
	private String productName;
	private String farmTitile;
	private String farmContent;
	private Date farmCreateDate;
	private String bewareList;
	private String deleteAsk;
	private Long farmCount;
	private int farmPrice;
	private Date farmModifyDate;
	private String address;
	private List<Image> imgList;
}
