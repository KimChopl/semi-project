package com.kh.pugly.member.mypage.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.product.model.vo.Product;

@Mapper
public interface MyPageMapper {

	int selectMyCartAll(Long memberNo);
	
	List<Product> selectMyCartList(Long memberNo, RowBounds rowBounds);
	
	int selectMyFarmCount(Long memberNo);
	
}
