package com.kh.pugly.product.model.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
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
	
	// 상품등록 정상값 확인 메소드
	private void validateProduct(Product product) {
		if(product == null ||
		   product.getProductName() == null || product.getProductName().trim().isEmpty() ||
		   product.getProductPrice() == null || product.getProductPrice().trim().isEmpty() ||
		   product.getProductQuantity() == null || product.getProductQuantity().trim().isEmpty() ||
		   product.getProductContent() == null || product.getProductContent().trim().isEmpty()) { 
			throw new ProductValueException("부적절한 입력값");
		}
	}
	
	// 사진파일 수정 메소드
	private void productSaveImg(Product product, MultipartFile[] upfile) {
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
				product.setProductImg(fileName); // 원본 파일
				product.setNewProductImg("/pugly/resources/upload_files/" + changeName); // 변경된 파일 경로
			}
		}
	}
	// 페이지 체크
	private int getTotalCount() {
		
		int totalCount = mapper.selectTotalCount();
		
		if(totalCount == 0) {
		}
		return totalCount;
	}
	// 페이지 수
	private PageInfo getPageInfo(int totalCount, int page) {
		return PagiNation.getPageInfo(totalCount, page, 10, 5);
	}
	private List<Product> getProductList(PageInfo pi){
		int offset =(pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return mapper.listProduct(rowBounds);
	}
	// 상품이 삭제될때
	private Product findProductById(Long productNo) {
		Product product = mapper.deatailProduct(productNo);
		
		return product;
	}
	
	// 상품등록 메소드
	@Override
	public void insertProduct(Product product, MultipartFile[] upfile) {
		validateProduct(product); // 유효성 검증
	
		for(MultipartFile file : upfile) {
			if(!("".equals(file.getOriginalFilename()))) {
				productSaveImg(product, upfile);
			}
		}
		mapper.insertProduct(product);
	}
	// 상품 리스트 메소드
	public Map<String, Object>listProduct(int currentPage){
		
		int totalCount = getTotalCount();
		
		PageInfo pi = getPageInfo(totalCount, currentPage);
		
		List<Product> products = getProductList(pi);
								
		Map<String, Object> map = new HashMap();
		map.put("products", products);
		map.put("pageInf", pi);
		
		return map;
	}

	@Override
	public Map<String, Object> deatailProduct(Long productNo) {
		
		Product product = findProductById(productNo);
		Map<String, Object> responseData = new HashMap();
		responseData.put("product", product);
		return responseData;
		
	}






	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
