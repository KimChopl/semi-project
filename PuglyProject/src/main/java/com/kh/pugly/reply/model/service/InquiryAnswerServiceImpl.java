package com.kh.pugly.reply.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.pugly.reply.model.dao.InquiryAnswerMapper;
import com.kh.pugly.reply.model.vo.InquiryAnswer;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryAnswerServiceImpl implements InquiryAnswerService {

	private final InquiryAnswerMapper answerMapper;
	
	@Override
	public int insertAnswer(InquiryAnswer answer) {
		return answerMapper.insertAnswer(answer);
	}

	@Override
	public List<InquiryAnswer> selectAnswerList(Long inquiryNo) {
		return answerMapper.selectAnswerList(inquiryNo);
	}

}
