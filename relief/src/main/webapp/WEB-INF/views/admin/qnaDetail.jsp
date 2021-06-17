<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
	<style>
	.mainbar{
			width : 70%;
			float : left;
		}
		.titleArea{
			width : 800px;
			height : 52px;
			float : left;
			background-color: #597a96;
		}
		
		h2{
			color : white;
			font-weight : bold;
			text-align : center;
			padding-top : 7px;
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
        color: #597a96;
        text-align: center;
    }
    .headDiv2{
        display: inline-block;
        bottom: 30px;
    }
    .info{
        	width : 800px;
        }
    .title1{
        background-color: #597a96;
        width: 90px;
        display: inline-block;
    }
    .title1 h3{
        text-align: center;
        color: white;
    }
    .titleValue{
        display: inline-block;
            width : 200px;
            padding-left: 5px;
            font-weight: bolder;
    }
    .create{
            background-color: #597a96;
            width : 100px;
            height : 50px;
            display: inline-block;
    }
    .create h3{
        text-align: center;
            color: white;
    }
    .createValue{
        width : 100px;
            padding-left: 5px;
            display: inline-block;
            font-weight: bolder;
    }
    
    .qna{
        border: 2px solid lightgray;
        height: 300px;
        width: 800px;
        padding: 0px;
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
        	width : 800px;
        	text-align : center;
        }
     .answer{
     	width : 800px;
     	height : 50px;
     	text-align : center;
     	color : black;
     }
     .answer h3{
     	text-align : center;
     	color : black;
     }
    </style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar">
	<div class="titleArea">
	<h2>문의사항</h2>	
	</div>
        <div class="info">
            <div class="title1"><h3>제목</h3></div>
            <div class="titleValue"><h6>${ q.qtitle }</h6></div>
            <div class="create"><h3>작성일</h3></div>
            <div class="createValue"><h6>${ q.createDate }</h6></div>
            <div class="create"><h3>작성자</h3></div>
            <div class="createValue"><h6>${ q.aid }</h6></div>
        </div>
        <div class="qna">
			${ q.qcontent }
        </div>
        <c:if test="${ empty q.acontent }">
        <div class="answer">
        	<h3>답변을 기다리고 있습니다!</h3>
        </div>
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