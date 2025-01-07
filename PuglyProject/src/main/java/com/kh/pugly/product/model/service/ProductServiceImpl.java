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
import com.kh.pugly.product.model.vo.MyStore;
import com.kh.pugly.product.model.vo.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
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
				
				String changeName = "ProductImg" + currentTime + randomNum + ext;
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
	// 내상점 이미지 저장
	private Image myStoreSaveImg(MultipartFile upfile) {
		
		String fileName = upfile.getOriginalFilename();
		String ext = fileName.substring(fileName.lastIndexOf("."));
		String currentTime = new SimpleDateFormat("yyyymmddHHmmss").format(new Date());
		
		int randomNum = (int)(Math.random() * 90000) + 10000;
		
		String changeName = "StoreImg" + currentTime + randomNum + ext;
		String savePath = context.getRealPath("/resources/mystore_profile/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch(IOException e) {
			throw new FailToFileUploadException("파일오류!");
		}
		
		Image image = new Image();
		image.setOriginImgName(fileName);
		image.setChangeImgName("/pugly/resources/mystore_profile/" + changeName);
		image.setImgLevel(1);
		image.setImgPath("/resources/mystore_profile/");
		
		return image;	   
	}
	
	// 페이지 체크
	private int getTotalCount() {
		
		int totalCount = mapper.selectTotalCount();
		
		if(totalCount == 0) {
			throw new BoardNotFoundException("게시글 없음");
		}
		return totalCount;
	}
	// 상점 숫자 체크
	private Long getMySotreNoList(Long userNo) {
		Long storeNo = mapper.getStoreByuserNo(userNo);
		return storeNo;
		
	}
	// 페이지 수
	private PageInfo getPageInfo(int totalCount, int page) {
		return PagiNation.getPageInfo(totalCount, page, 10, 5);
	}
	// 내상점 페이지수
	private PageInfo getStorePage(int totalCount, int page) {
		return PagiNation.getPageInfo(totalCount, page, 5, 5);
	}
	
	// 상품수
	private List<Product> getProductList(PageInfo pi){
		int offset =(pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return mapper.listProduct(rowBounds);
	}
	// 내상점 상품수
	private List<Product> getProductStore(PageInfo pi, Long storeNo){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return mapper.myStoreProduct(rowBounds, storeNo);
	}
	// 상품전체조회
	private Product findProductById(Long productNo) {
		Product product = mapper.detailProduct(productNo);
		return product;
	}
	
	// 내상점보여줄래
	private MyStore findMyStoreById(Long storeNo) {
		MyStore myStore = mapper.detailMyStore(storeNo);
		return myStore;
	}
	// 내상점 사진꺼낼래
	private Image findImageByMyStore(Long myStoreNo) {
		Image img = mapper.findImageByMyStore(myStoreNo);
		return img;
	}
	// 상품사진리스트 꺼내오기
	private List<Image> findImagesByProductId(Long productNo) {
		List<Image> imageList = (List<Image>) mapper.findImagesByProductId(productNo);
		return imageList;
	}
	// 유저번호로 이용하여 상점번호 조회
	public Long getStoreNoByMemberNo(Long memberNo) {
		return mapper.selectStoreNoByMemberNo(memberNo);
	}

	// 상품등록 메소드 
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
	public Map<String, Object>listProduct(int currentPage, Long userNo){
		// 상품수
		int totalCount = getTotalCount();
		
		// 상점번호 있는지 확인
		Long storeNo = getMySotreNoList(userNo);
		//페이지 정보
		PageInfo pi = getPageInfo(totalCount, currentPage);
		
		// 상품리스트
		List<Product> products = getProductList(pi);
		
		
		Map<String, Object> map = new HashMap();
		map.put("products", products);
		map.put("pageInfo", pi);
		map.put("storeNo", storeNo);
		map.put("userNo", userNo);
		
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
	// 내상점 등록
	@Override
	public void insertMyStore(MyStore myStore, MultipartFile upfile) {
		Image img = myStoreSaveImg(upfile);
		mapper.insertMyStore(myStore);
		mapper.insertMyStoreImg(img);
	}

	// 내상점 보여주기
	@Override
	public Map<String, Object> deatailMyStore(int currentPage, Long storeNo) {
		
		int totalCount = getTotalCount();
		PageInfo pi = getStorePage(totalCount, currentPage);
		
		MyStore myStore = findMyStoreById(storeNo);
		Image image = findImageByMyStore(storeNo);
		List<Product> products = getProductStore(pi, storeNo);
		
		Map<String, Object> responseData = new HashMap();
		responseData.put("products", products);
		responseData.put("myStore", myStore);
		responseData.put("image", image);
		responseData.put("storeNo", storeNo);
		
		return responseData;
	}
	@Override
	public void storeUpdate(MyStore myStore, MultipartFile upfile) {
		
		findMyStoreById(myStore.getStoreNo());
		Image image = findImageByMyStore(myStore.getStoreNo());
		
		if(image != null && !upfile.getOriginalFilename().equals("")) {
			
			String filePath = context.getRealPath(image.getChangeImgName());
			log.info("{} / {}",image,filePath);
			if(filePath != null) {
				File file = new File(filePath);
				
	
				log.info("File object: " + file);  // File 객체 확인
				if (file.exists()) {
				    log.info("파일 존재: " + file.getAbsolutePath());
				    if (file.delete()) {
				        log.info("삭제 성공!");
				    } else {
				        log.error("파일 삭제 실패: 권한 문제?");
				    }
				} else {
				    log.error("파일 존재하지 않음: " + filePath);
				}
				
				
				
				
				
				
				
				
				if(file.exists() && file.delete()) {
					log.info("삭제성공!");
				} else {
					log.info("삭제실패!");
				}
			}
			Image img = myStoreSaveImg(upfile);
			mapper.storeImgUpdate(img);
			
		}
		// 상점수정은 정상작동해~
		mapper.storeUpdate(myStore);
	}



	
	





	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
