package com.kh.pugly.common.model.dao;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.farm.model.dto.ImageBrige;

public interface ImageMapper {
	int insertImage(Image img);
	
	int insertImageBrige(ImageBrige ib);
	
	int deleteFarmImg(Long imgNo);
	
	int deleteImgBrige(ImageBrige ib);
	
	int updateImage(Image img);
}
