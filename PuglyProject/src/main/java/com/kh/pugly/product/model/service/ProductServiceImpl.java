package com.kh.pugly.product.model.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
import com.kh.pugly.exception.BoardNotFoundException;
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
	//사진파일 수정 업로드 신버전
	private List<Image> productSaveImg(MultipartFile[] upfile) {
		
		List<Image> imagesList = new ArrayList<>();	// 여러장 사진을 넣을 리스트
		boolean firstFile = true;					// 첫번째 사진은 true
		
		for(MultipartFile file : upfile) {
			if(!file.isEmpty()) {
				String fileName = file.getOriginalFilename();
				String ext = fileName.substring(fileName.lastIndexOf("."));
				String currentTime = new SimpleDateFormat("yyyymmddHHmmss").format(new Date());
				int randomNum = (int)(Math.random() * 90000) + 10000;
				String changeName = currentTime + randomNum + ext;
				String savePath = context.getRealPath("/resources/upload_files/");
				try {
					file.transferTo(new File(savePath + changeName));
				} catch(IOException e) {
					throw new FailToFileUploadException("파일오류!");
				}
				Image image = new Image();
				image.setOriginImgName(fileName);
				image.setChangeImgName("/pugly/resources/upload_files/" + changeName);
				image.setImgLevel(firstFile ? 1 : 2);	// 첫번째 사진만 1번으로 받는다.
				image.setImgPath("/resources/upload_files/");
						
				imagesList.add(image);
				firstFile = false;	// 반복문을 통해 2번째 사진부터는 false
			}
		}
		return imagesList;
	}
	
	// 페이지 체크
	private int getTotalCount() {
		
		int totalCount = mapper.selectTotalCount();
		
		if(totalCount == 0) {
			throw new BoardNotFoundException("게시글 없음");
		}
		return totalCount;
	}
	// 페이지 수
	private PageInfo getPageInfo(int totalCount, int page) {
		return PagiNation.getPageInfo(totalCount, page, 10, 5);
	}
	// 상품수
	private List<Product> getProductList(PageInfo pi){
		int offset =(pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return mapper.listProduct(rowBounds);
	}
	// 상품이 삭제될때
	private Product findProductById(Long productNo) {
		Product product = mapper.detailProduct(productNo);
		
		return product;
	}
	// 사진리스트 꺼내오기
	private List<Image> findImagesByProductId(Long productNo) {
		List<Image> imageList = (List<Image>) mapper.findImagesByProductId(productNo);
		System.out.println(imageList);
		return imageList;
	}
	

	// 상품등록 메소드 신버전
	@Override
	public void insertProduct(Product product, MultipartFile[] upfile) {
		validateProduct(product);
		
		List<Image> imagesList = productSaveImg(upfile);
		mapper.insertProduct(product);
			
		for(Image imags : imagesList) {
			mapper.insertProductImg(imags);
		}
	}
	
	// 상품 리스트 메소드
	public Map<String, Object>listProduct(int currentPage){
		int totalCount = getTotalCount();
		PageInfo pi = getPageInfo(totalCount, currentPage);
		
		List<Product> products = getProductList(pi);
		
		Map<String, Object> map = new HashMap();
		map.put("products", products);
		map.put("pageInfo", pi);
		return map;
	}
	// 상품 상세보기
	@Override
	public Map<String, Object> deatailProduct(Long productNo) {
		
		Product product = findProductById(productNo);
		
		List<Image> imageList = findImagesByProductId(productNo);
		
		Map<String, Object> responseData = new HashMap();
		responseData.put("product", product);
		responseData.put("imageList", imageList);
		
		return responseData;
	}
	






	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
