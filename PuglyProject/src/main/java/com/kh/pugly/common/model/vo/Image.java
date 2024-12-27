package com.kh.pugly.common.model.vo;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Image {
	private Long imgNo;
	private String originImgName;
	private String changeImgName;
	private Date uploadDate;
	private String imgStatus;
	private int imgLevel;
	private int brigeNo;
}
