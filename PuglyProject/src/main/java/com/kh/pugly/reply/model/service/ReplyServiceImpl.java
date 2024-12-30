package com.kh.pugly.reply.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.pugly.reply.model.dao.ReplyMapper;
import com.kh.pugly.reply.model.vo.Reply;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	private final ReplyMapper replyMapper;

	@Override
	public int insertReply(Reply reply) {
		return replyMapper.insertReply(reply);
	}

	@Override
	public List<Reply> selectReplyList(Long boardNo) {
		return replyMapper.selectReplyList(boardNo);
	}

}
