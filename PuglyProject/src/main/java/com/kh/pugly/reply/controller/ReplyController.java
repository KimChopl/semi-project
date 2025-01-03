package com.kh.pugly.reply.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pugly.common.model.vo.ResponseData;
import com.kh.pugly.reply.model.service.ReplyService;
import com.kh.pugly.reply.model.vo.Reply;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("reply")
public class ReplyController {
	
	private final ReplyService replyService;
	
	@PostMapping
	public ResponseEntity<ResponseData> insertReply(Reply reply) {
		
		int result = replyService.insertReply(reply);
		ResponseData response = ResponseData.builder()
					 						.message("댓글 등록에 성공했습니다!")
					 						.status(HttpStatus.OK.toString())
					 						.data(result)
					 						.build();
		
		return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}
	
	@GetMapping
	public ResponseEntity<ResponseData> SelectReplyList(Long boardNo){
		
		List<Reply> replies = replyService.selectReplyList(boardNo);
		ResponseData response = ResponseData.builder()
											.message("댓글 조회에 성고했습니다.")
											.status(HttpStatus.OK.toString())
											.data(replies)
											.build();
		return new ResponseEntity<ResponseData>(response, HttpStatus.OK);
	}

}
