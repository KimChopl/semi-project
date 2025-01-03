package com.kh.pugly.common.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.common.model.vo.Image;

@Mapper
public interface ImageMapper {
	
	
	int deleteFarmImg(Long imgNo);
	
	
	int updateImage(Image img);


	int insertImage(Image image);
}

