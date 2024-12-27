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
	private int categoryNo;
	private String farmTitle;
	private String farmContent;
	private String bewareList;
	private String deleteAsk;
	private int attention;
	private int like;
	private int farmCount;
	private String address;
	private String productName;
	private Date farmCreateDate;
	private Date farmModifyDate;
	private int farmPrice;
	List<Image> imgList;
}
