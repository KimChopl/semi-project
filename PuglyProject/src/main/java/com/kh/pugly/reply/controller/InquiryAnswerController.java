package com.kh.pugly.reply.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pugly.common.model.vo.ResponseData;
import com.kh.pugly.reply.model.service.InquiryAnswerService;
import com.kh.pugly.reply.model.vo.InquiryAnswer;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("inquiryAnswer")
public class InquiryAnswerController {
	
	private final InquiryAnswerService answerService;
	
	@PostMapping
	public ResponseEntity<ResponseData> insertAnswer(InquiryAnswer answer) {
		
		int result = answerService.insertAnswer(answer);
		ResponseData response = ResponseData.builder()
					 						.message("댓글 등록에 성공했습니다!")
					 						.status(HttpStatus.OK.toString())
					 						.data(result)
					 						.build();
		
		return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}
	
	@GetMapping
	public ResponseEntity<ResponseData> SelectAnswerList(Long inquiryNo){
		
		List<InquiryAnswer> replies = answerService.selectAnswerList(inquiryNo);
		ResponseData response = ResponseData.builder()
											.message("댓글 조회에 성고했습니다.")
											.status(HttpStatus.OK.toString())
											.data(replies)
											.build();
		return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}

}