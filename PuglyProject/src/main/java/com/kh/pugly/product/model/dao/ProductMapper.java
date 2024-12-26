package com.kh.pugly.product.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.product.model.vo.Product;

@Mapper
public interface ProductMapper {

	// 상품등록
	public void insertProduct(Product product, Image image);

}
