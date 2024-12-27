package com.kh.pugly.board.model.vo;

<<<<<<< Updated upstream

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

=======
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

>>>>>>> Stashed changes
@Getter
@Setter
@NoArgsConstructor
@ToString
@AllArgsConstructor
@Builder
public class Inquiry {
	private int inquiryNo;
	private String nickName;
	private String inquiryTitle;
	private String inquiryContent;
	private String createDate;
	private String answerStatus;
	private String status;
}
