package com.kh.pugly.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
@AllArgsConstructor
public class Member {
	
	private Long memberNo;
	private int categoryNo;
	private String categoryName;
	private String memberId;
	private String memberPwd;
	private String nickName;
	private String memberName;
	private String phone;
	private String status;
	private String createDate;
	private String modifyDate;
	
}
