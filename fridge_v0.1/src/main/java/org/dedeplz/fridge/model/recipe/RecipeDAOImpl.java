package org.dedeplz.fridge.model.recipe;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RecipeDAOImpl implements RecipeDAO {
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	/**
	 * 등록된 레시피 총 수
	 */
	@Override
	public int totalContent() {
		return sqlSessionTemplate.selectOne("recipe.totalContent");
	}

	/**
	 * 레시피 아이템 등록
	 */
	@Override
	public void insertRecipeItem(RecipeItemVO rivo) {
		sqlSessionTemplate.insert("recipe.insertRecipeItem", rivo);
	}

	/**
	 * 재료 등록
	 */
	@Override
	public void insertItem(String itemName) {
		sqlSessionTemplate.insert("recipe.insertItem", itemName);
	}

	/**
	 * 재료 등록 유무 체크
	 */
	@Override
	public int getCountItemNo(String itemName) {
		return sqlSessionTemplate.selectOne("recipe.getCountItemNo", itemName);
	}

	/**
	 * 재료 이름으로 재료 번호 찾기
	 */
	@Override
	public int getItemNo(String itemName) {
		return sqlSessionTemplate.selectOne("recipe.getItemNo", itemName);
	}

	/**
	 * 레시피 정보
	 */
	@Override
	public RecipeVO getRecipeInfo(int recipeNo) {
		return sqlSessionTemplate.selectOne("recipe.getRecipeInfo", recipeNo);
	}

	/**
	 * 레시피 정보 등록
	 */
	@Override
	public void registerRecipe(RecipeVO rvo) {
		sqlSessionTemplate.insert("recipe.registerRecipe", rvo);
	}

	/**
	 * recipe_file 테이블에 정보 등록
	 */
	@Override
	public void insertRecipeFile(FileVO fvo) {
		sqlSessionTemplate.insert("recipeFile.insertRecipeFile", fvo);

	}

	/**
	 * 해당 레시피의 아이템 no List
	 */
	@Override
	public List<String> getItemNoList(int recipeNo) {
		return sqlSessionTemplate.selectList("recipe.getItemNoList", recipeNo);
	}

	/**
	 * 아이템 번호로 아이템 이름 찾기
	 */
	@Override
	public String getItemNameByItemNo(int itemNo) {
		return sqlSessionTemplate.selectOne("recipe.getItemNameByItemNo",
				itemNo);
	}
	/**
	 * 레시피 삭제
	 */
	@Override
	public void deleteRecipe(int recipeNo) {
		sqlSessionTemplate.delete("recipe.deleteRecipe", recipeNo);
	}

	/**
	 * 레시피 아이템 삭제
	 */
	@Override
	public void deleteRecipeItem(int recipeNo) {
		sqlSessionTemplate.delete("recipe.deleteRecipeItem", recipeNo);
	}

	/**
	 * 파일 삭제
	 */
	@Override
	public void deleteRecipeFile(int recipeNo) {
		sqlSessionTemplate.delete("recipeFile.deleteRecipeFile", recipeNo);
	}

	/**
	 * 모든 recipe_no
	 */
	@Override
	public List<String> getAllRecipeNo() {
		return sqlSessionTemplate.selectList("recipe.getAllRecipeNo");
	}

	/**
	 * 메인에 들어갈 레시피의 마지막 사진 주소
	 */
	@Override
	public String getFileLastNamePath(String recipeNo) {
		return sqlSessionTemplate.selectOne("recipeFile.getFileLastNamePath",
				recipeNo);
	}

	/**
	 * 메인의 사진 주소로 그 레시피의 번호 받아오기
	 */
	@Override
	public int getRecipeNoByPath(String filePath) {
		return sqlSessionTemplate.selectOne("recipeFile.getRecipeNoByPath",
				filePath);
	}

	/**
	 * 레시피 번호에 해당하는 모든 사진의 path를 받아온다
	 */
	@Override
	public List<String> getAllFilePahtByRecipeNo(int recipeNo) {
		return sqlSessionTemplate.selectList(
				"recipeFile.getAllFilePahtByRecipeNo", recipeNo);
	}

	/**
	 * 레시피 번호에 해당하는 모든 사진의 파일네임을 받아온다.
	 */
	@Override
	public List<String> getFileName(int recipeNo) {
		return sqlSessionTemplate
				.selectList("recipeFile.getFileName", recipeNo);
	}

	/**
	 * 레시피 수정
	 */
	@Override
	public void updateRecipe(RecipeVO rvo) {
		sqlSessionTemplate.update("recipe.updateRecipe", rvo);
	}

	/**
	 * 재료로 레시피 정보를 가져온다.
	 */
	@Override
	public List<String> getRecipeNoByItem(String item) {
		return sqlSessionTemplate.selectList("recipe.getRecipeNoByItem", item);
	}

	/**
	 * 레시피 번호로 그 해당 레시피의 모든 gnb_no를 리스트로 받아온다.
	 */
	@Override
	public int getGoodAndBadNoCountByRecipeNo(int recipeNo) {
		return sqlSessionTemplate.selectOne(
				"recipe.getGoodAndBadNoCountByRecipeNo", recipeNo);
	}

	/**
	 * 레시피 번호로 그 해당 레시피의 모든 good_n_bad 테이블을 삭제
	 */
	@Override
	public void deleteGoodAndBad(int recipeNo) {
		sqlSessionTemplate.delete("recipe.deleteGoodAndBad", recipeNo);

	}

	/**
	 * 레시피 번호 ,로그인 아이디를 이용 아이디와 레시피 번호에 해당하는 good이 있는지를 확인 good이 없으면 0을 리턴
	 */
	@Override
	public int getGood(HashMap<String, Object> map) {
		int good = 0;
		try {
			good = sqlSessionTemplate.selectOne("recipe.getGood", map);
		} catch (Exception e) {
			good = 0;
		}
		return good;
	}

	/**
	 * 레시피 번호 ,로그인 아이디를 이용 아이디와 레시피 번호에 해당하는 bad가 있는지를 확인 bad가 없으면 0을 리턴
	 */
	@Override
	public int getBad(HashMap<String, Object> map) {
		int bad = 0;
		try {
			bad = sqlSessionTemplate.selectOne("recipe.getBad", map);
		} catch (Exception e) {
			bad = 0;
		}
		return bad;
	}

	/**
	 * 레시피번호 로그인 아이디를 이용 추천비추천테이블이 존재 유무를 count로 확인
	 */
	@Override
	public int getGoodAndBadNoCountByRecipeNoAndMemberId(
			HashMap<String, Object> map) {
		return sqlSessionTemplate.selectOne(
				"recipe.getGoodAndBadNoCountByRecipeNoAndMemberId", map);
	}

	/**
	 * 레시피 번호 로그인 아이디를 이용 추천 비 추천 테이블 생성 good 에 1 데이터 입력
	 */
	@Override
	public void insertGood(HashMap<String, Object> map) {
		sqlSessionTemplate.insert("recipe.insertGood", map);
	}

	/**
	 * 레시피 번호, 로그인 아이디를 이용 해당 추천/비추천 테이블의 good값을 0으로 변경
	 */
	@Override
	public void updateCancleGood(HashMap<String, Object> map) {
		sqlSessionTemplate.update("recipe.updateCancleGood", map);
	}

	/**
	 * 레시피 번호, 로그인 아이디를 이용 해당 추천/비추천 테이블의 good값을 1로, bad를 0으로 변경
	 */
	@Override
	public void updateUpGood(HashMap<String, Object> map) {
		sqlSessionTemplate.update("recipe.updateUpGood", map);
	}

	/**
	 * 레시피 번호 로그인 아이디를 이용 추천 비 추천 테이블 생성 bad 에 1 데이터 입력
	 */
	@Override
	public void insertBad(HashMap<String, Object> map) {
		sqlSessionTemplate.insert("recipe.insertBad", map);
	}

	/**
	 * 레시피 번호, 로그인 아이디를 이용 해당 추천/비추천 테이블의 bad값을 0으로 변경
	 */
	@Override
	public void updateCancleBad(HashMap<String, Object> map) {
		sqlSessionTemplate.update("recipe.updateCancleBad", map);
	}

	/**
	 * 레시피 번호, 로그인 아이디를 이용 해당 추천/비추천 테이블의 bad값을 1로, good를 0으로 변경
	 */
	@Override
	public void updateUpBad(HashMap<String, Object> map) {
		sqlSessionTemplate.update("recipe.updateUpBad", map);
	}

	/**
	 * 레시피 즐겨찾기
	 */
	@Override
	public void registerFavorite(FavoriteVO fvo) {
		sqlSessionTemplate.insert("recipe.registerFavorite", fvo);

	}
	/**
	 * 아이디와 페이지 No를 이용 즐겨찾기 정보를 리스트로 받아온다
	 */
	@Override
	public List<FavoriteVO> getFavoriteRecipeList(Map<String, Object> map) {
		System.out.println(map);
		return sqlSessionTemplate.selectList("recipe.getFavoriteRecipeList",
				map);
	}

	/**
	 * 즐겨찾기 삭제
	 */
	@Override
	public void deleteFavorite(FavoriteVO fvo) {
		sqlSessionTemplate.delete("recipe.deleteFavorite", fvo);

	}

	/**
	 * 아이디로 즐겨찾기한 레시피 번호 리스트 조회
	 */
	@Override
	public List<Integer> findRecipeNoById(String id) {
		return sqlSessionTemplate.selectList("recipe.findRecipeNoById", id);
	}

	/**
	 * 레시피 번호로 레시피 hits update
	 */
	@Override
	public void updateHitsByRecipeNo(int recipeNo) {
		sqlSessionTemplate.update("recipe.updateHitsByRecipeNo", recipeNo);
	}

	/**
	 * 레시피의 good값을 받아온다
	 */
	@Override
	public int getTotalGood(int recipeNo) {
		return sqlSessionTemplate.selectOne("recipe.getTotalGood", recipeNo);
	}

	/**
	 * 레시피의 bad값을 받아온다
	 */
	@Override
	public int getTotalBad(int recipeNo) {
		return sqlSessionTemplate.selectOne("recipe.getTotalBad", recipeNo);
	}

	/**
	 * id를 이용 해당 아이디의 모든 레시피 번호를 받아온다.
	 */
	@Override
	public List<String> getMyRecipeList(String id) {
		return sqlSessionTemplate.selectList("recipe.getMyRecipeList", id);
	}
	/**
	 * 회원 아이디와 레시피 번호로 
	 * 즐겨찾기 존재 유무 확인
	 */
	@Override
	public int getFavoriteRecipe(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectOne("recipe.getFavoriteRecipe", map);
	}

	/**
	 * 레시피 번호를 이용해서 
	 * 레시피 번호를 가지고 있는 즐겨찾기 테이블 수 가져온다. 
	 */
	@Override
	public int getFavoriteNoAllList(int recipeNo) {
		return sqlSessionTemplate.selectOne("recipe.getFavoriteNoAllList",recipeNo);
	}
	/**
	 * 레시피 번호를 이용
	 * 해당 레시피를 즐겨찾기로 저장한 모든 즐겨찾기 테이블 정보 삭제
	 */
	@Override
	public void deleteFavorites(int recipeNo) {
		sqlSessionTemplate.delete("recipe.deleteFavorites",recipeNo);		
	}
	
	/**
	    * 회원 아이디에 해당하는 즐겨찾기 목록(레시피 번호)을 갖고 온다.
	    */
	   @Override
	   public List<String> getFavoriteListByMemberId(String id) {
	      return sqlSessionTemplate.selectList("recipe.getFavoriteListByMemberId", id);
	   }
		/**
		 * 아이디에 해당하는 즐겨찾기 갯수 갖고온다.
		 */
		@Override
		public int totalFavoriteContent(String id) {
			return sqlSessionTemplate.selectOne("recipe.totalFavoriteContent", id);
		}
		
		/**
		 * 회원 정보 수정 시 닉네임이 변경되는 경우
		 * 레시피 정보의 닉네임이 변경 되도록 한다
		 */
		@Override
		public void updateRecipeNickName(Map<String, Object> map) {
			sqlSessionTemplate.update("recipe.updateRecipeNickName",map);
		}

		/**
		 *  자동 완성 기능을 위해 value 값으로 부분값을 입력받아 해당하는 재료 목록을 리턴
		 */
		@Override
		public List<String> getItemListByPart(String value) {		
			return sqlSessionTemplate.selectList("recipe.getItemListByPart",value);
		}
		/**
		 * 아이디이용
		 * 해당 gnb no 리스트 받아온다
		 */
		@Override
		public List<Integer> getMyGoodAndBadNoList(String id) {
			return sqlSessionTemplate.selectList("recipe.getMyGoodAndBadNoList",id);
		}
		/**
		 * gnbNo를 이용
		 * 해당 gnb정보 삭제
		 */
		@Override
		public void deleteGoobAndBadAll(int gnbNo) {
			sqlSessionTemplate.delete("recipe.deleteGoobAndBadAll",gnbNo);
		}
		/**
		 * 아이디이용
		 * 해당 favorite no 리스트 받아온다
		 */
		@Override
		public List<Integer> getMyFavoriteNoList(String id) {
			return sqlSessionTemplate.selectList("recipe.getMyFavoriteNoList",id);
		}
		/**
		 * favoriteNo를 이용
		 * 해당 favorite 정보 삭제
		 */
		@Override
		public void deletefavoriteAll(int favoriteNo) {
			sqlSessionTemplate.delete("recipe.deletefavoriteAll",favoriteNo);	
		}
}
