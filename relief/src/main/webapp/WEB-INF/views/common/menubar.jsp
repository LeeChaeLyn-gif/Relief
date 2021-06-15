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

</head>
<body data-spy="scroll" data-target=".navbar-collapse">
<%-- 	<c:if test="${ !empty msg }">
		<script>alert('${msg}');</script>
		<c:remove var="msg"/>
	</c:if> --%>
	
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
						<p>${ loginUser.name }님 환영합니다.</p>
						<li class="search"><a href="${ contextPath }/account/logout"><i class="fa fa-user-circle fa-2x" aria-hidden="true"></i>로그아웃</a></li>
						<li class="chatBtn"><a href="#"><i class="fa fa-commenting fa-2x" aria-hidden="true"></i>채팅&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
						</c:otherwise>
						</c:choose>
						
					</ul>
				</div>

				<div class="navbar-header">
					<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbar-menu"></button>

					<a class="navbar-brand" href="${contextPath}">
                       <img src="${contextPath}/resources/css/assets/images/logo7.jpg" class="logo logo-display m-top-10" alt="" width="150px">
                    	<img src="${contextPath}/resources/css/assets/images/logo7.jpg" class="logo logo-scrolled m-top-10" alt="" width="150px">
                    </a>
				</div>

				<!-- Start Top Search -->
				<div class="top-search" style="margin-left: 100px;">
					<form action="${ contextPath }/board/list" method="get">
						<div class="container">
							<div class="input-group">
								<input type="text" class="form-control" name="searchValue" placeholder="상품명, 지역명 검색" <c:if test="${ !empty searchValue }"> value="${searchValue }"</c:if>>
								<c:choose>
								<c:when test="${ empty sessionScope.loginUser }">
								<button class="input-group-addon" type="button" onClick="alert('다행 회원만 이용 가능합니다. 로그인 해주세요.')"><i class="fa fa-search" id="submitBtn"></i></button>
								
								</c:when>
								<c:otherwise>
								<button class="input-group-addon" type="submit"><i class="fa fa-search" id="submitBtn"></i></button>
								</c:otherwise>
								</c:choose>
							</div>
						</div>
					</form>	
					
				</div>
				<!-- End Top Search -->
			</div>
			

			<div class="container">
				<div id="cbutton"><i class="fa fa-bars fa-2x"></i></div>
			
				<div id="navbar-menu">
					<ul class="nav navbar-nav navbar-right ml-auto" data-in="fadeInDown" data-out="fadeOutUp" style="float:right;">
						<c:choose>
							<c:when test="${ empty sessionScope.loginUser }">
							<li><a href="${ contextPath }/home"  onClick="alert('다행 회원만 이용 가능합니다. 로그인 해주세요.')">판매하기</a></li>
							<li><a href="#pricing">고객센터</a></li>
							<li><a href="${ contextPath }/qna/list">Q&A리스트</a></li>
							</c:when>
							<c:when test="${ loginUser.aid eq 'admin' }">
							<li><a href="${ contextPath }/admin/main">관리자페이지</a></li>
							</c:when>
							<c:otherwise>
							<li><a href="${ contextPath }/board/insertPage">판매하기</a></li>
							<li><a href="${ contextPath }/qna/list">Q&A리스트</a></li>
							<li><a href="${ contextPath }/mypage">마이페이지</a></li>
							<li><a href="#pricing">고객센터</a></li>
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
	</script>

	<script src="<c:url value="/resources/css/assets/js/plugins.js"/>"></script>
	<script src="<c:url value="/resources/css/assets/js/main.js"/>"></script>
</body>
</html>