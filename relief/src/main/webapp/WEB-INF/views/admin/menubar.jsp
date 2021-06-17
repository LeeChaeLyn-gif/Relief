<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="favicon.ico">

	<!--Google Font link-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Raleway:400,600,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">

 
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/slick.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/slick-theme.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/animate.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/fonticons.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/font-awesome.min.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/bootstrap.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/magnific-popup.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/bootsnav.css">


	<!--For Plugins external css-->
	<!--<link rel="stylesheet" href="assets/css/plugins.css" />-->

	<!--Theme custom css -->
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/style.css">
	<!--<link rel="stylesheet" href="assets/css/colors/maron.css">-->

	<!--Theme Responsive css-->
	<link rel="stylesheet" href="${contextPath}/resources/css/assets/css/responsive.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous" jQuery.noConflict();></script>
	<script src="<c:url value="/resources/css/assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"/>"></script>
<title>menuBar</title>
<style>
nav.navbar.bootsnav{
    margin-bottom: 0;
    -moz-border-radius: 0px;
    -webkit-border-radius: 0px;
    -o-border-radius: 0px;
    border-radius: 0px;
    background-color: #fff;
    border: none;
    height : 170px !important;
    border-bottom: solid 1px #e0e0e0;
    z-index: 9;
}
@media (max-width: 992px){
nav.navbar.bootsnav.navbar-fixed .logo-display {
    display: none !important;
}
nav.navbar.bootsnav.navbar-fixed .logo-scrolled {
    display: block !important;
}
}
	#userName {
		font-size : 16px;
		font-weight : bold;
	}
	#testAlram {
		width:150px;
		float:right;
		margin-top:-15%;
		margin-right:-25%;
	}
	#alramBox {
		height : 150px;
		margin-top : 10%;
	}
	#alramUser {
		margin:auto;
	}
	#alramContent {
		margin:auto;
		text-overflow:ellipsis;
		white-space:nowrap;
		word-wrap:normal;
		overflow:hidden;
	}
