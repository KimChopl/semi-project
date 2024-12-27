package com.kh.pugly.board.model.service;

import java.security.InvalidParameterException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import com.kh.pugly.board.model.dao.BoardMapper;
import com.kh.pugly.board.model.vo.Board;
import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
import com.kh.pugly.exception.BoardNotFoundException;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper;
	
	private int getTotalCount() {
		int totalCount = mapper.selectTotalCount();
		if(totalCount == 0) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
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
	
	private void validateBoard(Board board) {
		if(board == null ||
		   board.getBoardTitle() == null || board.getBoardTitle().trim().isEmpty() ||
		   board.getBoardContent() == null || board.getBoardContent().trim().isEmpty() ||
		   board.getNickName() == null || board.getNickName().trim().isEmpty()) {
			throw new BoardNotFoundException("부적절한 입력값입니다.");
		}
		
		String boardTitle = escapeHtml(board.getBoardTitle());
		String boardContent = escapeHtml(board.getBoardContent());
		board.setBoardTitle(convertNewlineToBr(boardTitle));
		board.setBoardContent(convertNewlineToBr(boardContent));	
	}
	
	private String escapeHtml(String value) {
		return value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
	private String convertNewlineToBr(String value) {
		return value.replaceAll("\n","<br>");
				
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
	public void insertBoard(Board board, MultipartFile upfile) {
		validateBoard(board);
		
		if(!("".equals(upfile.getOriginalFilename()))) {
			//예외처리
		}
		
		mapper.insertBoard(board);
		
	}
	
	private void validateBoardNo(Long boardNo) {
		if(boardNo == null || boardNo <= 0) {
			throw new InvalidParameterException("유효하지 않는 게시글 번호입니다.");
		}
	}
	
	private void incrementViewCount(Long boardNo) {
		int result = mapper.increaseCount(boardNo);
		if(result < 1) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
	}
	
	private Board findByBoardId(Long boardNo) {
		Board board = mapper.selectById(boardNo);
		if(board == null) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
		return board;
	}

	@Override
	public void updateBoard(Board board, MultipartFile upfile) {
		validateBoardNo(board.getBoardNo());
		findByBoardId(board.getBoardNo());
		
		int result = mapper.updateBoard(board);
		
		if(result < 1) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
	}

	@Override
	public void deleteBoard(Long boardNo, String changeName) {
		
		int result = mapper.deleteBoard(boardNo);
		
		if(result <= 0) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
		
		// 파일 삭제
		
	}

	@Override
	public Map<String, Object> selectById(Long boardNo) {
		validateBoardNo(boardNo);
		
		incrementViewCount(boardNo);
		
		Board board = findByBoardId(boardNo);
		
		Map<String, Object> responseData = new HashMap<String, Object>();
		responseData.put("board", board);
		
		return responseData;
	}

	@Override
	public Map<String, Object> selectByKeyword(String keyword) {
		return null;
	}

}
