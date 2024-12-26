package com.kh.pugly.product.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pugly.common.ModelAndViewUtil;
import com.kh.pugly.product.model.service.ProductService;
import com.kh.pugly.product.model.vo.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequiredArgsConstructor
public class ProductController {

	private final ProductService productService;
	private final ModelAndViewUtil mv;
	
	// 테스트 화면
	@GetMapping("testmain")
	public String testMain() {
		return "product/test-main";
	}
	
	// 내상점 화면 호출
	@GetMapping("mystore.form")
	public String myStore() {
		
		return "product/my_store";
	}
	
	// 상품등록 화면 호출
	@GetMapping("insert.form")
	public String insertform() {
		return "product/insert_product";
	}
	
	@PostMapping("insert.pro")
	public ModelAndView insertProduct(Product product, MultipartFile[] upfile, HttpSession session) {
		
		log.info("게시글 정보 : {}, 파일정보 : {}", product, upfile);
		
		
		productService.insertProduct(product, upfile, null);
		
		session.setAttribute("alertMsg", "상품 등록완료!");
		
		
		return mv.setViewNameAndData("redirect:testmain", null);
	}
	
	// 상품리스트 화면 호출
	@GetMapping("list.form")
	public String listProduct() {
		return "product/list_product";
	}
	// 상품상세 화면 호출
	@GetMapping("detail.form")
	public String detailProduct() {
		return "product/detail_product";
	}
	
	
	
	
	
}
