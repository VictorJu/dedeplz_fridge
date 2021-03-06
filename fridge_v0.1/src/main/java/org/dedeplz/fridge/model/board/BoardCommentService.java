package org.dedeplz.fridge.model.board;

import java.util.List;

public interface BoardCommentService {

	public void registBoardComment(BoardCommentVO bcvo);

	public List<BoardCommentVO> getBoardCommentList(int boardNo);

	public void deleteBoardComment(int commentNo);

	public void updateBoardComment(BoardCommentVO bcvo);

	public void deleteBoardCommentByBoardNo(int boardNo);
	
	public List<Integer> getMyBoardCommentNoByNick(String nick);

}
