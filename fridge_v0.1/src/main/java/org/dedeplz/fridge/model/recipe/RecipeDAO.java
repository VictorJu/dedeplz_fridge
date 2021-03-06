package org.dedeplz.fridge.model.recipe;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface RecipeDAO {
	public int totalContent();
	public void insertRecipeItem(RecipeItemVO rivo);
	public void insertItem(String itemName);
	public int getCountItemNo(String itemName);
	public int getItemNo(String itemName);
	public RecipeVO getRecipeInfo(int recipeNo);
	public void registerRecipe(RecipeVO rvo);
	public void insertRecipeFile(FileVO fvo);
	public List<String> getItemNoList(int recipeNo);
	public String getItemNameByItemNo(int itemNo);
	public void deleteRecipe(int recipeNo);
	public void deleteRecipeItem(int recipeNo);
	public void deleteRecipeFile(int recipeNo);
	public List<String> getAllRecipeNo();
	public String getFileLastNamePath(String fileLastNo);
	public int getRecipeNoByPath(String filePath);
	public List<String> getAllFilePahtByRecipeNo(int recipeNo);
	public List<String> getFileName(int recipeNo);
	public void updateRecipe(RecipeVO rvo);
	public List<String> getRecipeNoByItem(String item);
	public int getGoodAndBadNoCountByRecipeNo(int recipeNo);
	public void deleteGoodAndBad(int recipeNo);
	public int getGood(HashMap<String, Object> map);
	public int getBad(HashMap<String, Object> map);
	public int getGoodAndBadNoCountByRecipeNoAndMemberId(HashMap<String, Object> map);
	public void insertGood(HashMap<String, Object> map);
	public void updateCancleGood(HashMap<String, Object> map);
	public void updateUpGood(HashMap<String, Object> map);
	public void insertBad(HashMap<String, Object> map);
	public void updateCancleBad(HashMap<String, Object> map);
	public void updateUpBad(HashMap<String, Object> map);
	public void registerFavorite(FavoriteVO fvo);
	public List<FavoriteVO> getFavoriteRecipeList(Map< String, Object> map);
	public void deleteFavorite(FavoriteVO fvo);
	public List<Integer> findRecipeNoById(String id);
	public void updateHitsByRecipeNo(int recipeNo);
	public int getTotalGood(int recipeNo);
	public int getTotalBad(int recipeNo);
	public List<String> getMyRecipeList(String id);
	public int getFavoriteRecipe(HashMap<String,Object> map);
	public int getFavoriteNoAllList(int recipeNo);
	public void deleteFavorites(int recipeNo);
	public List<String> getFavoriteListByMemberId(String id);
	public int totalFavoriteContent(String id);
	public List<String> getItemListByPart(String value);
	public void updateRecipeNickName(Map<String, Object> map);
	public List<Integer> getMyGoodAndBadNoList(String id);
	public void deleteGoobAndBadAll(int gnbNo);
	public List<Integer> getMyFavoriteNoList(String id);
	public void deletefavoriteAll(int favoriteNo);
}
