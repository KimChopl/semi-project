package com.kh.pugly.member.mypage.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.pugly.board.model.dao.BoardMapper;
import com.kh.pugly.board.model.vo.Board;
import com.kh.pugly.book.model.dao.BookMapper;
import com.kh.pugly.book.model.vo.Book;
import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
import com.kh.pugly.exception.BoardNotFoundException;
import com.kh.pugly.exception.NotFoundBookException;
import com.kh.pugly.exception.NotFoundCartListException;
import com.kh.pugly.exception.NotFoundFarmListException;
import com.kh.pugly.exception.NotFoundProductException;
import com.kh.pugly.exception.NotFoundReplyException;
import com.kh.pugly.farm.model.vo.Farm;
import com.kh.pugly.member.model.dao.MemberMapper;
import com.kh.pugly.member.model.vo.Member;
import com.kh.pugly.member.mypage.model.dao.MyPageMapper;
import com.kh.pugly.product.model.vo.Product;
import com.kh.pugly.reply.model.vo.Reply;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MyPageServiceImpi implements MyPageService {

	private final MyPageMapper mapper;
	private final BookMapper bookMapper;
	private final BoardMapper boardMapper;
	private final MemberMapper memberMapper;
	
	private PageInfo getPageInfo(int totalCount, int page, int boardLimit, int pageLimit) {
		return PagiNation.getPageInfo(totalCount, page, boardLimit, pageLimit);
	}
	
	private RowBounds getRowBounds(PageInfo pi) {
		int offset =(pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return rowBounds;
	}
	
	private Map<String, Object> getResponseData(PageInfo pi, List list){
		
		Map<String, Object> map = new HashMap();
		map.put("pageInfo", pi);
		map.put("list", list);
		return map;
	}
	
	@Override
	public Map<String, Object> selectCart(Long memberNo, int currentPage) {
		int pageCount = mapper.selectMyCartAll(memberNo);
		if(pageCount == 0) {
			throw new NotFoundCartListException("장바구니 목록 없음");
		}
		PageInfo pi = getPageInfo(pageCount, currentPage, 3, 3);
		RowBounds rowBounds = getRowBounds(pi);
		List<Product> list = mapper.selectMyCartList(memberNo, rowBounds);
		//log.info("{}", list);
		
		
		return getResponseData(pi, list);
	}

	@Override
	public Map<String, Object> selectMyFarmList(Long memberNo, int currentPage) {
		int pageCount = mapper.selectMyFarmCount(memberNo);
		if(pageCount == 0) {
			throw new NotFoundFarmListException("내 농장 목록 없음");
		}
		PageInfo pi = getPageInfo(pageCount, currentPage, 3, 3);
		RowBounds rowBounds = getRowBounds(pi);
		List<Farm> list = mapper.selectMyFarmList(memberNo, rowBounds);
		//log.info("{}", list);
		return getResponseData(pi, list);
	}

	@Override
	public Map<String, Object> selectMyBookList(Long memberNo, int currentPage) {
		int pageCount = bookMapper.bookListCount(memberNo);
		if(pageCount == 0) {
			throw new NotFoundBookException("내 예약 목록 없음");
		}
		PageInfo pi = getPageInfo(pageCount, currentPage, 2, 3);
		RowBounds rowBounds = getRowBounds(pi);
		List<Book> list = bookMapper.selectBookList(rowBounds, memberNo);
		//log.info("{}", list);
		return getResponseData(pi, list);
	}

	@Override
	public Map<String, Object> selectMyBoardList(Long memberNo, int currentPage) {
		int pageCount = boardMapper.selectMyBoardCount(memberNo);
		//log.info("{}", pageCount);
		if(pageCount == 0) {
			throw new BoardNotFoundException("게시글 목록을 찾을 수 없습니다.");
		}
		PageInfo pi = getPageInfo(pageCount, currentPage, 8, 5);
		RowBounds rowBounds = getRowBounds(pi);
		List<Board> list = boardMapper.selectMyBoardList(memberNo, rowBounds);
		
		return getResponseData(pi, list);
	}

	@Override
	public Map<String, Object> selectMyReplyList(Long memberNo, int currentPage) {
		int pageCount = mapper.selectMyReplyCount(memberNo);
		if(pageCount == 0) {
			throw new NotFoundReplyException("댓글 목록을 찾을 수 없습니다.");
		}
		
		PageInfo pi = getPageInfo(pageCount, currentPage, 8, 5);
		RowBounds rowBounds = getRowBounds(pi);
		List<Reply> list = mapper.selectMyReplyList(memberNo, rowBounds);
		//log.info("{}", list);
		return getResponseData(pi, list);
	}

	@Override
	public Map<String, Object> selectMyProductList(Long memberNo, int currentPage) {
		int pageCount = mapper.selectMyProductCount(memberNo);
		if(pageCount == 0) {
			throw new NotFoundProductException("상품 목록을 찾을 수 없습니다.");
		}
		PageInfo pi = getPageInfo(pageCount, currentPage, 8, 5);
		RowBounds rowBounds = getRowBounds(pi);
		List<Product> list = mapper.selectMyProductList(memberNo, rowBounds);
		
		return getResponseData(pi, list);
	}
	
	

}
