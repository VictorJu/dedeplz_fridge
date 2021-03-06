package org.dedeplz.fridge.controller.board;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dedeplz.fridge.model.board.BoardCommentService;
import org.dedeplz.fridge.model.board.BoardService;
import org.dedeplz.fridge.model.board.BoardVO;
import org.dedeplz.fridge.model.board.FileVO;
import org.dedeplz.fridge.model.board.paging.BoardListVO;
import org.dedeplz.fridge.model.common.FileManager;
import org.dedeplz.fridge.model.common.LoginCheck;
import org.dedeplz.fridge.model.member.MemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class BoardController {
	@Resource(name="boardServiceImpl")
	private BoardService boardService;
	@Resource
	private FileManager fileManager;
	@Resource(name="boardCommentServiceImpl")
	private BoardCommentService boardCommentService;
/**
 * 자유게시판 리스트
 * @param request
 * @param response
 * @param vo
 * @return
 */
	@RequestMapping("BoardList.do")
	public ModelAndView list(HttpServletRequest request,
			HttpServletResponse response,BoardVO vo){
		String pageNo=request.getParameter("pageNo");
		BoardListVO lvo = boardService.getPostingList(pageNo);
		return new ModelAndView("list_board","lvo",lvo);
	}
	
	/**
	 * 자유게시판 등록 폼으로 이동
	 * 
	 * @return
	 */
	@LoginCheck
	@RequestMapping("registerBoardForm.do")
	public String registerBoardForm() {
		return "register_board";
	}
	/**
	 * 자유게시판 등록
	 * @param bvo
	 * @param items
	 * @return
	 */
	@RequestMapping("registerBoard.do")
	public ModelAndView registerBoard(BoardVO bvo, String items) {
		int boardNo = 0;
		String contents = bvo.getContents();
		List<FileVO> fvoList=boardService.getFvoList(contents);
		try {
			boardNo = boardService.registerBoard(bvo,items,fvoList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:registerBoardResult.do?boardNo="+ boardNo);
	}

		
	/**
	 * 자유게시판 등록 후 자유게시판 상세 페이지로 이동
	 * 
	 * @param bvo
	 * @param model
	 * @return
	 */
	@RequestMapping("registerBoardResult.do")
	public ModelAndView registerResult(BoardVO bvo, Model model, int boardNo) {
		bvo = boardService.getBoardInfoNoHits(bvo.getBoardNo());
		return new ModelAndView("showcontent_board","vo",bvo);
	}
	
	
	
	/**
	 * 자유게시판 상세보기
	 * @param fvo
	 * @param cookieValue
	 * @param response
	 * @param boardNo
	 * @return
	 */
	@RequestMapping("showContent.do")
	   public ModelAndView showContents(FileVO fvo,@CookieValue(value="memberCookie",required=false) String cookieValue,HttpServletResponse response,int boardNo) {
		BoardVO bvo=null;
		
		ModelAndView mv=new ModelAndView();
		mv.setViewName("showcontent_board");
	       if(cookieValue==null){//memberCookie cookie 존재하지 않으므로 cookie 생성하고 count 증가 (맨처음)
	            response.addCookie(new Cookie("memberCookie","|"+boardNo+"|"));
	             bvo=boardService.getBoardInfo(boardNo);
	         
	         }else if(cookieValue.indexOf("|"+boardNo+"|")==-1){//memberCookie cookie 존재하지만 {}번글은 처음 조회하므로 count증가
	            cookieValue+="|"+boardNo+"|";
	            //글번호를 쿠키에 추가 
	            response.addCookie(new Cookie("memberCookie",cookieValue));
	             bvo=boardService.getBoardInfo(boardNo);
	         }else{//memberCookie cookie 존재하고 이전에 해당 게시물 읽었으므로 count 증가x
	             bvo=boardService.getBoardInfoNoHits(boardNo);
	         }
	       mv.addObject("vo",bvo);
	       mv.addObject("bcvo", boardCommentService.getBoardCommentList(boardNo));
	       return mv;
	      
	}
	/**
	 * 자유게시판 삭제
	 * 
	 * @param bvo
	 * @param session
	 * @return
	 */
	@LoginCheck
	@RequestMapping("deleteBoard.do")
	public ModelAndView deleteForm(BoardVO bvo, HttpSession session) {
		MemberVO mvo = (MemberVO) session.getAttribute("mvo");
		String id = mvo.getId();
		List<String> list = boardService.getFileName(bvo.getBoardNo());
		fileManager.deleteImg(list,id);
		boardService.deleteBoardAll(bvo.getBoardNo());
		return new ModelAndView("redirect:BoardList.do");
	}
	/**
	    * 자유게시판 수정
	    */
	 	@LoginCheck
	   @RequestMapping("updateBoardForm.do")
	   public String updateBoardForm(BoardVO bvo, Model model) {
	      bvo = boardService.getBoardInfo(bvo.getBoardNo());
	      List<String> fileNameList = boardService.getFileName(bvo.getBoardNo());
	      model.addAttribute("bvo", bvo);
	      model.addAttribute("fileNameList", fileNameList);
	      return "update_board";
	   }

	   /**
	    * 자유게시판 수정완료!
	    */
	   @RequestMapping("updateBoard.do")
	   public ModelAndView updateBoard(HttpServletRequest request,
	         HttpServletResponse response, BoardVO bvo, String items) {
	      boardService.deleteBoardFile(bvo.getBoardNo());
	      boardService.updateBoard(bvo);
	      List<FileVO> fvoList=boardService.getFvoList(bvo.getContents());
	      boardService.insertBoardFile(bvo, fvoList);
	      return new ModelAndView("redirect:registerBoardResult.do?boardNo="
	            + bvo.getBoardNo());
	   }
	/**
	 * 
	 * 카테고리로 검색한 자유게시글 목록
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	   @RequestMapping("searchByCategory.do")
	   public ModelAndView searchByCategory(HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) {
	      String category = request.getParameter("category");	      
	      if(session.getAttribute("categoryInfo")==null){
	         session.setAttribute("categoryInfo", category);	      
	      }else{
	    	  if(category != null){
	    		  session.setAttribute("categoryInfo", category);
	    		  category = (String) session.getAttribute("categoryInfo");	    		  
	    	  }else{
	    		  category = (String) session.getAttribute("categoryInfo");	  
	    	  }
	      }
	      String pageNo = request.getParameter("pageNo");
	      BoardListVO lvo = boardService.getSearchByCategoryList(pageNo,category);
	      return new ModelAndView("searchByCategory_board", "lvo", lvo);
	   }

	   /**
		 * 제목으로 검색한 자유게시글 목록
		 */
	   @RequestMapping("searchByTitle.do")
	   public ModelAndView searchByTitle(HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) {
	      String title = request.getParameter("title");
	      if(session.getAttribute("titleInfo")==null){
	         session.setAttribute("titleInfo", title);
	      }else{
	    	  if(title != null){
	    		  session.setAttribute("titleInfo", title);
	    		  title = (String) session.getAttribute("titleInfo");	    		  
	    	  }else{
	    		  title = (String) session.getAttribute("titleInfo");	  
	    	  }
	      }
	      String pageNo = request.getParameter("pageNo");
	      BoardListVO lvo = boardService.getSearchByTitleList(pageNo,title);
	      return new ModelAndView("searchByTitle_board", "lvo", lvo);
	   }
	   
	   /**
		 * 작성자(닉네임)로 검색한 자유게시글 목록
		 */
	      @RequestMapping("searchByWriter.do")
	         public ModelAndView searchByWriter(HttpServletRequest request,
	               HttpServletResponse response, HttpSession session) {
	            String nick = request.getParameter("nick");
	            if(session.getAttribute("nickInfo")==null){
	               session.setAttribute("nickInfo", nick);
	            }else{
	               if(nick != null){
	                  session.setAttribute("nickInfo", nick);
	                  nick = (String) session.getAttribute("nickInfo");               
	               }else{
	                  nick = (String) session.getAttribute("nickInfo");     
	               }
	            }
	            String pageNo = request.getParameter("pageNo");
	            BoardListVO lvo = boardService.getSearchByWriterList(pageNo,nick);
	            return new ModelAndView("searchByNick_board", "lvo", lvo);
	         }
	   
	   
	    /**
		 * 내용으로 검색한 자유게시글 목록
		 */
	   @RequestMapping("searchByContents.do")
	   public ModelAndView searchByContents(HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) {
	      String contents = request.getParameter("contents");
	      if(session.getAttribute("contentsInfo")==null||session.getAttribute("contentsInfo")!=contents){
	         session.setAttribute("contentsInfo", contents);
	      }else{
	         contents = (String) session.getAttribute("contentsInfo");
	      }
	      String pageNo = request.getParameter("pageNo");
	      BoardListVO lvo = boardService.getSearchByContentsList(pageNo, contents);
	      return new ModelAndView("searchByContents_board", "lvo", lvo);
	   } 

}
