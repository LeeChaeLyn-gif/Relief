<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 메뉴바는 어떤 페이지든 포함하고 있으므로 contextPath 변수 선언 후 application에서 모두 사용 -->
<c:set var="ContextPath" value="${ pageContext.servletContext.contextPath }"
scope="application"/>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 4.0ver -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<!-- Jquery 3.6 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<style type="text/css">
	* {
		box-sizing: border-box;
	}
	 
	#nav {
		width: 1140px;
		heigth : auto;
		/* nav를 중앙부로 */
		            
		margin: auto;
	}
	a{
		color : #34495E;
	}
	.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
		background-color: #34495E;
	}
</style>
</head>
<body>	
<br><br><br><br><br><br><br><br><br><br><br>
<div id="nav">
	<nav class="nav nav-pills nav-fill">
	  <a class="nav-item nav-link" href="${ContextPath }/mypage/confirm">회원정보</a>
	  <a class="nav-item nav-link" href="${ContextPath }/mypage/wishList">찜목록</a>
	  <a class="nav-item nav-link" href="${ContextPath }/mypage/salesHistory">판매내역</a>
	  <a class="nav-item nav-link" href="${ContextPath }/mypage/purchaseHistory">구매내역</a>
	  <a class="nav-item nav-link" href="${ContextPath }/mypage/hiddenList">숨기기</a>
	</nav>
</div>

<!-- 클릭시 class active-->

<script>
	$(document).ready(function(){
	  $("#nav nav a").each(function(){
		  if($(this).attr("href")==window.location.pathname){
		  	$(this).attr("class","nav-item nav-link active");
		  }
		  else{
		    $(this).attr("class","nav-item nav-link");
		  }
	  });
	});
</script>

</body>
</html>