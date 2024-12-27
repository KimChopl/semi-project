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
