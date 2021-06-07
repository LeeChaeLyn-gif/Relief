<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 4.0ver -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<!-- Jquery 3.6 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<style>
	* {
		box-sizing: border-box;
	}
	
	#wrap {
		width: 1140px;
		heigth : auto;
		/* nav를 중앙부로 */
		            
		margin: auto;
	}
	
	.paddingtop {
		padding-top: 50px;
	}
	.tabSize {
		width : 100%;
		height: auto; 
	
	}
	label {
		text-align : right; !important
	}
</style>
</head>
<body>
	<jsp:include page="listNavPage.jsp"/>
		<div id="wrap">
		<h2 class="text-center paddingtop">회원 정보</h2>
		<hr>
			<form action="${contextPath}/mypage/updateMember" method="POST" onsubmit="return pwdValidate();">
			  <div class="form-group row">
				  <label for="id" class="col-sm-4 col-form-label textRight">회원ID</label>
				  <div class="col-sm-4">
				  	<input type="text" readonly class="form-control" id="id" value="${a.aid}">
				  </div>
			  </div>
			  <div class="form-group row">
			  	<label for="pwd" class="col-sm-4 col-form-label textRight">비밀번호</label>
			  	<div class="col-sm-4">
			  		<input type="password" class="form-control" name="pwd1" id="pwd1" placeholder="비밀번호 입력">
			  	</div>
			  </div>
			  <div class="form-group row">
			    <label for="pwd2" class="col-sm-4 col-form-label textRight">비밀번호 확인</label>
			    <div class="col-sm-4 tabSize">
			      <input type="password" class="form-control" name="pwd2" id="pwd2" placeholder="비밀번호 확인">
			    </div>
			  </div>
			  <div class="form-group row">
			    <label for="name" class="col-sm-4 col-form-label textRight">이름</label>
			    <div class="col-sm-4">
			      <input type="password" readonly class="form-control" id="name" value="${a.name}" readonly>
			    </div>
			  </div>
			  <div class="form-group row">
			    <label for="tel" class="col-sm-4 col-form-label textRight">전화번호</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" name="phone" id="phone" value="${a.phone}">
			    </div>
			  </div>

			  <div class="form-group row">
			  	<label for="post" class="col-sm-4 col-form-label textRight">우편번호</label>
			  	<div class="col-sm-4">
			  		<input type="text" class="form-control postcodify_postcode5" id="postCode" name="postCode" value="${postCode}" readonly>
			  	</div>
			    
			  </div>
			   <div class="form-group row">
			  	<label for="address1" class="col-sm-4 col-form-label textRight">주소</label>
			  	<div class="col-sm-4">
			  		<input type="text" class="form-control postcodify_address" id="addr" name="addr" value="${addr}" readonly>
			  	</div>
			  </div>
			  
			   <div class="form-group row">
			  	<label for="address2" class="col-sm-4 col-form-label textRight">상세 주소</label>
			  	<div class="col-sm-4">
			  		<input type="text" class="form-control postcodify_details" id="addr_details" name="addr_details" value="${addr_details}">
			  	</div>
			  	<button id="postcodify_search_button" type="button" class="btn btn-primary">주소 검색</button>
			  </div>
			  
			  
			  <div class="text-center paddingtop">
			  <button type="button" class="btn btn-primary" style="margin-right:90px" onclick="deleteBtn('${ a.aid}')">탈퇴하기</button>
			  <button type="submit" class="btn btn-primary" style="margin-left:90px">수정하기</button>
			  </div>
		    </form>
	   </div>
	   <script type="text/javascript">
	   
		   function pwdValidate() {
			    var pwd1 = document.getElementById('pwd1').value;
			    var pwd2 = document.getElementById('pwd2').value;
			    if ( pwd1 != pwd2 ) {
			    	alert("비밀번호가 일치하지 않습니다.");
			      	return false;
			    }
		   }
		   
		   function deleteBtn(aid) {
			   console.log(aid);
			   if(confirm("회원 탈퇴를 하시겠습니까?") == true) {
			   		location.href ='${contextPath}/mypage/deleteMember?aid=' + aid ;
			   } else {
				   return;
			   }
		   }
		
	   </script>
	   
	   <script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
    	<script>
    		$(function(){
    				$("#postcodify_search_button").postcodifyPopUp();
    		});
    	</script>
</body>
</html>