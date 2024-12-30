package com.kh.pugly.board.model.service;

import java.security.InvalidParameterException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;

import com.kh.pugly.board.model.dao.InquiryMapper;
import com.kh.pugly.board.model.vo.Inquiry;
import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
import com.kh.pugly.exception.BoardNotFoundException;
import com.kh.pugly.exception.ProductValueException;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class InquiryServiceImpl implements InquiryService {
	
	private final InquiryMapper inquiryMapper;
	
	private int getTotalCount() {
		int totalCount = inquiryMapper.totalCount();
		if(totalCount == 0) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
		return totalCount;
	}
	
	private PageInfo getPageInfo(int totalCount, int page) {
		return PagiNation.getPageInfo(totalCount, page, 5, 10);
	}
	
	private List<Inquiry> getInquiryList(PageInfo pi){
		int offset = (pi.getCurrentPage() - 1) * pi.getBaordLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBaordLimit());
		return inquiryMapper.selectInquiryList(rowBounds);
	}
	
	private void validatInquiry(Inquiry inquiry) {
		if(inquiry == null ||
		   inquiry.getInquiryTitle() == null || inquiry.getInquiryTitle().trim().isEmpty() ||
		   inquiry.getInquiryContent() == null || inquiry.getInquiryContent().trim().isEmpty() ||
		   inquiry.getNickName() == null || inquiry.getNickName().trim().isEmpty()) {
			throw new ProductValueException("부적절한 입력값입니다.");
		}
		
		String inquiryTitle = escapeHtml(inquiry.getInquiryTitle());
		String inquiryContent = escapeHtml(inquiry.getInquiryContent());
		inquiry.setInquiryTitle(convertNewlineToBr(inquiryTitle));
		inquiry.setInquiryContent(convertNewlineToBr(inquiryContent));	
	}
	
	private String escapeHtml(String value) {
		return value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
	private String convertNewlineToBr(String value) {
		return value.replaceAll("\n","<br>");
	}
	
	@Override
	public void insertInquiry(Inquiry inquiry) {
		validatInquiry(inquiry);
		
		inquiryMapper.insertInquiry(inquiry);
		
	}
	
	private void validateInquiryNo(Long inquiryNo) {
		if(inquiryNo == null || inquiryNo <= 0) {
			throw new InvalidParameterException("유효하지 않는 게시글 번호입니다.");
		}
	}
	
	private void incrementViewCount(Long inquiryNo) {
		int result = inquiryMapper.increaseCount(inquiryNo);
		if(result < 1) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
	}
	
	private Inquiry findByInquiryId(Long inquiryNo) {
		Inquiry inquiry = inquiryMapper.selectById(inquiryNo);
		if(inquiry == null) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
		return inquiry;
	}

	@Override
	public void deleteInquiry(Long inquiryNo) {
		int result = inquiryMapper.deleteInquiry(inquiryNo);
		
		if(result <= 0) {
			throw new BoardNotFoundException("게시글이 존재하지 않습니다.");
		}
	}

	@Override
	public List<Inquiry> selectInquiryList(int currentPage) {
		int totalCount = getTotalCount();
		PageInfo pi = getPageInfo(totalCount, currentPage);
		
		List<Inquiry> inquiries = getInquiryList(pi);		
		return inquiries;
	}

	@Override
	public Inquiry selectById(Long inquiryNo) {
		validateInquiryNo(inquiryNo);
		
		incrementViewCount(inquiryNo);
		
		Inquiry inquiry = findByInquiryId(inquiryNo);
		
		return inquiry;
	}

	@Override
	public List<Inquiry> selectByKeyword(String keyword) {
		return null;
	}

}
