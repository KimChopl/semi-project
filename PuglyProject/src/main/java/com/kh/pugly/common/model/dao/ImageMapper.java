package com.kh.pugly.common.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.common.model.vo.Image;

@Mapper
public interface ImageMapper {
	int insertImage(Image img);
	
	
	int deleteFarmImg(Long imgNo);
	
	
	int updateImage(Image img);
}

