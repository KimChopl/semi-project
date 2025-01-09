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

import org.apache.catalina.Store;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
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
				String savePath = context.getRealPath("resources/upload_files/");
				
				try {
					file.transferTo(new File(savePath + changeName));
				} catch(IOException e) {
					throw new FailToFileUploadException("파일오류!");
				}
				
				Image image = new Image();
				image.setOriginImgName(fileName);
				image.setChangeImgName(changeName);
				image.setImgLevel(firstFile ? 1 : 2);	// 첫번째 사진만 1번으로 받는다.
				image.setImgPath("resources/upload_files/");
						
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
		String savePath = context.getRealPath("resources/mystore_profile/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch(IOException e) {
			throw new FailToFileUploadException("파일오류!");
		}
		
		Image image = new Image();
		image.setOriginImgName(fileName);
		image.setChangeImgName(changeName);
		image.setImgLevel(1);
		image.setImgPath("resources/mystore_profile/");
		
		return image;	   
	}
	
	// 페이지 체크
	private int getTotalCount() {
		
		int totalCount = mapper.selectTotalCount();
		return totalCount;
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
	// 유저번호 넣어서 상점 정보 빼오고
	private Long getUserNoSelectStoreNo(Long userNo) {
		return mapper.getUserNoSelectStoreNo(userNo);
	}
	// 상품 번호로 사진 검색하기
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
		//페이지 정보
		PageInfo pi = getPageInfo(totalCount, currentPage);
		// 상품리스트
		List<Product> products = getProductList(pi);
		
		// 상점번호 있는지 확인
		Long storeNo = getUserNoSelectStoreNo(userNo);
		
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
		// 상품수, 페이지수
		int totalCount = getTotalCount();
		PageInfo pi = getStorePage(totalCount, currentPage);
		
		MyStore myStore = findMyStoreById(storeNo);
		Image image = findImageByMyStore(storeNo);
		List<Product> products = getProductStore(pi, storeNo);
		
		Map<String, Object> responseData = new HashMap();
		responseData.put("products", products);
		responseData.put("pageInfo", pi);
		responseData.put("myStore", myStore);
		responseData.put("image", image);
		responseData.put("storeNo", storeNo);
		
		return responseData;

	}
	// 내상점 업데이트
	@Override
	public void storeUpdate(MyStore myStore, MultipartFile upfile) {
		
		
		MyStore store = findMyStoreById(myStore.getStoreNo());
		Long storeNo =store.getStoreNo();
		
		Image image = findImageByMyStore(myStore.getStoreNo());
		log.info("이거한번보자{}",image);
		// 기존 사진정보 삭제해버려
		mapper.storeImgDelete(image);
		if(image != null && !upfile.getOriginalFilename().equals("")) {
			
			String realPath = context.getRealPath(image.getChangeImgName());
			// 가짜 경로 뽑아서  
			if(realPath != null) {
				int indexOfPugly = realPath.indexOf("pugly");
				
				if(indexOfPugly != -1) {
					String fixePath = realPath.substring(0, indexOfPugly) + realPath.substring(indexOfPugly + "pugly".length());
				// 서브스트링으로 진짜경로 만들기
					File file = new File(fixePath);
					file.delete();
				}
			}
		}
		// 새사진 다시넣어
		Image img = myStoreSaveImg(upfile);
		
		
		Map<String, Object> map = new HashMap();
		map.put("storeNo", storeNo);
		map.put("originImgName", img.getOriginImgName());
		map.put("changeImgName", img.getChangeImgName());
		map.put("imgPath", img.getImgPath());
		
		// 새로운 정보 다시 추가해
		mapper.storeImgUpdate(map);
		// 상점수정
		mapper.storeUpdate(myStore);
	}
	// 상품삭제할꺼야~ 키키
	@Override
	public void deleteProduct(Long productNo, String changeImgName) {
		
		log.info("{}", changeImgName);
		if(!("".equals(changeImgName))) {
			try {
				new File(context.getRealPath(changeImgName)).delete();
				log.info("성공!");
			} catch(RuntimeException e) {
				log.info("실패!");
			}
		}
		
		log.info("작동잘해?!");
		
		findProductById(productNo);
		
		int result = mapper.deleteProduct(productNo);
		
		if(result <= 0) {
			log.info("실패!");
		}
		
		
		
	}
	@Override
	public void productUpdate(Product product, MultipartFile[] upfile) {
		
		log.info("상품이요{}",product);
		
		findProductById(product.getProductNo());
		List<Image> imgList = findImagesByProductId(product.getProductNo());
		
		if(imgList != null && ! imgList.isEmpty()) {
			String imgName = imgList.get(0).getChangeImgName();
			System.out.println("이미지 이름 : " + imgName);
		}
		
		for(MultipartFile file : upfile) {
			
			
			if(!file.getOriginalFilename().equals("")) {
				log.info("{}",file);
				
				
				for(Image img : imgList) {
					log.info("{}",img);
				
					if(img.getChangeImgName() != null){
						new File(context.getRealPath(img.getChangeImgName())).delete();
						log.info("삭제했니?");
					}
				}
				
				List<Image> img = productSaveImg(upfile);
				
				for(int i = 0; i < img.size(); i++) {
					log.info("{}", imgList.get(i).getImgNo());
					img.get(i).setImgNo(imgList.get(i).getImgNo());
					
					log.info("{}", img);
					
					
					
				}
				log.info("{}", img);
				int result = mapper.updateImgProduct(img);
				if(result < 1) {
					log.info("응업뎃 실패~");
				
				}
			}
		}
		if(mapper.productUpdate(product) > 0) {
			
			log.info("상품업뎃 실패~");
		}
		
	}



	
	





	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
