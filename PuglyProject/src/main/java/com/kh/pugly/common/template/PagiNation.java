package com.kh.pugly.common.template;

import com.kh.pugly.common.model.vo.PageInfo;

public class PagiNation {
	
	public static PageInfo getPageInfo(int listCount, int currentPage, int boardLimit, int pageLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		if(endPage > maxPage) {
			endPage  = maxPage;
		}
		return PageInfo.builder().listCount(listCount).currentPage(currentPage).baordLimit(boardLimit).pageLimit(pageLimit).maxPage(maxPage).startPage(startPage).endPage(endPage).build();
	}

}