</style>
</head>
<body data-spy="scroll" data-target=".navbar-collapse">
	
	<div class="culmn">

		<nav class="navbar navbar-light navbar-expand-lg  navbar-fixed white no-background bootsnav">

			<div class="container">
				<!-- Start Atribute Navigation -->
				<div class="attr-nav">
					<ul>
						<c:choose>
						<c:when test="${ empty sessionScope.loginUser }">
						<li class="search"><a href="${ contextPath }/account/login"><i class="fa fa-user-circle fa-2x" aria-hidden="true"></i>로그인</a></li>
						<li class="search"><a href="${ contextPath }" onClick="alert('다행 회원만 이용 가능합니다. 로그인 해주세요.')"><i class="fa fa-commenting fa-2x" aria-hidden="true"></i>채팅&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
						<script>
						
						</script>
						</c:when>
						<c:otherwise>
						<p id="userName">${ loginUser.name }님 환영합니다.</p>
						<li class="search"><a href="${ contextPath }/account/logout"><i class="fa fa-user-circle fa-2x" aria-hidden="true"></i>로그아웃</a></li>
						<li class="chatBtn"><a href="#"><i class="fa fa-commenting fa-2x" aria-hidden="true"></i>채팅&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
						<div id="alramBox">
							<div id="testAlram"></div>
						</div>
						</c:otherwise>
						</c:choose>
						
					</ul>
				</div>

				<div class="navbar-header">
					<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbar-menu"></button>

                       <a href="${ contextPath }"><img src="${contextPath}/resources/css/assets/images/logo7.jpg" class="logo logo-display m-top-10" alt="" width="150px"></a>
                    	<a href="${ contextPath }"><img src="${contextPath}/resources/css/assets/images/logo7.jpg" class="logo logo-scrolled" alt="" width="150px"></a>
				</div>

				<!-- Start Top Search -->
				<div class="top-search" style="margin-left: 100px;">
						<div class="container">
								<c:choose>
								<c:when test="${ empty sessionScope.loginUser }">
								<form action="${ contextPath }/board/nloginlist" method="get" onsubmit="return validate()">
								<div class="input-group">
									<input type="text" class="form-control" name="searchValue" id="searchValue" placeholder="상품명, 지역명 검색" <c:if test="${ !empty searchValue }"> value="${searchValue }"</c:if>>
									<button class="input-group-addon" type="submit"><i class="fa fa-search" id="submitBtn"></i></button>
								</div>	
								</form>
								</c:when>
								<c:otherwise>
								<form action="${ contextPath }/board/list" method="get"  onsubmit="return validate()">
								<div class="input-group">
									<input type="text" class="form-control" name="searchValue" id="searchValue" placeholder="상품명, 지역명 검색" <c:if test="${ !empty searchValue }"> value="${searchValue }"</c:if>>
									<button class="input-group-addon" type="submit"><i class="fa fa-search" id="submitBtn"></i></button>
								</div>
								</form>	
								</c:otherwise>
								</c:choose>
							
						</div>
					
				</div>
				<!-- End Top Search -->
			</div>
			
			<br><br>
			<div class="container">
				<div id="cbutton"><i class="fa fa-bars fa-2x"></i></div>
				<div id="navbar-menu">
					<ul class="nav navbar-nav navbar-right ml-auto" data-in="fadeInDown" data-out="fadeOutUp" style="float:right;">
						<c:choose>
							<c:when test="${ empty sessionScope.loginUser }">
							<li><a href="${ contextPath }/home"  onClick="alert('다행 회원만 이용 가능합니다. 로그인 해주세요.')">판매하기</a></li>
							<li><a href="${ contextPath }/faq/list">고객센터</a></li>
							<li><a href="${ contextPath }/qna/list">Q&A리스트</a></li>
							</c:when>
							<c:when test="${ loginUser.aid eq 'admin' }">
							<li><a href="${ contextPath }/admin/main">관리자페이지</a></li>
							</c:when>
							<c:otherwise>
							<li><a href="${ contextPath }/board/insertPage">판매하기</a></li>
							<li><a href="${ contextPath }/qna/list">Q&A리스트</a></li>
							<li><a href="${ contextPath }/mypage/confirm">마이페이지</a></li>
							<li><a href="${ contextPath }/faq/list">FAQ</a></li>
							<li><a href="${ contextPath }/notice/list">공지사항</a></li>
							<li><a href="${ contextPath }/review/list">리뷰</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
			
			<!-- 카테고리 -->
			<div class="container categorymenu" style="display : none">
			<div id="menu2">
				<ul class="M01">
					<c:forEach items="${ clist }" var="c">
						<c:if test="${ c.cgroup == 1 }">
							<li><a href="${ contextPath }/board/category1?cid=${c.cid}">${ c.cname }</a>
								<ul class="M02">
								<c:forEach  items="${ clist }" var="c">
									<c:if test="${ c.cgroup == 2 }">
									
											<li><a href="${ contextPath }/board/category2?cid=${c.cid}">${ c.cname }</a>
											<ul class="M03">
											<c:forEach  items="${ clist }" var="c">
												<c:if test="${ c.cgroup == 3 }">
														<li><a href="${ contextPath }/board/category3?cid=${c.cid}">${ c.cname }</a></li>
												</c:if>
											</c:forEach>
											</ul>
											</li>
									</c:if>
								</c:forEach>	
								</ul>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
		</nav>
	</div>
	
	
	<div class="p1"></div>
	<div class="p2"></div>
	<div class="p3"></div>

	<!-- JS includes -->

	<script src="<c:url value="/resources/css/assets/js/vendor/jquery-1.11.2.min.js"/>"></script>
	<script src="<c:url value="/resources/css/assets/js/vendor/popper.min.js"/>"></script>
	<script src="<c:url value="/resources/css/assets/js/vendor/bootstrap.min.js"/>"></script>

	<script src="<c:url value="/resources/css/assets/js/jquery.magnific-popup.js"/>"></script>
	<script src="<c:url value="/resources/css/assets/js/jquery.easing.1.3.js"/>"></script>
	<script src="<c:url value="/resources/css/assets/js/slick.min.js"/>"></script>
	<script src="<c:url value="/resources/css/assets/js/jquery.collapse.js"/>"></script>
	<script src="<c:url value="/resources/css/assets/js/bootsnav.js"/>"></script>


	<script>
		$("#cbutton").mouseenter(function(){
			$(".container").show(1000);
			$("#menu2").show(1000);
			$(".container").css("display : inline-block");
			$("#menu2").css({"opacity" : "1", "visibility" : "visible"});
		});
		 $("#menu2").mouseleave(function(e){
			 $(".categorymenu").hide();
		 	$("#menu2").css({"opacity" : "0", "visibility" : "hidden"});
		});
		$(".chatBtn").on("click", function(){
				var _width = '650';
			    var _height = '380';
				var _left = Math.ceil(( window.screen.width - _width )/2);
	    		var _top = Math.ceil(( window.screen.height - _height )/2);
	    		
				window.open("${ contextPath }/list", "", "width=500, height=600, left=" + _left + ", top=" + _top);
			});
		
		function category1(cid){
			location.href="${ contextPath }/board/category1?cid="+cid;
		}
		function validate(){
			var searchValue = $("#searchValue").val();
			
			if(searchValue == null || searchValue == ''){
				alert("한글자 이상의 검색어를 입력해주세요");
				return false;
			} else{
				return true;
			}
		}
		
		var ws;
		
		function wsOpen(){
			var type = "account";
			var targetId = "${loginUser.aid}";
			//웹소켓 전송시 현재 로그인한 아이디 값을 넘겨서 보낸다.
			ws = new WebSocket("ws://" + location.host + "/relief/" + type + "/"  + targetId);
			wsEvt();
			}
		
		function wsEvt() {
			ws.onopen = function(data){
				//소켓이 열리면 동작
				console.log(data);
			}
			
			
		ws.onmessage = function(data) {
			//메시지를 받으면 동작
			console.log("data : " + data.data);
			
			var alram = data.data;
			var d = JSON.parse(alram);
			
			console.log("message : " + d.msg );
			console.log("aid2 : " + d.accountId2);
			
			
			if(d.msg){
				$("#testAlram *").remove();
				$("#testAlram").append("<p id='alramUser'>" + d.accountId2 + "님의 메세지 : "+ "</p>" + "<p id='alramContent'>" + d.msg + "</p>");	
				$(".fa-commenting").css("color","red");
			}
			}
		}
		
		$(".chatBtn").on('click', function(){
			$(".fa-commenting").css("color","rgb(52, 73, 94)");
			$("#testAlram").remove();
		});
		
		function send() {
			var option ={
				type2: "account",
				accountId : '${loginUser.aid}',
				message : $("#testAlram").val()
			}
			console.log(option);
			ws.send(JSON.stringify(option));
			$('#testAlram').val("");
		}
		
	</script>

	<script src="<c:url value="/resources/css/assets/js/plugins.js"/>"></script>
	<script src="<c:url value="/resources/css/assets/js/main.js"/>"></script>
</body>
</html>