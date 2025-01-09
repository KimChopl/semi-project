package com.kh.pugly.product.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.member.model.vo.Member;
import com.kh.pugly.product.model.service.ProductService;
import com.kh.pugly.product.model.vo.MyStore;
import com.kh.pugly.product.model.vo.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequiredArgsConstructor
public class ProductController {

	private final ProductService productService;
	private final ModelAndViewUtil mv;

	
	// 상품등록 화면 호출
	@GetMapping("/insert_form")
	public String insertForm() {
		return "product/insert_product";
	}
	// 내상점 등록
	@PostMapping("insert.store")
	public ModelAndView insertStore(MyStore myStore, MultipartFile upfile, HttpSession session, Image image) {
		Member member = (Member)session.getAttribute("loginUser");
		myStore.setUserNo(member.getMemberNo());
		
		productService.insertMyStore(myStore, upfile);
		
		session.setAttribute("myStore", myStore);
		return mv.setViewNameAndData("redirect:products", null);
	}
	// 상품등록 
	@PostMapping("insert.pro")
	public ModelAndView insertProduct(Product product, MultipartFile[] upfile, HttpSession session, Image image) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		if(loginUser != null) {
			Long userNo = loginUser.getMemberNo();
			// 로그인 유저로 상점번호 조회
			Long storeNo = productService.getStoreNoByMemberNo(userNo);
			
			if (storeNo != null) {
				product.setStoreNo(storeNo);
			}
		}
		productService.insertProduct(product, upfile);
		return mv.setViewNameAndData("redirect:products", null);
	}
	// 상품리스트 화면 호출
	@GetMapping("products")
	public ModelAndView listProduct(@RequestParam(value="page", defaultValue="1") int page, HttpSession session) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		
		//로그인한 판매자 계정 버튼 요소를 보이기 위해 세션값이 필요함
		if(loginUser != null) {
			
			Long userNo = loginUser.getMemberNo();
			Map<String, Object> map = productService.listProduct(page, userNo);
			Object storeNo = map.get("storeNo");
			Object memberNo = map.get("userNo");
			session.setAttribute("storeNo", storeNo);
			session.setAttribute("userNo", memberNo);
			
			return mv.setViewNameAndData("product/list_product", map);
		}
		// 조건문을 안쓰면 비로그인은 아예 못들어감 그럼 위에 만든게 의미없음
		Map<String, Object> map = productService.listProduct(page, null);
		return mv.setViewNameAndData("product/list_product", map);
		
	}
	// 상품상세 화면 호출
	@GetMapping("products/{id}")
	public ModelAndView detailProduct(@PathVariable(name="id") Long id) {
		
		Map<String, Object> reponseData = productService.deatailProduct(id);
		
		return mv.setViewNameAndData("/product/detail_product", reponseData);
	}
	// 내상점 화면 호출
	@GetMapping("stores/{storeNo}")
	public ModelAndView detailMyStore(@PathVariable(name="storeNo")Long storeNo, @RequestParam(value="page", defaultValue="1")int page, HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");

		session.setAttribute("storeNo", storeNo);
		
		Map<String, Object> reponseData = productService.deatailMyStore(page, storeNo);
		MyStore myStore = (MyStore) reponseData.get("myStore");
		session.setAttribute("myStore", myStore);
		
		return mv.setViewNameAndData("/product/my_store", reponseData);
	}
	// 내상점 업데이트할꺼야~
	@PostMapping("update.store")
	public ModelAndView storeUpdate(MyStore myStore, MultipartFile upfile, HttpSession session) {
		
		productService.storeUpdate(myStore, upfile);
		Long storeNo = (Long) session.getAttribute("storeNo");
		return mv.setViewNameAndData("redirect:/stores/" + storeNo, null);
	}
	// 상품 업데이트할꺼야~
	@PostMapping("update.product")
	public ModelAndView productUpdate(Product product, MultipartFile[] upfile, HttpSession session) {
		log.info("{} / {} ", product, upfile);
		
		productService.productUpdate(product, upfile);
		
		// 이건 수정한곳으로 돌아가기위한 세션!
		Long storeNo = (Long) session.getAttribute("storeNo");
		return mv.setViewNameAndData("redirect:/stores/" + storeNo , null);
		
	}
	
	
	// 상품 삭제할꺼야~
	@PostMapping("/delete.product")
	public ModelAndView deleteProduct(Long productNo, String changeImgName, HttpSession session) {
		productService.deleteProduct(productNo, changeImgName);
		
		Long storeNo = (Long) session.getAttribute("storeNo");
		return mv.setViewNameAndData("redirect:/stores/" + storeNo , null);
	}
	
	
}
