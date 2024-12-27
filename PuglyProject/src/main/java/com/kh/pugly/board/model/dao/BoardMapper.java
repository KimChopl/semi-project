package com.kh.pugly.board.model.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.board.model.vo.Board;

@Mapper
public interface BoardMapper {

	int selectTotalCount();

	List<Board> selectBoardList(RowBounds rowBounds);
	
	int increaseCount(Long boardNo);
	
	Board selectById(Long boardNo);

	void insertBoard(Board board);

	int updateBoard(Board board);

	int deleteBoard(Long boardNo);

}
