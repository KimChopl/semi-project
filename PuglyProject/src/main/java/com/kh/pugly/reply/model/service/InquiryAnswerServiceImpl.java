package com.kh.pugly.reply.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.pugly.board.model.dao.InquiryMapper;
import com.kh.pugly.reply.model.dao.InquiryAnswerMapper;
import com.kh.pugly.reply.model.vo.InquiryAnswer;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryAnswerServiceImpl implements InquiryAnswerService {

	private final InquiryAnswerMapper answerMapper;
	private final InquiryMapper inquiryMapper;
	
	@Override
	public int insertAnswer(InquiryAnswer inquiryAnswer) {
		int result = answerMapper.insertAnswer(inquiryAnswer);
		
		if(result > 0) {
			inquiryMapper.updateAnswerState(inquiryAnswer.getRefIno());
		}
		return result;
	}

	@Override
	public List<InquiryAnswer> selectAnswerList(Long inquiryNo) {
		return answerMapper.selectAnswerList(inquiryNo);
	}

}
