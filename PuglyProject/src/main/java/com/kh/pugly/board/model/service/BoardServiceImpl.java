package com.kh.pugly.board.model.service;

import java.io.File;
import java.io.IOException;
import java.security.InvalidParameterException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import com.kh.pugly.board.model.dao.BoardMapper;
import com.kh.pugly.board.model.vo.Board;
import com.kh.pugly.common.model.vo.Image;
import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
import com.kh.pugly.exception.BoardNotFoundException;
import com.kh.pugly.exception.FailToFileUploadException;
import com.kh.pugly.exception.NotFoundImgException;
import com.kh.pugly.exception.ProductValueException;



import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper;
	private final ServletContext context;
	
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
	
	private List<Board> getBoardList(PageInfo pi, String sortType){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return mapper.selectBoardList(rowBounds, sortType);
	}
	
	private void validateBoard(Board board) {
		if(board == null ||
		   board.getBoardTitle() == null || board.getBoardTitle().trim().isEmpty() ||

		   board.getBoardContent() == null || board.getBoardContent().trim().isEmpty()) {

			throw new ProductValueException("부적절한 입력값입니다.");
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
	public Map<String, Object> selectBoardList(int currentPage, String sortType) {
		int totalCount = getTotalCount();
		PageInfo pi = getPageInfo(totalCount, currentPage);
		
		List<Board> boards = getBoardList(pi, sortType);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boards", boards);
		map.put("pageInfo", pi);
		
		return map;
	}
	
	private Image boardSaveImg(MultipartFile upfile) {
		String fileName = upfile.getOriginalFilename();
		String ext = fileName.substring(fileName.lastIndexOf("."));
		String currentTime = new SimpleDateFormat("yyyymmddHHmmss").format(new Date());
		int randomNum = (int)(Math.random() * 90000) + 10000;
		String changeName = "BoardImg" + currentTime + randomNum + ext;
		String savePath = context.getRealPath("/resources/board-img/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch(IOException | IllegalStateException e) {
			throw new FailToFileUploadException("파일오류!");
		}
		
		Image image = new Image();
		image.setOriginImgName(fileName);
		image.setChangeImgName("/resources/board-img/" + changeName);
		image.setImgLevel(1);
		image.setImgPath("/resources/board-img/");
		
		return image;	   
	}
	
	private Image findImageByBoard(Long boardNo) {
		Image img = mapper.findImageByBoard(boardNo);
		return img;
	}

	@Override
	public void insertBoard(Board board, MultipartFile upfile) {
		validateBoard(board);
		
		Image img = null;
		
		mapper.insertBoard(board);
		
		if (upfile != null && !upfile.getOriginalFilename().isEmpty()) {
	        img = boardSaveImg(upfile);
	        mapper.insertBoardImg(img);
	    }
		
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
		Board board = null;
		board = mapper.selectById(boardNo);
		
		if(board == null) {
			board = mapper.selectByIdWithoutImg(boardNo);
			
			if(board == null) {
				throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
			} else {
				return board;
			}
		} else {
			return board;
		}
		
	}

	@Override
	public void updateBoard(Board board, MultipartFile upfile) {
		 
	    validateBoard(board);
	    Board boardResult = findByBoardId(board.getBoardNo());
	    
	    mapper.updateBoard(boardResult);
	    
	    Image image = findImageByBoard(boardResult.getBoardNo());
	    
	    if (image != null) {
	        String realPath = context.getRealPath(image.getChangeImgName());
	        
	        if (realPath != null) {
	            int indexOfPugly = realPath.indexOf("pugly");
	            
	            if (indexOfPugly != -1) {
	                String fixePath = realPath.substring(0, indexOfPugly) + realPath.substring(indexOfPugly + "pugly".length());
	                File file = new File(fixePath);
	                if (file.exists()) {
	                    file.delete();
	                }
	            }
	        }
	        
	        mapper.deleteBoardImg(image);
	    }
	    
	    int result = 0;
	    if (upfile != null && !upfile.getOriginalFilename().isEmpty()) {
	        Image newImage = boardSaveImg(upfile);
	        mapper.boardImgUpdate(newImage);
	        result = mapper.updateBoard(boardResult);	        
	    }
		
		if(result < 1) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
	}

	@Override
	public void deleteBoard(Long boardNo, String changeImgName) {
		
		if (changeImgName != null && !changeImgName.isEmpty()) {
		    try {
		        String realPath = context.getRealPath(changeImgName);
		        File newFile = new File(realPath);
		        
		        if (newFile.exists()) { 
		            boolean deleted = newFile.delete(); 
		            if (!deleted) {
		                throw new RuntimeException("파일 삭제에 실패했습니다.");
		            } else {
		                System.out.println("파일이 성공적으로 삭제되었습니다: " + realPath);
		            }
		        } else {
		            throw new NotFoundImgException("이미지 파일을 찾을 수 없습니다.");
		        }
		    } catch (Exception e) {
		        throw new RuntimeException("이미지 삭제 중 오류가 발생했습니다.", e);
		    }
		}
		
		int result = mapper.deleteBoard(boardNo);
		
		if(result <= 0) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
		
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
	public Map<String, Object> searchBoard(Map<String, Object> map) {
	    
		String keyword = (String) map.get("keyword");
		int page = (int)map.get("page");
		
		validateKeyword(keyword);

	    int totalCount = mapper.countSearchBoard(map);

	    PageInfo pageInfo = getPageInfo(totalCount, page);

	    int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getBoardLimit();
	    RowBounds rowBounds = new RowBounds(offset, pageInfo.getBoardLimit());
	    List<Board> boardList = mapper.searchBoardList(map, rowBounds);

	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("boardList", boardList);
	    resultMap.put("pageInfo", pageInfo);

	    return resultMap;
	}
	
	private void validateKeyword(String keyword) {
	    if (keyword == null || keyword.trim().isEmpty()) {
	        throw new InvalidParameterException("검색어를 입력해주세요.");
	    }
	}

}
