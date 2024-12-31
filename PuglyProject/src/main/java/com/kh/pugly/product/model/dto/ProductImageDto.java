package com.kh.pugly.product.model.dto;

import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.product.model.vo.Product;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ProductImageDto {
	private Product product;
	private Image image;

}
