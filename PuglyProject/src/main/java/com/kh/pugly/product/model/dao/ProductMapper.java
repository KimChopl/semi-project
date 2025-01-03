package com.kh.pugly.product.model.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.product.model.vo.MyStore;
import com.kh.pugly.product.model.vo.Product;

@Mapper
public interface ProductMapper {

	// 갯수조회
	 int selectTotalCount();
	// 목록조회
	 List<Product> listProduct(RowBounds rowBounds);
	 // 상세조회
	Product detailProduct(Long productNo);
			
	// 상품등록 신버전
	void insertProduct(Product product);
	void insertProductImg(Image image);
	List<Image> findImagesByProductId(Long productNo);
	// 내상점 등록
	void insertMyStore(MyStore myStore);
	void insertMyStoreImg(Image img);


	
	


}
