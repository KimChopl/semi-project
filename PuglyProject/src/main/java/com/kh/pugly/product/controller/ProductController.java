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
		
		session.setAttribute("myStore", myStore);
		productService.insertMyStore(myStore, upfile);
		return mv.setViewNameAndData("redirect:products", null);
	}
	// 상품등록 
	@PostMapping("insert.pro")
	public ModelAndView insertProduct(Product product, MultipartFile[] upfile, HttpSession session, Image image) {
		
		productService.insertProduct(product, upfile);
		return mv.setViewNameAndData("redirect:products", null);
	}
	// 상품리스트 화면 호출
	@GetMapping("products")
	public ModelAndView listProduct(@RequestParam(value="page", defaultValue="1") int page, HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		Map<String, Object> map = productService.listProduct(page, loginUser.getMemberNo());
		
		Long userNo = (Long) map.get("userNo");
		session.setAttribute("userNo", userNo);
		Long storeNo = (Long) map.get("storeNo");
		session.setAttribute("storeNo", storeNo);
		Long memberNo = (Long) map.get("memberNo");
		session.setAttribute("memberNo", memberNo);
		

		return mv.setViewNameAndData("product/list_product", map);
	}
	// 상품상세 화면 호출
	@GetMapping("products/{id}")
	public ModelAndView detailProduct(@PathVariable(name="id") Long id) {
		Map<String, Object> reponseData = productService.deatailProduct(id);
		return mv.setViewNameAndData("/product/detail_product", reponseData);
	}
	// 내상점 화면 호출
	@GetMapping("stores/{id}")
	public ModelAndView detailMyStore(@PathVariable(name="id")@RequestParam(value="page", defaultValue="1")int page, Long id, HttpSession session) {
		
		Member loginUser= (Member) session.getAttribute("loginUser");
		
		Map<String, Object> reponseData = productService.deatailMyStore(page, id, loginUser.getMemberNo());
		
		Long storeNo = (Long) reponseData.get("storeNo");
		session.setAttribute("storeNo", storeNo);
		MyStore myStore = (MyStore) reponseData.get("myStore");
		session.setAttribute("myStore", myStore);
		Long memberNo = (Long) reponseData.get("memberNo");
		session.setAttribute("memberNo", memberNo);
		
		
		if(loginUser != null) {
			id = loginUser.getMemberNo();
			reponseData.put("loginUser", loginUser);
		} 
			
		
		return mv.setViewNameAndData("/product/my_store", reponseData);
	}

	
	
	
}
