package com.kh.pugly.product.model.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.product.model.vo.MyStore;
import com.kh.pugly.product.model.vo.Product;
@Mapper
public interface ProductMapper {

	// 갯수조회
	 int selectTotalCount();
	 // 상점번호조회
	 Long getStoreByuserNo(Long userNo);
	 
	// 목록조회
	 List<Product> listProduct(RowBounds rowBounds);
	 Long getUserNoSelectStoreNo(Long myStore);
	 // 상세조회
	Product detailProduct(Long productNo);
			
	// 상품등록 신버전
	void insertProduct(Product product);
	void insertProductImg(Image image);
	List<Image> findImagesByProductId(Long productNo);
	Long selectStoreNoByMemberNo(Long userNo);
	// 내상점 등록
	void insertMyStore(MyStore myStore);
	void insertMyStoreImg(Image img);
	// 내상점 보여줄래
	MyStore detailMyStore(Long storeNo);
	Image findImageByMyStore(Long myStoreNo);
	List<Product> myStoreProduct(RowBounds rowBounds, Long storeNo);
	// 상점업데이트
	int storeUpdate(MyStore myStore);
	void storeImgUpdate(Map<String, Object> map);
	void storeImgDelete(Image image);
	// 상품삭제
	int deleteProduct(Long productNo);
	// 상품 업데이트
	int productUpdate(Product product);
	int updateImgProduct(List<Image> imgList);
	
	


	
	


}
