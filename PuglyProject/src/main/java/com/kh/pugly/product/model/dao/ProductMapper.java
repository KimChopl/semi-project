package com.kh.pugly.product.model.dao;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;


import com.kh.pugly.product.model.vo.Product;

@Mapper
public interface ProductMapper {

	// 상품등록
	 void insertProduct(Product product);
	// 갯수조회
	 int selectTotalCount();
	// 목록조회
	 List<Product> listProduct(RowBounds rowBounds);
	 // 상세조회
	Product deatailProduct(Long productNo);
		


}
