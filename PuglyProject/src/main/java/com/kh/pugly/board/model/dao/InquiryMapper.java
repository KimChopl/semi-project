package com.kh.pugly.board.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.pugly.board.model.vo.Inquiry;

@Mapper
public interface InquiryMapper {

	int deleteInquiry(Long inquiryNo);

	int increaseCount(Long inquiryNo);

	Inquiry selectById(Long inquiryNo);

	void insertInquiry(Inquiry inquiry);

	List<Inquiry> selectInquiryList(RowBounds rowBounds);

	int totalCount();

}
