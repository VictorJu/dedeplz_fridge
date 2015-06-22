<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
          <center>
<form method=post action="updateRecipe.do" id="updateForm" >
         <table class="content">
            <tr>
               <td>
     
               <br><br>
               <b>글번호: <input type=text name=recipeNo value=${rvo.recipeNo } readonly></input>
               | 타이틀:<input type=text name=title value=${rvo.title }></input></b>
               </td></tr><tr>   <td>
                  <font size="2">작성자: <input type=text name=nick 
                  value="${rvo.nick}"  readonly></input></font>
            작성일시:  ${rvo.postDate } 
                   <td>요리시간 : 
                     <select name="cookingTime" id="cookingTime">
                     <option value="${requestScope.rvo.cookingTime}">${requestScope.rvo.cookingTime}</option>
                     <option value="10">10분</option>
                     <option value="15">15분</option>
                     <option value="20">20분</option>
                     <option value="20">30분</option>
                     <option value="20">40분</option>
                     <option value="20">50분</option>
                  </select>
               </td>    
         </table>   
         <br>
<textarea name="contents" id="contents" rows="24" style="width:100%;"> ${rvo.contents }</textarea><br>
태그 : <input type="text" name="items" id="items" size="65" value="${tag}">  
<input type="button" id="updateRecipeBtn" value="수정하기">&nbsp;
<input type="button" id="cancleBtn" value="취소"> &nbsp;<br><br><br><br><br>
</form>
          </center>
<script type="text/javascript">
    //전역변수
    var obj = [];               
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder:"contents",
        sSkinURI: "resources/editor/SmartEditor2Skin.html", 
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,             
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true, 
        }   
});
</script>