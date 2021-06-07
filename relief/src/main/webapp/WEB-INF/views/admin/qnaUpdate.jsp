<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
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
    .navbar1 ul li a{
        text-decoration: none;
        color: white;
        background-color: rgb(0, 51, 85);
        display: block;
        width: 300px;
        height: 50px;
    }
    .navbar1 ul li{
        float: left;
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
        background-color: red;
    }
    .mainbar h1{
        color: white;
        background-color: rgb(0, 51, 85);
        margin: 0px;
        margin-left: 340px;
    }
    .info{
        border: 2px solid lightgray;
        height: 50px;
        margin-left: 340px;
        text-align: center;
    }
    .title{
        background-color: rgb(0, 51, 85);
        width: 100px;
        border-radius: 5px;
        display: inline-block;
    }
    .title h3{
        margin: 0px;
        text-align: center;
        color: white;
        padding: 10px;
    }
    .titleValue{
        display: inline-block;
        width: 600px;
        font-weight: bolder;
    }
    .create{
        background-color: rgb(0, 51, 85);
        width: 100px;
        border-radius: 5px;
        display: inline-block;
    }
    .create h3{
        margin: 0px;
        text-align: center;
        color: white;
        padding: 10px;
    }
    .createValue{
        display: inline-block;
        font-weight: bolder;
    }
    
    .qna{
        border: 2px solid lightgray;
        width: 1100px;
        height: 500px;
        margin-left: 500px;
    }
    .qna h1{
        text-align: center;
        background-color: white;
        color: black;
        margin: 0 auto;
    }
    .qna h5{
        text-align: center;
        background-color: white;
        color: black;
        margin: 0 auto;
    }
    .btn{
        background-color: rgb(0, 51, 85);
        width: 100px;
        height: 50px;
        border-radius: 5px;
        color: white;
    }
    .btnArea{
    	text-align : center;
    	margin-left : 150px;
    }
    input[name=atitle]{
    	height : 25px;
    	width : 300px;
    	margin : 0 auto;
    }
    </style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar"><h1>문의사항</h1>
        <div class="info">
            <div class="title"><h3>제목</h3></div>
            <p class="titleValue">${ q.qtitle }</p>
            <div class="create"><h3>작성일</h3></div>
            <p class="createValue">${ q.createDate }</p>
            <div class="create"><h3>작성자</h3></div>
            <p class="createValue">${ q.aid }</p>
        </div>
        <div class="qna">
			${ q.qcontent }
        </div>
        <form action="${ contextPath }/admin/qnaUpdate" method="post">
	        <div class="qna">
	        		<input type="hidden" value="${ q.qid }" name="qid">
		            <div class="title"><h3>제목</h3></div>
		            <input type="text" name="atitle" value="${ q.atitle }">
		            <hr>
		            <textarea id="summernote" name="acontent">
			            	${ q.acontent }
		            </textarea>
	        </div>
	        <div class="btnArea">
	            <button type="submit" class="btn">확인</button>
	        </div>    
        </form>
    </div>
    <script>
    $('#summernote').summernote({
    	placeholder: '답변을 입력해주세요.', 
    	tabsize: 2,
    	minHeight: null,
    	maxHeight: null,
    	lang : 'ko-KR',
    	height: 370 });
    </script>
</body>
</html>