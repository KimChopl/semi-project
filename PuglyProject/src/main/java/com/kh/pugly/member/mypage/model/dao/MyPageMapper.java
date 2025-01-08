package com.kh.pugly.member.mypage.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.product.model.vo.Product;
import com.kh.pugly.reply.model.vo.Reply;

@Mapper
public interface MyPageMapper {

	int selectMyCartAll(Long memberNo);
	
	List<Product> selectMyCartList(Long memberNo, RowBounds rowBounds);
	
	int selectMyFarmCount(Long memberNo);
	
	List<Farm> selectMyFarmList(Long memberNo, RowBounds rowBounds);
	
	int selectMyReplyCount(Long memberNo);
	
	List<Reply> selectMyReplyList(Long memberNo, RowBounds rowBounds);
	
	int selectMyProductCount(Long memberNo);

	List<Product> selectMyProductList(Long memberNo, RowBounds rowBounds);
}
