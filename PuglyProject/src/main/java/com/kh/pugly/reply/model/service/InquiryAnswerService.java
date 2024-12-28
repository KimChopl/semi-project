package com.kh.pugly.reply.model.service;

import java.util.List;

import com.kh.pugly.reply.model.vo.InquiryAnswer;

public interface InquiryAnswerService {
	
	int insertAnswer(InquiryAnswer answer);
	
	List<InquiryAnswer> selectAnswerList(Long inquiryNo);

}
