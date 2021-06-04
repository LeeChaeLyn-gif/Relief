<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 메뉴바는 어떤 페이지든 포함하고 있으므로 contextPath 변수 선언 후 application에서 모두 사용 -->
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<style>
        .headDiv{
            display: inline-block;
        }
        .homeimg{
            width: 200px;
            height: 100px;
            display: inline-block;
            margin-left: 100px;
        }
        .adminPage{
            display: inline-block;
            margin-bottom: 0px;
            margin-top: 0px;
            margin-left: 20px;
            color: rgb(0, 51, 85);
            text-align: center;
        }
        .headDiv2{
            display: inline-block;
            bottom: 30px;
        }
        .adminPage{
        	cursor:pointer;
        }
 </style>
</head>
<body>
	<c:if test="${ !empty msg }">
		<script>alert('${msg}');</script>
		<c:remove var="msg"/>
	</c:if>
	
	<div class="headDiv">
        <a href="${ contextPath }/home"><img src="${ contextPath }/resources/images/relief.jpg" class="homeimg"></a>
    </div>
    <div class="headDiv2">
        <h1 class="adminPage">관리자 페이지</h1>
    </div>
    <nav class="navbar1" id="navbar1">
        <ul>
            <li><a href="${ contextPath }/admin/notice"><h2>공지사항</h2></a></li>
            <li><a href="${ contextPath }/admin/category"><h2>카테고리</h2></a></li>
            <li><a href="${ contextPath }/admin/report"><h2>신고</h2></a></li>
            <li><a href="${ contextPath }/admin/block"><h2>제재회원 목록</h2></a></li>
            <li><a href="${ contextPath }/admin/qna"><h2>문의사항</h2></a></li>
            <li><a href="${ contextPath }/admin/faq"><h2>자주묻는질문</h2></a></li>
            <li><a href="${ contextPath }/admin/ad"><h2>광고관리</h2></a></li>
        </ul>
    </nav>
    <script>
        $("#navbar1 ul li a").on("click",function(){
            $("#navbar1 ul li a").css("background","rgb(0, 51, 85)");
            $(this).css("background", "red");
        });
        
        $(".adminPage").on("click", function(){
        	location.href="${ contextPath }/admin/main";
        });
    </script>
</body>
</html>