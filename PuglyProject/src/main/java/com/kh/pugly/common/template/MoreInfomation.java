package com.kh.pugly.common.template;

import com.kh.pugly.common.model.vo.MoreInfo;

public class MoreInfomation {
	public static MoreInfo getMoreInfo(int listCount, int plusNo, int limit) {
			int startNo = plusNo;
			int lastNo = startNo + limit;
			if(lastNo > listCount) {
				lastNo = listCount;
			}
			return MoreInfo.builder().listCount(listCount).plusNo(plusNo).startNo(startNo).lastNo(lastNo).boardLimit(limit).build();
	}
}
