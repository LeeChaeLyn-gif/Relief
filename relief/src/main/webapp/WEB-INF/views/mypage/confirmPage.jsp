<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 4.0ver -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="<c:url value="/resources/css/assets/js/vendor/bootstrap.min.js"/>"></script>

<!-- Jquery 3.6 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<style type="text/css">
	* {
		box-sizing: border-box;
	}
	 
	#wrap {
		width: 1140px;
		heigth : auto;
		/* nav를 중앙부로 */
		            
		margin: auto;
	}
	
	.textClass {
		text-align : center;
	}
	
	.paddingtop {
		padding-top: 50px;
	}
	
	#passTab {
		width : 200px;
	}
	
	#center {
		width : 100%;
		float: left;
		text-align : center;
	}

	.btn-color {
		color : #fff;
		background-color : #34495E;
	}
</style>
</head>
<body>
   
	<jsp:include page="../common/menubar.jsp"/>
	<jsp:include page="listNavPage.jsp"/>
	
	 <div id="wrap">
		<h2 class="textClass paddingtop">비밀번호 확인</h2>
		<hr>
		<form action="${contextPath }/mypage/memberInfo" method="post">
		  <div class="form-group paddingtop" id="center">
		    <input id="passTab" type="password" class="form-control" name="password" placeholder="비밀번호 입력" style="display:inline;">
		     <button id="bts" type="submit" class="btn btn-color">확인</button>
		  </div>
		  
		</form>
	</div>
	
	
	<c:if test="${!empty msg}">
		<script>
		$(function(){
			alert('${msg}');
		})
		</script>
		<c:remove var="msg"/>
	</c:if>
	
	<script>

</body>
</html>