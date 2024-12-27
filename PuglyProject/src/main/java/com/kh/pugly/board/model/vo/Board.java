package com.kh.pugly.board.model.vo;

<<<<<<< HEAD
<<<<<<< Updated upstream

=======
>>>>>>> parent of a7ffb37 (모든 파일 커밋)
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
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {
	private Long boardNo;
<<<<<<< Updated upstream
	private int boardWriter;
=======
>>>>>>> Stashed changes
	private String nickName;
	private String boardTitle;
	private String boardContent;
	private int mainCategory;
	private int count;
	private String createDate;
	private String status;
}
