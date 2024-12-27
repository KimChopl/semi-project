package com.kh.pugly.product.model.service;

import org.springframework.web.multipart.MultipartFile;

import com.kh.pugly.product.model.vo.Product;

public interface ProductService {

	void insertProduct(Product product, MultipartFile[] upfile);

}
