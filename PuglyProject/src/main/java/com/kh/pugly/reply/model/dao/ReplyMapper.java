package com.kh.pugly.reply.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.reply.model.vo.Reply;

@Mapper
public interface ReplyMapper {

	int insertReply(Reply reply);

	List<Reply> selectReplyList(Long boardNo);

}
