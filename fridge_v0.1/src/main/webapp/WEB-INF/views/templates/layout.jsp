<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
img#goodImg {
    vertical-align: text-top;
}
img#badImg {
    vertical-align: text-top;
} 
</style>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
   <title>Creative - Start Bootstrap Theme</title>

    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">

    <!-- Custom Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" type="text/css">

    <!-- Plugin CSS -->
    <link rel="stylesheet" href="css/animate.min.css" type="text/css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/creative.css" type="text/css">
    <link href="css/agency.css" rel="stylesheet">
	
	 <!-- jQeryUI -->
	<link href="jsui/jquery-ui.css" rel="stylesheet" type="text/css"> 


<title>Tiles Layout</title> 



<link rel="stylesheet" type="text/css"
   href="${initParam.root}/css/home.css" />
</head>
<body id="page-top">
<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">Top</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
               <c:choose>
                  <c:when test="${sessionScope.mvo==null}">
                     <li><a class="page-scroll"
                        href="${initParam.root}member_joinclause_view.do">join</a></li>
                     <li><a class="page-scroll" data-toggle="modal" href="#"
                        data-target="#exampleModal" data-whatever="@getbootstrap">login</a>
                     </li>
                     <li><a class="page-scroll" href="#portfolio">Search</a></li>
                  </c:when>
                  <c:otherwise>
                  <li>
	                  <a class="page-scroll dropdown-toggle" data-toggle="dropdown">
	                   ${sessionScope.mvo.nick}님 접속중 <span class="fa fa-caret-down"></span></a>
			              <ul class="dropdown-menu" role="menu">			                
	                       	<li><a class="page-scroll"
                       		 href="${initParam.root}member_mypage.do">My Page</a></li>
                   		  	<li><a class="page-scroll"
	                        href="${initParam.root}getMyRecipeInfo.do">My Recipe</a></li>	  
                        	<li><a class="page-scroll"
	                        href="${initParam.root}favoriteView.do">즐겨 찾기</a></li>                   
		              	</ul>
		              </li>                    
                     <li><a class="page-scroll"
                        href="${initParam.root}registerRecipeForm.do">New Recipe</a></li>
                     <li><a class="page-scroll"
                        href="${initParam.root}member_logout.do">logout</a></li>
                        
                        
                     <c:choose>
                        <c:when test="${sessionScope.mvo.level=='6' }">
                           <li><a class="page-scroll"
                              href="${initParam.root}admin_adminpage.do">관리자페이지</a></li>
                        </c:when>
                     </c:choose>
                  </c:otherwise>
               </c:choose>
            </ul>
         </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
    <div id="header" class="fluid"><tiles:insertAttribute name="header" /></div>
   <div id="container">
   <section class="no-padding" id="portfolio">
   <div id="main"><tiles:insertAttribute name="main" /></div>
   </section>
   <%-- <div id="footer"><tiles:insertAttribute name="footer" /></div> --%>
