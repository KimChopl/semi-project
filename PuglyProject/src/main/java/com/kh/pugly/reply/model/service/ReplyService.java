package com.kh.pugly.reply.model.service;

import java.util.List;

import com.kh.pugly.reply.model.vo.Reply;

public interface ReplyService {
	
	int insertReply(Reply reply);
	
	List<Reply> selectReplyList(Long boardNo);

}
