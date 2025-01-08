package com.kh.pugly.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.board.model.vo.Inquiry;

@Mapper
public interface InquiryMapper {

	int deleteInquiry(Long inquiryNo);

	int increaseCount(Long inquiryNo);

	Inquiry selectById(Long inquiryNo);

	void insertInquiry(Inquiry inquiry);
	
	void insertInquiryForAdmin(Inquiry inquiry);

	List<Inquiry> selectInquiryList(RowBounds rowBounds);

	int totalCount();

	int countSearchInquiry(Map<String, Object> map);

	List<Inquiry> searchInquiryList(Map<String, Object> map, RowBounds rowBounds);

	void updateAnswerState(Long refIno);

}
