<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.net.URLDecoder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"
	value="${ pageContext.servletContext.contextPath }" scope="application" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Side Bar</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous" jQuery.noConflict();></script>
<style>
* {
	box-sizing: border-box;
}
.p1 {
	width: 10%;
	height: 100%;
	float : left;
}

.p2 {
	width: 80%;
	height: 100%;
	float : left;
}

.p3 {
	width: 10%;
	height: 100%;
	float : left;
}

#part3 {
	width: 10%;
	height: 100%;
	float: left;
}

.side_menu {
	width: 100px;
	min-height: 280px;
	position: fixed;
	text-align: center;
	/* border : 1px solid lightgray; */
}


.fa fa-heart{
	color: rgb(255, 153, 153);
}

#wishlist {
	width : 90px;
	height : 60px;
	display: inline-block;
	border : 1px solid lightgray;
	padding-top : 10px;
}
#recentlist{
	width : 90px;
	min-height : 200px;
	display : inline-block;
	border : 1px solid lightgray;
	margin-top : 10px;
	padding-top : 10px;
}

.scrollup{
	margin-top : 10px;
	display : inline-block;
	text-align : center;
}

#content_3{
	margin-top : 200px;
}
</style>
</head>
<body>
	<div class="p1"></div>
	<div class="p2"></div>
	<div class="p3">
		<div id="content_3">
			<div class="side_menu">
				<div id="wishlist">
					<h6>찜한상품</h6>
					<i class="fa fa-heart" aria-hidden="true">&nbsp;  </i><p></p>
				</div>
				<div id="recentlist">
					<h6>최근 본 상품</h6>
					<div id="rlist">

					</div>
				</div>
				<br>
				<div class="scrollup">
					<a href="#"><i class="fa fa-chevron-up"></i></a>
				</div>
			</div>
		</div>
	</div>
	<c:if test="${ !empty sessionScope.loginUser }">
	<script>
		$(function(){
			$.ajax({
				url : "${contextPath}/wishCount",
				type : "get",
				dataType : "json",
				success : function(data){
					console.log(data);
					
					contentBody = $("#wishlist i");
					var wCount = data.wCount;
					contentBody.append(wCount);
				},
				error : function(e){
				}
			})
			
			function getCookie(name) { 
			     var nameOfCookie = name + "="; 
			     var x = 0;
			     while (x <= document.cookie.length) { 
			          var y = (x + nameOfCookie.length); 
			          if (document.cookie.substring(x, y) == nameOfCookie) { 
			               if ((endOfCookie = document.cookie.indexOf(";", y)) == -1) 
			                    endOfCookie = document.cookie.length; 
			               return unescape(document.cookie.substring(y, endOfCookie)); 
			          }
			          x = document.cookie.indexOf(" ", x) + 1; 
			          if (x == 0) 
			               break; 
			     }
			     return ""; 
			}

			var cookie = getCookie('blist');
			if (cookie != "") {
			}

			})
			
		

	</script>
	</c:if>
</body>
</html>