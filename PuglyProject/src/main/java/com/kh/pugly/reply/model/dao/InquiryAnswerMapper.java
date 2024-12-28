package com.kh.pugly.reply.model.dao;

import java.util.List;

import com.kh.pugly.reply.model.vo.InquiryAnswer;

public interface InquiryAnswerMapper {

	int insertAnswer(InquiryAnswer answer);

	List<InquiryAnswer> selectAnswerList(Long inquiryNo);

}
