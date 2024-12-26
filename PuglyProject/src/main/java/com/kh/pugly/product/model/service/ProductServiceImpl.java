package com.kh.pugly.product.model.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.exception.controller.ProductValueException;
import com.kh.pugly.product.model.dao.ProductMapper;
import com.kh.pugly.product.model.vo.Product;

import lombok.RequiredArgsConstructor;

@EnableTransactionManagement
@RequiredArgsConstructor
@Service
public class ProductServiceImpl implements ProductService {
	
	private final ProductMapper mapper;
	private final ServletContext context;

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
	/*
	private void handleFileUpload(Product product, MultipartFile[] upfile) {
		String fileName = upfile.getOriginalFilename();
		String ext = fileName.substring(fileName.lastIndexOf("."));
		String currentTime = new SimpleDateFormat("yyyymmddHHmmss").format(new Date());
		int randomNum = (int)Math.random() * 90000 + 10000;
		String changeName = currentTime + randomNum + ext;
		String savePath = context.getRealPath(/resources/)
		
	}
	*/
	
	
	
	
	
	
	
	@Override
	public void insertProduct(Product product, MultipartFile[] upfile) {
		validateProduct(product); // 유효성 검증
	
		//String fileName = upfile.getOriginaFilename();
		
	}
	
	


}
