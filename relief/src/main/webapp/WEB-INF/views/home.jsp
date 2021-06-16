<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	background : white;
	padding-top : 10px;
}
#recentlist{
	width : 90px;
	min-height : 200px;
	display : inline-block;
	border : 1px solid lightgray;
	background : white;
	margin-top : 10px;
	padding-top : 10px;
}

.scrollup{
	margin-top : 10px;
	display : inline-block;
	text-align : center;
}
.carousel-inner{
	border : 1px solid rgb(52, 73, 94);
}

</style>
</head>
<body>
	<jsp:include page="common/menubar.jsp" />
	<jsp:include page="common/sidebar.jsp" /><br>
	<br><br><br><br><br><br><br><br><br>
	<div class="outside">
		<div id="part1"></div>
		<div id="part2">
			<div class="top">
				<div id="part2-up">
					<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous" jQuery.noConflict();></script>
					<script>
						$('.carousel').carousel({
							interval : 1000
						})
					</script>
					<h2>공지사항 / 이벤트</h2><br>
					<div id="demo" class="carousel slide" data-ride="carousel"
						style="width: 600px; height: 300px; text-align: center;">
						<div class="carousel-inner" style="text-align: center;">

							<div class="carousel-item active" style="text-align: center;">

								<img class="d-block w-100"
									src="${ contextPath }/resources/images/noticeImg.jpg">
							</div>
							<c:forEach items="${ nlist }" var="n">
								<div class="carousel-item">
									<a href="${ contextPath }/notice/detail?notice_id=${n.notice_id}&page=1">
									<img class="d-block w-100" src="${ contextPath }/resources/nuploadFiles/${ n.rename_fileName }" style="width : 600px; height : 300px;"></a>
								</div>
							</c:forEach>

							<a class="carousel-control-prev" href="#demo" data-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>

							</a> <a class="carousel-control-next" href="#demo" data-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>

							</a>

							<ul class="carousel-indicators">
							<li data-target="#demo" data-slide-to="0" class="active"></li>
							<c:forEach var="i" begin="1" end="${ fn:length(nlist) }">
								<li data-target="#demo" data-slide-to="i"></li>
							</c:forEach>
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
					<hr>
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
</body>

</html>
