<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }"
scope="application"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main Page</title>
<style>
* {
	box-sizing: border-box;
}

/* #outside {
	width: 1000px;
	min-height: 800px;
	margin: auto;
} */

section, footer, div {
	border: 1px solid transparent;
	display: block;
}

h2, h4 {
	text-align: center;
	color: rgb(52, 73, 94) !important;
}

.top {
	width: 100%;
	height: 90%;
	float: left;
}

.bottom {
	width: 100%;
	height: 10%;
	float: left;
}

#content {
	width: 100%;
	height: 95%;
	float: left;
}

#part1 {
	width: 10%;
	height: 100%;
	float: left;
}

/* .product {
	width: 200px;
	height: 320px;
	margin: 10px;
	text-align : center;
} */

.product img {
	width: 200px;
	height: 220px;
	margin: 10px;
}

#todayList div {
	width: 200px;
	height: 300px;
	margin: 10px;
	text-align : center;
	border : 1px solid lightgray;
	display : inline-block;
}

#todayList img {
	width: 200px;
	height: 200px;
	text-align : center;
	margin-bottom : 15px;
}

.product2 {
	width: 200px;
	height: 30px;
	text-align: center;
}

.product3 {
	width: 200px;
	height: 30px;
	text-align: center;
}

.item-img {
	width: 200px;
	height: 220px;
	margin-bottom: 10px;
}

#part2 {
	width: 80%;
	height: 100%;
	float: left;
}

#part2-up {
	height: 600px;
	text-align: center;
}

#demo {
	height: 300px;
	width: 600px;
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
}

#part2-down {
/* 	width: 1115px; */
	min-height: 600px;
	margin:0 auto;
	float: left;
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
</style>
</head>
<body>
<<<<<<< HEAD
<c:if test="${ empty sessionScope.loginUser }">
<a href="${ contextPath }/account/login">로그인</a>
</c:if>
<c:if test="${ sessionScope.loginUser.aid eq 'admin' }">
	<a href="${ contextPath }/admin/main">관리자페이지</a>
</c:if>
<c:if test="${ !empty sessionScope.loginUser }">
<a href="${ contextPath }/account/logout">로그아웃</a>
</c:if>
<form action="${ contextPath }/board/list" method="get">
<input type="text" name="searchValue">
<button type="submit">검색</button>
</form>
	<jsp:include page="common/menubar.jsp" />
	<jsp:include page="common/sidebar.jsp" /><br>
	<br><br><br><br><br><br><br><br><br>
	<div class="outside">
		<div id="part1"></div>
		<div id="part2">
			<div class="top">
				<div id="part2-up">
					<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous" jQuery.noConflict();></script>
<!-- 					<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
						integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
						crossorigin="anonymous"></script>
					<script
						src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
						integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
						crossorigin="anonymous"></script>
					<script
						src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
						integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
						crossorigin="anonymous"></script> -->
					<script>
						$('.carousel').carousel({
							interval : 1000
						})
					</script>
					<h2>공지사항 / 이벤트</h2><br>
					<div id="demo" class="carousel slide" data-ride="carousel"
						style="width: 600px; height: 250px; text-align: center;">
						<div class="carousel-inner" style="text-align: center;">

							<div class="carousel-item active" style="text-align: center;">

								<img class="d-block w-100"
									src="https://images.pexels.com/photos/213399/pexels-photo-213399.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"
									alt="First slide">
								<div class="carousel-caption d-none d-md-block">
								</div>
							</div>
							<div class="carousel-item">
								<img class="d-block w-100"
									src="https://images.pexels.com/photos/2355519/pexels-photo-2355519.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"
									alt="Second slide">
							</div>
							<div class="carousel-item">
								<img class="d-block w-100"
									src="https://images.pexels.com/photos/2544554/pexels-photo-2544554.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"
									alt="Third slide">
							</div>

							<a class="carousel-control-prev" href="#demo" data-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>

							</a> <a class="carousel-control-next" href="#demo" data-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>

							</a>

							<ul class="carousel-indicators">
								<li data-target="#demo" data-slide-to="0" class="active"></li>
								<li data-target="#demo" data-slide-to="1"></li>
								<li data-target="#demo" data-slide-to="2"></li>
							</ul>

						</div>
					</div>
				</div>

				<div id="part2-down">
					<div id="content_1">
						<h2>오늘의 추천상품</h2>
						<br>
						<div id="product">
							<div id="todayList">
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			<script>
			$(function(){
				todayList();
				setInterval(todayList, 100000);
			})
			
			function todayList(){
				$.ajax({
					url : "${contextPath}/board/todayList",
					dataType : "json",
					success : function(data){
						console.log(data);
						
						contentBody = $("#product div");
						contentBody.html("");
						
						for(var i in data){
							var div = $("<div onclick='selectBoard("+ data[i].board_id +")'>");
							var file = data[i].renameFileName;
							var img = $("<img>", {"src" : "${ contextPath }/resources/buploadFiles/"+ file});
							/* var img = $("<div>").html("<img src='${ contextPath }/resources/images/fileicon.png'>"); */
							var name = $("<h4>").text(data[i].title);

							var p1 = data[i].price;
							const pr = p1.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
							var bprice = $("<p>").text(pr);
							bprice.append(" 원");
							
							div.append(img, name, bprice);
							contentBody.append(div);
						}
					},
					error : function(e){
						alert("code : " + e.status + "\n"
								+ "message : " + e.responseText);
					}
				});
			}
			
			function selectBoard(board_id){
				location.href='${contextPath}/board/detail?board_id=' + board_id;
			}
		</script>

			<div class="bottom">
				<footer id="footer">
					<p>
						대표이사: 김다행 | 개인정보보호담당자: 이다행 | 주소: 서울특별시 강남구 테헤란로10길 9 그랑프리 빌딩 7층<br>
						사업자등록번호: 113-11-22222<br> <br> 다행㈜는 통신판매중개자로서 중고거래마켓 다행의
						거래 당사자가 아니며, 입점판매자가 등록한 상품정보 및 거래에 대해 책임을 지지 않습니다.<br> <br>
						Copyright ⓒ Relief Inc. All rights reserved.
					</p>
				</footer>
			</div>
		</div>
		<div id="part3"></div>
	</div>
<jsp:include page="./mypage/listNavPage.jsp"/>
<br><br><br>
<center>
<h2><a href="${ContaxtPath}/faq/list">fqa 바로가기</a></h2>
<hr>
<h2><a href="${ContaxtPath}/notice/list">notice 바로가기</a></h2>
</center>
</body>

</html>