</div>
	 <!-- jQuery -->
    <script src="js/jquery.js"></script>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="jsui/jquery-ui.js"></script>

	
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="js/jquery.easing.min.js"></script>
    <script src="js/jquery.fittext.js"></script>
    <script src="js/wow.min.js"></script>

    <!-- Custom Theme JavaScript -->    
    <script src="js/creative.js"></script>
   


   <script type="text/javascript">
   var idchecked=false;
   var totalGood;
   var totalbad;
   $(document).ready(function(){
      $("#findMyId").click(function() {   
            $.ajax({
               type:"POST",
               url:"member_findMyId.do",
               data:$("#findMyIdForm").serialize(),   
               success:function(data){                  
                  if(data=="fail"){
                     $("#findMyIdView").html("id에 해당하는 정보가 없음");
                  }else{                  
                     $("#findMyIdView").html("회원님의 아디는 '"+data+"' 입니다");      
                  }               
               }//callback         
            });//ajax
         });//keyup
      $("#findMyPassBtn").click(function(){         
         $.ajax({
            type:"post",
            url:"member_findMyPassword.do",
            data:$("#findMyPasswordForm").serialize(),
            success:function(data){                  
                     if(data=="fail"){
                        $("#findMyPassView").html("password에 해당하는 정보가 없음");
                     }else{                  
                        $("#findMyPassView").html("회원님의 비밀번호 '"+data+"' 입니다");      
                     }               
                  }//callback      
         });//ajax
      });//findMyPassBtn
      
      $("#loginBtn").click(function() {
         $("#loginForm").submit();
      });
      
   //회원가입
      $("#id").keyup(function(){
            var id=$("#id").val().trim();
            $("#id_error").html("");
            if(id.length<4 || id.length>10){
               checkResultId="";
               return;
            }
            
            $.ajax({
               type:"POST",
               url:"member_memberIdCheck.do",
               data:"id="+id,   
               success:function(data){                  
                  if(data=="fail"){
                  $("#idCheckView").html(id+" 는(은) 사용하실 수 없습니다.");
                     checkResultId="";
                       idchecked=false;
                  }else{                  
                     $("#idCheckView").html(id+" 는(은) 사용할 수 있습니다.");      
                     checkResultId=id;
                     idchecked=true;
                  }               
               }//callback         
            });//ajax
         });//keyup
         
         //닉넴 중복체크
         $("#nick").keyup(function(){
            var nick=$("#nick").val().trim();
            $("#nick_error").html("");
            if(nick.length<2 || nick.length>6){
               $("#nickCheckView").html("닉네임은 2글자 이상 6글자 이하여야 합니다.");
               checkResultNick="";
               return;
            }
            
            $.ajax({
               type:"POST",
               url:"member_memberNickCheck.do",
               data:"nick="+nick,   
               success:function(data){                  
                  if(data=="fail"){
                  $("#nickCheckView").html(nick+"는(은) 사용하실 수 없습니다.");
                     checkResultNick="";
                  }else{                  
                     $("#nickCheckView").html(nick+"는(은) 사용가능합니다.");      
                     checkResultNick=nick;
                  }               
               }//callback         
            });//ajax
         });//keyup
         
         
         $("#pass").keyup(function(){
            $("#pass_error").html("");
             var password= $("#pass").val();
             if(password.length<4 || password.length>10){
                     $("#passwordSizeView").html("비밀번호는 4자이상 10자이하여야 합니다.");
                  }else{
                     $("#passwordSizeView").html("");
                  }
         });
         $("#password2").keyup(function(){
                $("#pass_error").html("");
                var password = $("#pass").val();
               var password2 = $("#password2").val();
              /*  alert("1 : "+password +" "+ "2 : "+password2); */
               if(password2.length<4 || password2.length>10){
                  $("#passwordCheckView").html("");
               }else if (password2!=password) {
                  $("#passwordCheckView").html("비밀번호가 서로 같지 않습니다.");
               }else if(password2==password){
                  $("#passwordCheckView").html("확인 되었습니다.");
               }
            }); 
         $("#cancelBtn").click(function(){
            location.href="${initParam.root}home.do";
         });
         $("#regForm").submit(function(){
            var password = $("#pass").val();
            var password2 = $("#password2").val();
               if(password!=password2){
                  alert("패스워드를 다시 확인 해주십시요.");
                  return false;
               }
         });
         
         $("#submitBtn").click(function() {
             if(idchecked==true){
                $("#regForm").submit();
             }else{
                alert("ID 체크를 먼저 해주시길 바랍니다.");
             }
          });
         
         $("#cancelBtn").click(function(){
               location.href="${initParam.root}home.do";
            });
         $("#updateBtn").click(function(){
            location.href = "${initParam.root}member_updateMemberForm.do";
         });
         $("#deleteBtn").click(function(){
               location.href="${initParam.root}member_deleteMemberForm.do";
            });
         $("#gobackBtn").click(function() {
            location.href="${initParam.root}home.do";
         });
         
         //recipe 등록
         $("#register").click(function(){
             obj.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []); 
             var info = $("#contents").val().indexOf("<img");
               if($("#title").val()==""){
                  alert("제목을 입력하세요");
                  return false;
               }else if($("#cookingTime").val()==""){
                  alert("요리시간을 입력하세요");
                  return false;
               }else if (info == -1) {
                   alert("레시피 사진을 하나 이상 입력하세요!!!");
                   return false; 
               }else if($("#items").val()==""){
                  alert("태그를 입력하세요");
                  return false;
               }
               $("#registerForm").submit();
             
          });//submit
          //수정폼
         $("#updateRecipeBtn").click(function(){
               if($("#cookingTime").val()==""){
                  alert("요리시간을 선택하세요!");
                  return false;
               }
               obj.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
               $("#updateForm").submit();
            });
            $("#cancleBtn").click(function(){
               location.href="home.do";
            });
            $("#password3").keyup(function() {
               $("#pass_error").html("");
               var password = $("#password3").val();
               if (password.length<4 || password.length>10) {
                  $("#passwordSizeView").html("비밀번호 4자이상 10자이하");
               } else {
                  $("#passwordSizeView").html("");
               }
            });//keyup Password1
            $("#password4").keyup(function() {
               $("#pass_error").html("");
               var password = $("#password4").val();
               var password2 = $("#password3").val();
               if (password.length<4 || password.length>10) {
                  $("#passwordCheckView").html("");
               } else if (password2 != password) {
                  $("#passwordCheckView").html("비밀번호가 서로 같지 않습니다.");
               } else if (password2 == password) {
                  $("#passwordCheckView").html("일치합니다.");
               }
            });

            $("#resetBtn").click(function() {
               $("#password3").val("");
               $("#password4").val("");
               $("#name").val("${mvo.name}");
               $("#nick").val("${mvo.nick}");
               $("#email").val("${mvo.email}");
               $("#answer").val("${mvo.answer}");
            });
            $("#updateFinishBtn").click(function() {
               var password = $("#password3").val();
               var password2 = $("#password4").val();
               if (password != password2) {
                  alert("패스워드를 확인 해주시길 바랍니다.");
                  return false;
               }
               $("#updForm").submit();
            });   
            
            
            
            var goodImg="<img src='${initParam.root}/img/추천.jpg' id='goodImg'>&nbsp;&nbsp;";
            var badImg="<img src='${initParam.root}/img/비추천.jpg' id='badImg'>&nbsp;&nbsp;";
      		/* 좋아요 추천 */
            $("#gogo").on("click","#totalGood",function(){
            	if("${sessionScope.mvo.id}"==""){
            		alert("로그인 하세요");
            	}
            	else if("${sessionScope.mvo.id}"==$("#gnbUseMemberId").val()){
            		//alert("자신의 레시피는 추천 불가");
            		$("#totalGood").disabled();
            	} else{//레시피 아이디 말고 다른 사람 로그인
            		$.ajax({
            			type:"POST",
            			url:"checkGoodAndBad.do",
            			data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val(),
            			success:function(data){ 
            				//alert(data.count+" "+data.good+" "+data.bad);
            				if(data.count==0){
            					if(confirm("추천하시겠습니까?")){
            						$.ajax({
            							type:"POST",
            							url:"updateGood.do",
            							data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val()+"&goodCase=0",
            							success:function(data){           
            								totalGood+=1;
            								$("#totalGood").html(goodImg+totalGood);
            							}//callback
            						});//ajax
            					}//if
            				}else if(data.count==1&&data.good==1){
            					if(confirm("이미 추천하셨습니다. 추천 취소하시겠습니까?")){
            						$.ajax({
            							type:"POST",
            							url:"updateGood.do",
            							data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val()+"&goodCase=1",
           								success:function(data){       
           									totalGood+=-1;
           									$("#totalGood").html(goodImg+totalGood);
           								}//callback
           							});//ajax	
           						}//if
           					}else if(data.count==1&&data.good==0&&data.bad==0){
           						if(confirm("추천하시겠습니까?")){
            						$.ajax({
            							type:"POST",
            							url:"updateGood.do",
            							data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val()+"&goodCase=2",
            							success:function(data){        
            								totalGood+=1;
            								$("#totalGood").html(goodImg+totalGood);	
            							}//callback
            						});//ajax
            					}//if
           					}else if(data.count==1&&data.good==0&&data.bad==1){
           						if(confirm("비추천한 레시피입니다.추천으로 바꾸시겠습니까?")){
           							$.ajax({
            							type:"POST",
            							url:"updateGood.do",
            							data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val()+"&goodCase=2",
            							success:function(data){       
            								totalGood+=1;
            								totalBad+=-1;
            								$("#totalGood").html(goodImg+totalGood);	
            								$("#totalBad").html(badImg+totalBad);
            							}//callback
            						}); //ajax
           						} //if
           					}//else if
           		    }//callback         
           		 });//ajax
            	}//else	
            });//ajax
            /*싫어요 비추천*/
            $("#gogo").on("click","#totalBad",function(){
            	if("${sessionScope.mvo.id}"==""){
            		alert("로그인 하세요");
            	}
            	else if("${sessionScope.mvo.id}"==$("#gnbUseMemberId").val()){
            		//alert("자신의 레시피는 추천 불가");
            		$("#totalBad").disabled();
            	} else{//레시피 아이디 말고 다른 사람 로그인
            		$.ajax({
            			type:"POST",
            			url:"checkGoodAndBad.do",
            			data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val(),
            			success:function(data){ 
            				//alert(data.count+" "+data.good+" "+data.bad);
            				if(data.count==0){
            					if(confirm("비추천하시겠습니까?")){
            						$.ajax({
            							type:"POST",
            							url:"updateBad.do",
            							data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val()+"&badCase=0",
            							success:function(data){           
            								totalBad+=1;
            								$("#totalBad").html(badImg+totalBad);
            							}//callback
            						});//ajax
            					}//if
            				}else if(data.count==1&&data.bad==1){
            					if(confirm("이미 비추천하셨습니다. 비추천 취소하시겠습니까?")){
            						$.ajax({
            							type:"POST",
            							url:"updateBad.do",
            							data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val()+"&badCase=1",
           								success:function(data){       
           									totalBad+=-1;
           									$("#totalBad").html(badImg+totalBad);
           								}//callback
           							});//ajax	
           						}//if
           					}else if(data.count==1&&data.good==0&&data.bad==0){
           						if(confirm("비추천하시겠습니까?")){
            						$.ajax({
            							type:"POST",
            							url:"updateBad.do",
            							data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val()+"&badCase=2",
            							success:function(data){        
            								totalBad+=1;
            								$("#totalBad").html(badImg+totalBad);	
            							}//callback
            						});//ajax
            					}//if
           					}else if(data.count==1&&data.good==1&&data.bad==0){
           						if(confirm("추천한 레시피입니다.비추천으로 바꾸시겠습니까?")){
           							$.ajax({
            							type:"POST",
            							url:"updateBad.do",
            							data:"id=${sessionScope.mvo.id}&recipeNo="+$("#gnbUseRecipeNo").val()+"&badCase=2",
            							success:function(data){       
            								totalGood+=-1;
            								totalBad+=1;
            								$("#totalGood").html(goodImg+totalGood);	
            								$("#totalBad").html(badImg+totalBad);
            							}//callback
            						}); //ajax
           						} //if
           					}//else if
           		    }//callback         
           		 });//ajax
            	}//else
            }); 
          //마이페이지 즐겨찾기 List
            //체크박스 전체 체크
            $("#allCheckBtn").click(function(){
               $("input[name=chkBox]:checkbox").prop("checked", true);
               $("input[name=chkBox]:checkbox").attr("checked", true);

            });
            
            //체크박스 초기화
            $("#resetBtn").click(function(){
               $("input[name=chkBox]:checkbox").prop("checked", false);
               $("input[name=chkBox]:checkbox").attr("checked", false);

            });
            
          //삭제 버튼 클릭
			$("#delBtn").click(function(){
				/* alert($("input:checkbox[name=chkBox]:checked").val()); */
				$("input:checkbox[name=chkBox]:checked").each(function(){
					
					var no=$(this).val();
					if(confirm("선택한 즐겨찾기 항목을 삭제하시겠습니까???")){
						$.ajax({
							type:"POST",
							url:"deleteFavorite.do",				
							data:"memberId=${sessionScope.mvo.id}&recipeNo=" + no,
							dataType:"json",   
							success:function(result){ 			
								var favoriteInfo = "";
								if(result.list != 0){
									$.each(result.list,function(index,favorite){
										favoriteInfo += "<tr><td><input type='checkbox' id='chkBox' name='chkBox' value='" + favorite.recipeNo + "'</td>";
										favoriteInfo += "<td>" + (index + 1)+" </td>";
										favoriteInfo += "<td>" + favorite.recipeTitle + "</td></tr>";
									});
									$("#favoriteView").html(favoriteInfo);
								}else{
									var infomation = "<br><br><center><h3>등록된 즐겨찾기가 없습니다. ^^</h3></center>";
									$("#favorite").html(infomation);
								}
								location.reload();
								
							}
						});// ajax
					}
					});//foreach 
					  if($("input:checkbox[name=chkBox]:checked").val()==null){
						  alert("삭제할 레시피를 선택해주세요!!!");
					  }
				});//click
				
				/* 즐겨찾기 삭제 이벤트 */
	            $(document).on("click","#favoriteImg2",function(){
	               var recipeNo = $("#gnbUseRecipeNo").val();      
	                  $.ajax({
	                     type:"POST",
	                     url:"deleteFavorite.do",            
	                     data:"memberId=${sessionScope.mvo.id}&recipeNo=" + recipeNo,
	                     success:function(result){ 
	                            var info = "<img src='${initParam.root}/img/empty_star.png' id='favoriteImg1' width='50' height='50'></div>";
	                              $("#favoriteView").html(info);
	                             
	                     }
	                  });// ajax 
	               });
	            
	           /*  즐겨찾기 등록 */
	            $(document).on("click","#favoriteImg1",function(){
					var recipeNo = $("#gnbUseRecipeNo").val();
						$.ajax({
							type:"POST",
							url:"registerFavorite.do",				
							data:"memberId=${sessionScope.mvo.id}&recipeNo=" + recipeNo,
							success:function(result){ 
								 if(result!="fail"){
									 var info = "<img src='${initParam.root}/img/full_star.png' id='favoriteImg2' width='50' height='50'></div>";
									$("#favoriteView").html(info);
								}
								
								
							}
						});// ajax 
					//}
	            });//즐겨찾기 클릭 이벤트
	            //홈 버튼
	            $("#houseImg").click(function(){
	            	location.href="home.do";
	            });
	            
	          //board 등록
	    		$("#registerBoard").click(function(){
	    				 obj.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []); 
	    				 var info = $("#contents").val().indexOf("<img");
	    				  if($("#category").val()==""){
	    			            alert("카테고리를 입력하세요");
	    			            return false;
	    				  } else if($("#title").val()==""){
	    		            alert("제목을 입력하세요");
	    		            return false;
	    		         } 
	    		         $("#registerBoardForm").submit();
	    		       
	    			 });
	    		//board 수정
	    		$("#updateBoardBtn").click(function(){
	                if($("#category").val()==""){
	                     alert("말머리를 선택하세요!");
	                     return false;
	                  }
	                obj.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	                $("#updateBoard").submit();
	            });
	    		//취소 버튼
	            $("#cancleBoardBtn").click(function(){
	                  location.href="${initParam.root}BoardList.do";
	               });
	            //제목,글쓴이,내용 별 검색
	            $("#searchBtn").click(function(){
	               var searchCategory=$("#searchCategory").val();
	               //var searchContent=$("#searchContent").val();
	               if(searchCategory=='title'){
	                  location.href="${initParam.root}searchByTitle.do?title="+$("#searchContent").val();
	               }else if(searchCategory=='writer'){
	                  location.href="${initParam.root}searchByWriter.do?nick="+$("#searchContent").val();
	               }else if(searchCategory=='contents'){
	                  location.href="${initParam.root}searchByContents.do?contents="+$("#searchContent").val();
	               }else if(searchCategory==""){
	                  alert("검색 조건을 선택하세요!");
	               }
	            });
	            //카테고리 별 검색
	            $("#searchByCategoryBtn").click(function(){
	            	var category=$("#category").val();
	            	if(category=='all'){
	            location.href="${initParam.root}BoardList.do";
	            	}else{
	            		  location.href="${initParam.root}searchByCategory.do?category="+category;
	            	}
	            });
	            //자유게시판 댓글달기
                $("#boardCommentBtn").click(function() {   
                   $.ajax({
                      type:"POST",
                      url:"registerBoardComment.do",
                      data:$("#boardCommentForm").serialize(),   
                      success:function(data){        
                          var table="<div class='col-md-10' style='padding:0px; height:auto; width:600px; margin-left: 50px'>";
                           table+="<table class='table' cellpadding='10'  style='table-layout:fixed'>"; 
                         for(var i=0;i<data.length;i++){
                            
                            table+="<input type='hidden' id='commentBoardNo' name='commentBoardNo' value="+data[i].commentBoardNo+">";
                             table+="<thead><tr><th colspan='2'><b>작성자"+ data[i].commentNick+"</b></th>";
                          
                           // table+="<th></th>";
                            table+="<th><b>"+data[i].commentTime+"</b></th></tr></thead>";
                            table+="<tbody><tr>";
                            table+="<td id='"+data[i].commentNo+"CommentContents' colspan='2'><font size='2'>"+data[i].commentContents+"</font></td>";
                            
                            if("${sessionScope.mvo.nick}"==data[i].commentNick){
                                  table+="<td><button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='updateBoardCommentBtn' name='updateBoardCommentBtn'>수정</button>"; 
                                table+="<button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='deleteBoardCommentBtn' name='deleteBoardCommentBtn'>삭제</button></td></tr></tbody>";
                            }else if("${sessionScope.mvo.level}"=='6'){
                                table+="<td><button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='deleteBoardCommentBtn' name='deleteBoardCommentBtn'>삭제</button></td></tr></tbody>";
                            }
                         }
                         table+="</table>";
                         table+="</div>";
                         $("#commentList").html(table); 
                         $("#boardComment").val("");
                      
                      }//callback         
                   });//ajax
                });
                
              
                  $(document).on("click", ":input[name=editCommentBtn]",function(e){             
                   
                     $.ajax({
                        type:"POST",
                        url:"updateBoardComment.do",
                        data:"commentNo="+$("#commentNo").val()+"&commentBoardNo="+$("#commentBoardNo").val()+"&commentContents="+$("#editComment").val(),   
                        success:function(data){
                           var table="<div class='col-md-10' style='padding:0px; height:auto; width:600px; margin-left: 50px'>";
                            table+="<table class='table' cellpadding='10'  style='table-layout:fixed'>"; 
                           for(var i=0;i<data.length;i++){                              
                              table+="<input type='hidden' id='commentBoardNo' name='commentBoardNo' value="+data[i].commentBoardNo+">";
                               table+="<thead><tr><th colspan='2'><b>작성자"+ data[i].commentNick+"</b></th>";

                              table+="<th><b>"+data[i].commentTime+"</b></th></tr></thead>";
                              table+="<tbody><tr>";
                              table+="<td id='"+data[i].commentNo+"CommentContents' colspan='2'><font size='2'>"+data[i].commentContents+"</font></td>";
                              
                              if("${sessionScope.mvo.nick}"==data[i].commentNick){
                                    table+="<td><button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='updateBoardCommentBtn' name='updateBoardCommentBtn'>수정</button>"; 
                                  table+="<button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='deleteBoardCommentBtn' name='deleteBoardCommentBtn'>삭제</button></td></tr></tbody>";
                              }else if("${sessionScope.mvo.level}"=='6'){
                                  table+="<td><button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='deleteBoardCommentBtn' name='deleteBoardCommentBtn'>삭제</button></td></tr></tbody>";
                              }                 
                           }
                           table+="</table>";
                           table+="</div>";
                           $("#commentList").html(table); 
                           $("#boardComment").val("");  
                           
                        }//callback
                   });//ajax
            });//editCommentBtn click
            
            
                //자유게시판 댓글 수정폼 load
                $(document).on("click", ":input[name=updateBoardCommentBtn]",function(e){
                   var commentNo=$(this).val();
                   if(confirm("수정하시겠습니까?")){
                  $.ajax({
                       type:"POST",
                       url:"showBoardComment.do",
                       data:"&commentBoardNo="+$("#commentBoardNo").val(),   
                       success:function(data){
                   var table="<div class='col-md-10' style='padding:0px; height:auto; width:600px; margin-left: 50px'>";
                     table+="<table class='table' cellpadding='10'  style='table-layout:fixed' >"; 
                   
                    for(var i=0;i<data.length;i++){
                      
                      table+="<input type='hidden' id='commentBoardNo' name='commentBoardNo' value="+data[i].commentBoardNo+">";
                      table+="<thead><tr>";
                    
                      table+="<th colspan='2'><b>작성자"+ data[i].commentNick+"</b></th>";
                      table+="<th><b>"+data[i].commentTime+"</b></th></tr></thead>";
                      table+="<tbody><tr>";
                      if(commentNo==data[i].commentNo){               
                         table+="<input type='hidden' id='commentNo' name='commentNo' value="+data[i].commentNo+">";
                         table+="<td colspan='2'><textarea rows='2' style='width: 100%;' id='editComment'>"
                         +data[i].commentContents+"</textarea>";
                         
                         table+="<td><input type='button' a class='btn btn-primary' value='수정' name='editCommentBtn'>"+
                         " <input type='button' a class='btn btn-danger' value='취소' name='cancelCommentBtn'></td></tr></tbody>"; 
                         
                      }else{
                         table+="<td id='"+data[i].commentNo+"CommentContents'><font size='2'>"+data[i].commentContents+"</font></td>";
                      }                                                                
          
                   }
                   table+="</table>";
                   table+="</div>";
                   $("#commentList").html(table);                  
                       }//callback
               });//ajax
                   }
                });
                
              //자유게시판 댓글 삭제
                $(document).on("click", ":input[name=deleteBoardCommentBtn]",function(e){
                   if(confirm("삭제하시겠습니까?")){
                    $.ajax({
                      type:"POST",
                      url:"deleteBoardComment.do",
                      data:"commentNo="+$(this).val()+"&commentBoardNo="+$("#commentBoardNo").val(),   
                      success:function(data){           
                          var table="<div class='col-md-10' style='padding:0px; height:auto; width:600px; margin-left: 50px'>";
                          table+="<table class='table' cellpadding='10'  style='table-layout:fixed'>"; 
                         for(var i=0;i<data.length;i++){
                            table+="<input type='hidden' id='commentBoardNo' name='commentBoardNo' value="+data[i].commentBoardNo+">";
                            table+="<input type='hidden' id='commentNo' name='commentNo' value="+data[i].commentNo+">";
                             table+="<thead><tr>";
                     
                            table+="<th colspan='2'><b>작성자 "+ data[i].commentNick+"</b></th>";
                            table+="<th><b>"+data[i].commentTime+"</b></th></tr></thead>";
                            table+="<tbody><tr>";
                            table+="<td id='"+data[i].commentNo+"CommentContents' colspan='2'><font size='2'>"+data[i].commentContents+"</font></td>";
                            if("${sessionScope.mvo.nick}"==data[i].commentNick){
                            table+="<td><button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='updateBoardCommentBtn' name='updateBoardCommentBtn'>수정</button>"; 
                            table+="<button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='deleteBoardCommentBtn' name='deleteBoardCommentBtn'>삭제</button></td></tr></tbody>"; 
                         
                            }else if("${sessionScope.mvo.level}"=='6'){
                                table+="<td><button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='deleteBoardCommentBtn' name='deleteBoardCommentBtn'>삭제</button></td></tr></tbody>";
                            }
                         }
                         table+="</table>";
                         table+="</div>";
                         $("#commentList").html(table); 
                         $("#boardComment").val("");
                      }//callback         
                   });//ajax 
                   }else{
                      return false;
                   }      
                });
                //수정시 취소버튼 
                $(document).on("click", ":input[name=cancelCommentBtn]",function(e){
                  //location.reload();
                      $.ajax({
                            type:"POST",
                            url:"showBoardComment.do",
                            data:"commentNo="+$("#commentNo").val()+"&commentBoardNo="+$("#commentBoardNo").val()+"&commentContents="+$("#editComment").val(),   
                            success:function(data){
                               var table="<div class='col-md-10' style='padding:0px; height:auto; width:600px; margin-left: 50px'>";
                                table+="<table class='table' cellpadding='10'  style='table-layout:fixed'>"; 
                               for(var i=0;i<data.length;i++){
                                  table+="<input type='hidden' id='commentBoardNo' name='commentBoardNo' value="+data[i].commentBoardNo+">";
                                   table+="<thead><tr><th><b>작성자"+ data[i].commentNick+"</b></th>";
                                  table+="<th></th>";
                                  table+="<th><b>"+data[i].commentTime+"</b></th></tr></thead>";
                                  table+="<tbody><tr>";
                                  table+="<td id='"+data[i].commentNo+"CommentContents' colspan='2'><font size='2'>"+data[i].commentContents+"</font></td>";
                                  if("${sessionScope.mvo.nick}"==data[i].commentNick){
                                        table+="<td><button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='updateBoardCommentBtn' name='updateBoardCommentBtn'>수정</button>"; 
                                      table+=" <button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='deleteBoardCommentBtn' name='deleteBoardCommentBtn'>삭제</button></td></tr></tbody>";
                                  }else if("${sessionScope.mvo.level}"=='6'){
                                      table+="<td><button type='button' a class='btn btn-primary' value='"+data[i].commentNo+"' id='deleteBoardCommentBtn' name='deleteBoardCommentBtn'>삭제</button></td></tr></tbody>";
                                  }            
                               }
                               table+="</table>";
                               table+="</div>";
                               $("#commentList").html(table); 
                               $("#boardComment").val("");  
                            }//callback
                       });//ajax
                }); //cancleCommentBtn
                
           //자동완성         
		     $("#autocomplete").autocomplete({
		    	source : function( request, response ) {
		    		/* var itemValue= $("#autocomplete").value;
		    		alert(itemValue);
		    		var len = 0;
		            for (var i = 0; i < itemValue.length; i++) {
		                if (escape(itemValue.charAt(i)).length == 6) {
		                    len++;
		                }
		                len++;
		            }
		           
		    		alert(len ); */
		    		/* if($(this).value.length >=2){
			    		var strArray=$(this).value.split('#');
			    		alert(strArray[0]);
		    			
		    		} */
		         $.ajax({
		                type: 'post',
		                url: "autocomplete.do",
		                dataType: "json",
		                //request.term = $("#autocomplete").val()
		                data: { value : request.term },
		                success: function(data) {
		                    //서버에서 json 데이터 response 후 목록에 뿌려주기 위함
		                    response( 
		                        $.map(data, function(item) {
		                            return {		                            	
		                                label: "#"+item,
		                                value: "#"+item+"#"
		                            };
		                        })
		                    );
		                }
		           });
		        },
		    //조회를 위한 최소글자수
		    minLength: 1,
		    select: function( event, ui ) {
		        // 만약 검색리스트에서 선택하였을때 선택한 데이터에 의한 이벤트발생
		    }
		});

   });//ready
   //댓글 팝업
   $(document).on("click","#commentPopUp",function(){
      window.open("getCommentRecipeList.do?commentRecipeNo="+$("#gnbUseRecipeNo").val(), "popup",
     "width=408,height=560,top=60,left=450");
        return false;
        });//댓글 팝업_submit
        
