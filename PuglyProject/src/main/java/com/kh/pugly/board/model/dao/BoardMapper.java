package com.kh.pugly.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.board.model.vo.Board;
import com.kh.pugly.common.model.vo.Image;

@Mapper
public interface BoardMapper {

	int selectTotalCount();

	List<Board> selectBoardList(RowBounds rowBounds, String sortType);
	
	int increaseCount(Long boardNo);
	
	Board selectById(Long boardNo);

	void insertBoard(Board board);

	void insertBoardImg(Image img);

	int updateBoard(Board board);

	void boardImgUpdate(Image img);

	int deleteBoard(Long boardNo);

	int countSearchBoard(Map<String, Object> map);

	List<Board> searchBoardList(Map<String, Object> map, RowBounds rowBounds);

	Image findImageByBoard(Long boardNo);

	// 마이페이지 내 게시글 페이징처리
	int selectMyBoardCount(Long memberNo);
	// 마이페이지 내 게시글 리스트
	List<Board> selectMyBoardList(Long memberNo, RowBounds rowBounds);

	Board selectByIdWithoutImg(Long boardNo);

	void deleteBoardImg(Image image);
}
