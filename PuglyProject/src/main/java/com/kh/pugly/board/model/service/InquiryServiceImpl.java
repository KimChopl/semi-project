package com.kh.pugly.board.model.service;

import java.security.InvalidParameterException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;

import com.kh.pugly.board.model.dao.InquiryMapper;
import com.kh.pugly.board.model.vo.Inquiry;
import com.kh.pugly.common.model.vo.PageInfo;
import com.kh.pugly.common.template.PagiNation;
import com.kh.pugly.exception.BoardNotFoundException;
import com.kh.pugly.exception.ComparedPasswordException;
import com.kh.pugly.exception.ProductValueException;
import com.kh.pugly.exception.TooLargeValueException;
import com.kh.pugly.member.model.service.PasswordEncoder;
import com.kh.pugly.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class InquiryServiceImpl implements InquiryService {
	
	private final InquiryMapper inquiryMapper;
	private final PasswordEncoder passwordEncrypt; 
	
	
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
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return inquiryMapper.selectInquiryList(rowBounds);
	}
	
	private void validatInquiry(Inquiry inquiry) {
		if(inquiry == null ||
		   inquiry.getInquiryTitle() == null || inquiry.getInquiryTitle().trim().isEmpty() ||
		   inquiry.getInquiryContent() == null || inquiry.getInquiryContent().trim().isEmpty() ||
		   inquiry.getNickname() == null || inquiry.getNickname().trim().isEmpty()) {
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
	
	private void encryptionPassword(Inquiry inquiry) {
		String securityPass = passwordEncrypt.encode(inquiry.getInquiryPassword());
		inquiry.setInquiryPassword(securityPass);
	}
	
	private void validationPassword(Inquiry inquiry) {
		if(inquiry.getInquiryPassword().length() > 25) {
			throw new TooLargeValueException("비밀번호가 너무 깁니다.");
		}
	}
	
	@Override
	public void insertInquiry(Inquiry inquiry) {
		validatInquiry(inquiry);
		encryptionPassword(inquiry);
		validationPassword(inquiry);
		
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
	public Map<String, Object> searchInquiry(Map<String, Object> map) {
		
		String keyword = (String) map.get("keyword");
		int page = (int)map.get("page");
		
		validateKeyword(keyword);

	    int totalCount = inquiryMapper.countSearchInquiry(map);

	    PageInfo pageInfo = getPageInfo(totalCount, page);

	    int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getBoardLimit();
	    RowBounds rowBounds = new RowBounds(offset, pageInfo.getBoardLimit());
	    List<Inquiry> inquiryList = inquiryMapper.searchInquiryList(map, rowBounds);

	    // 결과를 Map으로 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("inquiryList", inquiryList);
	    resultMap.put("pageInfo", pageInfo);

	    return resultMap;
	}
	
	private void validateKeyword(String keyword) {
	    if (keyword == null || keyword.trim().isEmpty()) {
	        throw new InvalidParameterException("검색어를 입력해주세요.");
	    }
	}

}
