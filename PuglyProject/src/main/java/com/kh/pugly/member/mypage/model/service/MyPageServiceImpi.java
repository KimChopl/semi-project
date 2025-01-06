package com.kh.pugly.member.mypage.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
import com.kh.pugly.exception.NotFoundCartListException;
import com.kh.pugly.exception.NotFoundFarmListException;
import com.kh.pugly.farm.model.dao.FarmMapper;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.member.mypage.model.dao.MyPageMapper;
import com.kh.pugly.product.model.vo.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MyPageServiceImpi implements MyPageService {

	private final MyPageMapper mapper;
	private final FarmMapper farmMapper;
	
	private PageInfo getPageInfo(int totalCount, int page, int boardLimit, int pageLimit) {
		return PagiNation.getPageInfo(totalCount, page, boardLimit, pageLimit);
	}
	
	private List<Product> getProductList(PageInfo pi, Long memberNo){
		int offset =(pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return mapper.selectMyCartList(memberNo, rowBounds);
	}
	
	@Override
	public Map<String, Object> selectCart(Long memberNo, int currentPage) {
		int pageCount = mapper.selectMyCartAll(memberNo);
		if(pageCount == 0) {
			throw new NotFoundCartListException("장바구니 목록 없음");
		}
		PageInfo pi = getPageInfo(pageCount, currentPage, 3, 3);
		List<Product> list = getProductList(pi, memberNo);
		//log.info("{}", list);
		Map<String, Object> map = new HashMap();
		
		map.put("pageInfo", pi);
		map.put("cartList", list);
		
		return map;
	}

	@Override
	public Map<String, Object> selectMyFarmList(Long memberNo, int currentPage) {
		int pageCount = mapper.selectMyFarmCount(memberNo);
		if(pageCount == 0) {
			throw new NotFoundFarmListException("내 농장 목록 없음");
		}
		PageInfo pi = getPageInfo(pageCount, currentPage, 3, 3);
		int offset =(pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		//List<Farm> list = mapper.selectMyFarmList(memberNo, rowBounds);
		//log.info("{}", list);
		return null;
	}
	
	

}
