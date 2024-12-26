package com.kh.pugly.product.model.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.exception.controller.ProductValueException;
import com.kh.pugly.product.model.vo.Product;

import lombok.RequiredArgsConstructor;

@EnableTransactionManagement
@RequiredArgsConstructor
@Service
public class ProductServiceImpl implements ProductService {
	
	@Override
	public void insertProduct(Product product, MultipartFile[] upfile) {
		
	}
	

	
	
	
	
	private void validateProduct(Product product) {
		// 파일 들어왔는지 확인
		if(product == null ||
		   product.getProductName() == null || product.getProductName().trim().isEmpty() ||
		   product.getProductPrice() == null || product.getProductPrice().trim().isEmpty() ||
		   product.getProductQuantity() == null || product.getProductQuantity().trim().isEmpty() ||
		   product.getUnitName() == null || product.getUnitName().trim().isEmpty() ||
		   product.getProductContent() == null || product.getProductContent().trim().isEmpty() ||
		   product.getCategoryName() == null || product.getCategoryName().trim().isEmpty()) {
			throw new ProductValueException("부적절한 입력값");
		}
		
	}

}
