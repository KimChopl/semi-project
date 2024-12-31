package com.kh.pugly.product.model.service;


import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.product.model.vo.Product;

public interface ProductService {
	// 상품 리스트
	Map<String, Object> listProduct(int currentPage);
	// 상품 리스트 사진
	//Map<String, Object> listImage(Image imageNo);
	// 상품 상세조회
	Map<String, Object> deatailProduct(Long productNo);
	// 상품 등록 신버전
	void insertProduct(Product product, MultipartFile[] upfile);



}
