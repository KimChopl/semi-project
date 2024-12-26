package com.kh.pugly.product.model.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.exception.FailToFileUploadException;
import com.kh.pugly.exception.ProductValueException;
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
	
	private void handleFileUpload(Product product, MultipartFile[] upfile, Image image) {
		for (MultipartFile file : upfile) {
			if(!file.isEmpty()) {
				String fileName = file.getOriginalFilename(); // 각 파일의 원본 파일 이름
				String ext = fileName.substring(fileName.lastIndexOf(".")); // 확장자 추출
				String currentTime = new SimpleDateFormat("yyyymmddHHmmss").format(new Date());
				int randomNum = (int)Math.random() * 90000 + 10000; // 랜덤번호생성
				String changeName = currentTime + randomNum + ext; // 새로운 파일 이름
				String savePath = context.getRealPath("/resources/upload_files/"); // 저장경로
				try {
					file.transferTo(new File(savePath + changeName)); //파일을 지정된 경로에 저장
				} catch (IOException e) {
					throw new FailToFileUploadException("파일오류!");
				}
				// 이미지 파일 정보
				image.setOriginImgName(fileName); // 원본 파일
				image.setChangeImgName("/pugly/resources/upload_files/" + changeName); // 변경된 파일 경로
			}
		}
	}
	
	
	
	
	
	
	
	
	@Override
	public void insertProduct(Product product, MultipartFile[] upfile, Image image) {
		validateProduct(product); // 유효성 검증
	
		if(!("".equals(image.getOriginImgName()))) {
			handleFileUpload(product, upfile, image);
		}
		mapper.insertProduct(product, image);
	}
	
	


}
