<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다행 신고페이지</title>
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
</head>
<style>
.outer {
	text-align:center;
}
hr {
	width:40%;
}
	.submitBtn {
		background-color:rgb(52, 73, 94);
		color:white;
		border:none;
		width:70px;
		height:30px;
		float:right;
		margin-right:5%;
		margin-top:5%;
		border-radius:5px 5px 5px 5px;
	}
	.content2 {
		width: 80%;
		height:200px;
	}
</style>
<body>
	<form action="${ contextPath }/board/report" method="POST" >
	<div class="outer">
		<div class="title">
		<c:if test="${!empty bid }">
		<input type="hidden" name="bid" value="${ bid }">
		</c:if>
		<c:if test="${!empty chid }">
		<input type="hidden" name="chid" value="${ chid }">
		</c:if>
		<c:if test="${!empty rid }">
		<input type="hidden" name="rid" value="${ rid }">
		</c:if>
		<input type="hidden" name="aid2" value="${ accountId2 }">
		<br>
			<h3>신고하기</h3>
			<hr>
		</div>
		<br><br>
		<div class="content">
			<textarea class="content2" name="reportReason" style="resize: none;" placeholder="신고 내용을 직접 작성해주세요.
자세하게 적어주시면 신고처리에 큰 도움이 됩니다."></textarea>
		</div>
		<div class="btnArea">
			<button class="submitBtn" type="submit">등록</button>
		</div>
	</div>
	</form>
</body>
</html>