package org.dedeplz.fridge.model.member;

import java.util.List;

import javax.annotation.Resource;

import org.dedeplz.fridge.model.board.BoardCommentService;
import org.dedeplz.fridge.model.board.BoardService;
import org.dedeplz.fridge.model.recipe.RecipeDAO;
import org.dedeplz.fridge.model.recipe.RecipeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {
	@Resource
	private MemberDAO memberDAO;
	@Resource
	private RecipeDAO recipeDAO;
	@Resource
	private RecipeService recipeService;
	@Resource
	private BoardService boardService;
	@Resource
	private BoardCommentService boardCommentService;
    /* (non-Javadoc)
    * @see org.dedeplz.fridge.model.MemberService#allMember()
   */
       /**
       * 아이디 찾기
       */
   public MemberVO findById(String id) {
      // TODO Auto-generated method stub
      return memberDAO.findById(id);
   }
   /**
    * 회원등록
    */
   @Override
   public void registerMember(MemberVO vo) {
      memberDAO.registerMember(vo);      
   }
   /**
    * 아이디 중복체크
    */
   @Override
   public String idCheck(String id) {
      return memberDAO.idCheck(id);
   }
   /**
    * 로그인
    */
    @Override
      public MemberVO login(MemberVO vo) {
         return memberDAO.login(vo);
      }
   /**
    * 회원 정보 수정
    */
   @Override
   public void updateMember(MemberVO vo) {
      System.out.println("updateServiceImpl");
      memberDAO.updateMember(vo);
   }
   /**
    * 회원 탈퇴
    */
      @Override
      public void deleteMember(MemberVO vo) {
         memberDAO.deleteMember(vo);
      }
   /**
    * 닉네임 중복체크
   */
   @Override
   public String nickCheck(String nick) {
      return memberDAO.nickCheck(nick);
   }
   /**
    * 내 아이디 찾기
    */
      @Override
      public String findMyId(MemberVO vo) {
         return memberDAO.findMyId(vo);
      }
    /**
     * 내 비밀번호 찾기
     */
   @Override
   public String findMyPassword(MemberVO vo) {
      return memberDAO.findMyPassword(vo);
   }
   /**
    * 회원 리스트
    */
   @Override
   public MemberListVO getMemberList(String pageNo) {
      if(pageNo==null||pageNo=="") 
         pageNo="1";
      List<MemberVO> list=memberDAO.getMemberList(pageNo);
      int total=memberDAO.totalMember();
      MemberPagingBean paging=new MemberPagingBean(total,Integer.parseInt(pageNo));
      MemberListVO lvo=new MemberListVO(list,paging);
      return lvo;
   }
   /**
    * 레벨 변경
    */
   @Override
   public void levelChange(MemberVO vo) {
      memberDAO.levelChange(vo);
   }
   /** 좋아요 수에따른
    * 자동 렙업
    */
   @Override
   public void updateMemberGrade(MemberVO vo){
      memberDAO.updateMemberGrade(vo);
   }
   /**
    * 로그인 아이디 이용
    * 아이디의 모든 레시피의 good과 bad를 이용
    * 모든 good과 모든 bad의 합을 totalLove로
    * 리턴 totalLove
    * 
    */
   @Override
   public int getTotalLove(String id) {
      List<String> list = recipeDAO.getMyRecipeList(id);
      int memberTotalGood = 0;
      int memberTotalBad = 0;
      System.out.println(list);
      for (int i = 0; i < list.size(); i++) {
         memberTotalGood += recipeDAO.getTotalGood(Integer.parseInt(list.get(i)));
         memberTotalBad += recipeDAO.getTotalBad(Integer.parseInt(list.get(i)));
      }
      int totalLove = memberTotalGood - memberTotalBad;
      return totalLove;
      
   }
   /**
    * MemberVO의 id를 이용해
    * love값을 업데이트
    */
   @Override
   public void updateMemberLove(MemberVO mvo) {
      memberDAO.updateMemberLove(mvo);

   }
   
   /**
	 * 회원탈퇴 회원이 등록한 정보를 삭제
	 */
	@Override
	@Transactional
	public void deleteAllMemberInfo(MemberVO mvo) {	
		List<String> recipeNoList = recipeService.getMyRecipeList(mvo.getId());
		List<Integer> commentNoList = recipeService.getMyCommentNoListByNick(mvo.getNick());
		for (int y = 0; y < commentNoList.size(); y++) {
			recipeService.deleteAllRecipeCommentByCommnetNo(commentNoList.get(y));
		}
		for (int i = 0; i < recipeNoList.size(); i++) {
			recipeService.deleteRecipeAll(mvo.getId(), Integer.parseInt(recipeNoList.get(i)));
		}
		List<Integer> boardCommentList = boardCommentService.getMyBoardCommentList(mvo.getNick());
		for (int i = 0; i < boardCommentList.size(); i++) {
			boardCommentService.deleteBoardComment(boardCommentList.get(i));
		}
		List<Integer> boardList = boardService.getMyBoardList(mvo.getId());
		for (int i = 0; i < boardList.size(); i++) {
			boardService.deleteBoardAll(boardList.get(i));
		}
		memberDAO.deleteMember(mvo);
	}
}