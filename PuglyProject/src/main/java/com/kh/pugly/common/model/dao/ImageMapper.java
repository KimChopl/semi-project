package com.kh.pugly.common.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.SelectImageByFarm;

@Mapper
public interface ImageMapper {
	
	
	int deleteFarmImg(Map<String, Object> map);
	
	
	int updateImage(Image img);


	int insertImage(Image image);


	int deleteImage(String changeImgName);
	
	List<Image> selectByFarmNo(SelectImageByFarm no);


	int deleteImgNo(Long imgNo);
}

