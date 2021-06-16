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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<style>
		*{
			box-sizing : border-box;
		}
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
        .navbar1 ul li a{
            text-decoration: none;
            color: rgb(52, 73, 94);
            background-color: #597a96;
            display: block;
            width: 300px;
            height: 50px;
        }
        .navbar1 ul li{
            float: left;
            border : 1px solid rgb(52, 73, 94);
        }
        .navbar1{
            width: 50px;
        }
        ul{
            list-style:none;
        }
        .navbar1 ul li a h2{
            text-align: center;
            margin: 0px;
            padding: 5px;
        }
        .navbar1 ul li a:hover{
            background-color: #78A5CC;
        }
        .mainbar h1{
            color: rgb(52, 73, 94);
            background-color: #597a96;
            margin: 0px;
        }
        .title {
        	margin-left : 100px;
        	width : 70%;
        }
        .navbar1{
        	width : 30%;
        	height : 100%;
        }
 </style>
</head>
<body>
	<c:if test="${ !empty msg }">
		<script>alert('${msg}');</script>
		<c:remove var="msg"/>
	</c:if>
	
	<div class="headDiv">
        <a href="${ contextPath }"><img src="${ contextPath }/resources/images/relief.jpg" class="homeimg"></a>
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
        
        $(".adminPage").on("click", function(){
        	location.href="${ contextPath }/admin/main";
        });
    </script>
</body>
</html>