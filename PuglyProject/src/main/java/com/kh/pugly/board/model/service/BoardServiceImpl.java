package com.kh.pugly.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import com.kh.pugly.board.model.dao.BoardMapper;
import com.kh.pugly.board.model.vo.Board;
import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper;
	private final ServletContext context;
	
	private int getTotalCount() {
		int totalCount = mapper.selectTotalCount();
		if(totalCount == 0) {
			//예외처리
		}
		return totalCount;
	}
	
	private PageInfo getPageInfo(int totalCount, int page) {
		return PagiNation.getPageInfo(totalCount, page, 5, 10);
	}
	
	private List<Board> getBoardList(PageInfo pi){
		int offset = (pi.getCurrentPage() - 1) * pi.getBaordLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBaordLimit());
		return mapper.selectBoardList(rowBounds);
	}

	@Override
	public void insertBoard(Board board, MultipartFile upfile) {
		// 예외처리
		
		mapper.insertBoard(board);
		
	}

	@Override
	public void updateBoard(Board board, MultipartFile upfile) {
		
		int result = mapper.updateBoard(board);
		
		if(result < 1) {
			// 예외처리
		}
	}

	@Override
	public void deleteBoard(Long boardNo, String changeName) {
		
		int result = mapper.deleteBoard(boardNo);
		
		if(result <= 0) {
			//예외처리
		}
		
		// 파일 삭제
		
	}
	
	private void incrementViewCount(Long boardNo) {
		int result = mapper.increaseCount(boardNo);
		if(result < 1) {
			//예외처리
		}
	}
	
	private Board findByBoard(Long boardNo) {
		Board board = mapper.selectById(boardNo);
		if(board == null) {
			//예외처리
		}
		return board;
	}

	@Override
	public Map<String, Object> selectBoardList(int currentPage) {
		int totalCount = getTotalCount();
		PageInfo pi = getPageInfo(totalCount, currentPage);
		
		List<Board> boards = getBoardList(pi);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boards", boards);
		map.put("pageInfo", pi);
		
		return map;
	}

	@Override
	public Map<String, Object> selectById(Long boardNo) {
		return null;
	}

	@Override
	public Map<String, Object> selectByKeyword(String keyword) {
		return null;
	}

}
