package com.kh.pugly.common.template;

import com.kh.pugly.common.model.vo.MoreInfo;

public class MoreInfomation {
	public static MoreInfo getMoreInfo(int listCount, int plusNo) {
			int boardLimit = 6;
			int startNo = plusNo + 1;
			int lastNo = startNo + boardLimit - 1;
			if(lastNo > listCount) {
				lastNo = listCount;
			}
			return MoreInfo.builder().listCount(listCount).plusNo(plusNo).startNo(startNo).lastNo(lastNo).boardLimit(boardLimit).build();
	}
}
