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
        color: #597a96;
        text-align: center;
    }
    .headDiv2{
        display: inline-block;
        bottom: 30px;
    }
    .info{
            border: 2px solid lightgray;
            margin-left : 100px;
        	width : 70%;
        }
    .title1{
        background-color: #597a96;
        width: 100px;
        border-radius: 5px;
        display: inline-block;
    }
    .title1 h3{
        margin: 0px;
        text-align: center;
        color: white;
        padding: 10px;
    }
    .titleValue{
        display: inline-block;
        font-weight: bolder;
    }
    .create{
            background-color: #597a96;
            width: 12%;
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
        height: 300px;
        width: 53%;
        padding: 0px;
        margin-left: 20%;
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
    .btn1{
        background-color: #597a96;
        width: 100px;
        height: 50px;
        border-radius: 5px;
        color: white;

    }
    .btnArea{
        	width : 91%;
        	text-align : center;
        }
     h3{
     	text-align : center;
     	margin-right : 10%;
     }
    </style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar">
	<div class="title">
	<h1>문의사항</h1>	
	</div>
        <div class="info">
            <div class="title1"><h3>제목</h3></div>
            <p class="titleValue">${ q.qtitle }</p>
            <div class="create"><h3>작성일</h3></div>
            <p class="createValue">${ q.createDate }</p>
            <div class="create"><h3>작성자</h3></div>
            <p class="createValue">${ q.aid }</p>
        </div>
        <div class="qna">
			${ q.qcontent }
        </div>
        <c:if test="${ empty q.acontent }">
        <h3>답변을 기다리고 있습니다!</h3>
        </c:if>
        <c:if test="${ !empty q.acontent }">
        <div class="qna">
            <div class="title1"><h3>제목</h3></div>
            <p class="titleValue">${ q.atitle }</p>
            <hr>
            	${ q.acontent }
        </div>
        </c:if>
        <div class="btnArea">
        	<button type="button" class="btn1" onclick="location.href='${ contextPath }/admin/qnaUpdate?qid=${ q.qid }'">답변하기</button>
        </div>
    </div>
</body>
</html>