</script>
<script type="text/javascript">
function testAlert(path) {
   $.ajax({
      type:"POST",
        url:"showRecipe.do",
        data:"filePath="+path,   
        dataType : 'json',
        success:function(data){     
        	totalGood=data.totalGood;
        	totalBad=data.totalBad;
        //비회원        	
        $("#gogo").html(" <h2 class='heading'>"+data.rvo.title+"</h2><p>"+data.tag+"<br>요리시간 : "+data.rvo.cookingTime+"분  조회수 : " +data.rvo.hits+"</p>"
                +data.rvo.contents
        );        
        if("${sessionScope.mvo.id}"!=""){
			//즐겨찾기 버튼
        	if(data.favoriteInfo==0){
  	           $("#gogo").append(	        	
  	        		"<div id='favoriteView'><img src='${initParam.root}/img/empty_star.png' id='favoriteImg1'width='50' height='50'></div>"	
  	           );
          	}else{
          		  $("#gogo").append(      	        		
  	          		"<div id='favoriteView'><img src='${initParam.root}/img/full_star.png' id='favoriteImg2'></div>"	
        	           );        		
          	}   
        }
        $("#gogo").append(       
        			"<span id='totalGood' value='"+data.totalGood+"' style='font-size: 20px;'><img src='${initParam.root}/img/추천.jpg' id='goodImg'>&nbsp;&nbsp;"+data.totalGood+"</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        			+"<span id='totalBad' value='"+data.totalBad+"' style='font-size: 20px;'><img src='${initParam.root}/img/비추천.jpg' id='badImg'>&nbsp;&nbsp;"+data.totalBad+"</span><br><br>"
        			+"<input type='hidden' id='gnbUseRecipeNo' value='"+data.rvo.recipeNo+"'>"
        			+"<input type='hidden' id='gnbUseMemberId' value='"+data.rvo.memberId+"'>"	
        );   
        //회원의 view
        if("${sessionScope.mvo.id}"!=""){		
        	$("#gogo").append(         			 
         			 "<a button type='button' class='btn btn-success btn-sm'   id='commentPopUp'  >댓글달기</a>  "	
         	  );   
			//자기의 글인지 아닌지 판단 하여 수정 삭제 가능 여부 버튼
        	if(data.rvo.memberId=="${sessionScope.mvo.id}"){        		
        		$("#gogo").append(        				
        				"<a class='btn btn-danger btn-sm' href='updateForm.do?recipeNo="
        						+data.rvo.recipeNo+"' >수정</a>  "
                        +"<a class='btn btn-danger btn-sm' href='deleteRecipe.do?recipeNo="
                       			 +data.rvo.recipeNo+"&memberId="+data.rvo.memberId+"''>삭제</a> <br> "                         
     			);
        	}else if("${sessionScope.mvo.level}"==6){
        		$("#gogo").append(        				        				
                        "<a class='btn btn-danger btn-sm' href='deleteRecipe.do?recipeNo="
                        		+data.rvo.recipeNo+"&memberId="+data.rvo.memberId+"''>삭제</a> <br> "                         
     			);
        	}
        	
        }
        //닫기 버튼
        $("#gogo").append(
        		 "<br><br><br><br><button type='button' class='btn btn-primary' data-dismiss='modal'>"
                 +"<i class='fa fa-times'></i> Close</button>"	
	           );
        
        }//callback         
     });//ajax 

     
}
</script>

</body>
</html>