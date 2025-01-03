package com.kh.pugly.common.model.vo;

import java.sql.Date;

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
public class Image {
	private Long imgNo;
	private String originImgName;
	private String changeImgName;
	private String imgPath;
	private Date uploadDate;
	private String imgStatus;
	private int imgLevel;
	private Long postNo;
}
