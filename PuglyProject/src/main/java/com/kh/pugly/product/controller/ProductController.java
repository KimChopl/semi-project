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
	@GetMapping("mystore")
	public String myStore() {
		
		return "product/my_store";
	}
	
	// 상품등록 화면 호출
	@GetMapping("insert_form")
	public String insertForm() {
		return "product/insert_product";
	}
	
	// 상품등록 
	@PostMapping("insert.pro")
	public ModelAndView insertProduct(Product product, MultipartFile[] upfile, HttpSession session, Image image) {
		
		log.info("게시글 정보 : {}, 파일 정보 : {}", product, upfile);
		productService.insertProduct(product, upfile);
		return mv.setViewNameAndData("redirect:testmain", null);
	}
	// 상품리스트 화면 호출
	@GetMapping("products")
	public ModelAndView listProduct(@RequestParam(value="page", defaultValue="1") int page) {
		
		Map<String, Object> map = productService.listProduct(page);
		
		return mv.setViewNameAndData("product/list_product", map);
	}
	// 상품상세 화면 호출
	@GetMapping("products/{id}")
	public ModelAndView detailProduct(@PathVariable(name="id") Long id) {
		//log.info("{}", id);
		Map<String, Object> reponseData = productService.deatailProduct(id);
		return mv.setViewNameAndData("/product/detail_product", reponseData);
		

	}
	
	
	
	
	
}
