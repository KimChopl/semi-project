package com.kh.pugly.product.model.service;


import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.product.model.vo.MyStore;
import com.kh.pugly.product.model.vo.Product;

public interface ProductService {
	// 상품 리스트
	Map<String, Object> listProduct(int currentPage, Long userNo);
	// 상품 상세조회
	Map<String, Object> deatailProduct(Long productNo);
	// 상품 등록
	void insertProduct(Product product, MultipartFile[] upfile);
	Long getStoreNoByMemberNo(Long memberNo);
	// 내상점 등록
	void insertMyStore(MyStore myStore, MultipartFile upfile);
	// 내상점 보여주기
	Map<String, Object> deatailMyStore(int currentPage, Long storeNo);
	// 내상점 업데이트
	void storeUpdate(MyStore myStore, MultipartFile upfile);
	// 상품삭제
	void deleteProduct(Long productNo, String changeImgName);
	// 상품 업데이트!
	void productUpdate(Product product, MultipartFile[] upfile);
	




}
