package com.kh.pugly.reply.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.reply.model.vo.InquiryAnswer;

@Mapper
public interface InquiryAnswerMapper {

	int insertAnswer(InquiryAnswer inquiryAnswer);

	List<InquiryAnswer> selectAnswerList(Long inquiryNo);

}
