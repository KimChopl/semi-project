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
	
	
	// 내상점 화면 호출
	@GetMapping("/mystores")
	public String myStore() {
		
		return "product/my_store";
	}
	
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
		log.info("{}", member);
		log.info("{}", session);
		log.info("게시글 정보 : {}, 파일 정보: {}", myStore, upfile);
		productService.insertMyStore(myStore, upfile);
		return mv.setViewNameAndData("redirect:products", null);
	}
	// 상품등록 
	@PostMapping("insert.pro")
	public ModelAndView insertProduct(Product product, MultipartFile[] upfile, HttpSession session, Image image) {
		
		log.info("게시글 정보 : {}, 파일 정보 : {}", product, upfile);
		productService.insertProduct(product, upfile);
		return mv.setViewNameAndData("redirect:products", null);
	}
	// 상품리스트 화면 호출
	@GetMapping("products")
	public ModelAndView listProduct(@RequestParam(value="page", defaultValue="1") int page, HttpSession session) {
		
		Map<String, Object> map = productService.listProduct(page);
		
		// 로그인한 사용자 정보를 세션에서 뽑음
		Object loginUser = session.getAttribute("loginUser");
		
		// 로그인유저가 myStore 정보가있는지 확인!
		if (loginUser != null && loginUser instanceof Member) {
	        Member member = (Member) loginUser;
	        // 상점정보가 세션에있는지 확인
	        MyStore myStore = (MyStore) session.getAttribute("myStore");
	        
	        // 만약 상점 정보가 없다면 가져오기
	        if(myStore == null) {
	        	myStore = productService.getStoreByUserNo(member.getMemberNo());
	        }
	        // 상점 정보가 있으면 map에 추가
	        map.put("myStore", myStore);
		}
		
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
