<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
        .content{
            resize: none;
            height: 500px;
            width: 1250px;
            padding: 0px;
            margin-left: 100px;
        }
        .uBtn{
            margin-left: 900px;
            background-color: rgb(0, 51, 85);
            width: 100px;
            border-radius: 5px;
            color: white;
        }
        .dBtn{
            background-color: rgb(0, 51, 85);
            width: 100px;
            border-radius: 5px;
            color: white;
        }
        .Btn{
        	background-color: rgb(0, 51, 85);
            width: 100px;
            border-radius: 5px;
            color: white;
        }
    </style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar"><h1>공지사항</h1>
        <div class="info">
            <div class="title"><h3>제목</h3>
            </div>
            <p class="titleValue">${ n.title }</p>
            <div class="create"><h3>등록일</h3></div>
            <p class="createValue">${ n.createDate }</p>
        </div>
        <textarea readonly class="content">${ n.ncontent }</textarea>
        <br>
        <button type="button" class="uBtn">수정</button>
        <button type="button" class="Btn">목록으로</button>
        <button type="button" class="dBtn">삭제</button>
    </div>
    <script>
    	$(".uBtn").on("click", function(){
    		location.href="${ contextPath }/admin/noticeUpdate?nid=${ n.nid }&page=${ param.page }";
    	});
    	
    	$(".dBtn").on("click", function(){
    		if(confirm("정말 삭제하시겠습니까?")){
    		location.href="${ contextPath }/admin/noticedelete?nid=${ n.nid }";
    		} else {
    			return;
    		}
    	});
    	
    	$(".Btn").on("click", function(){
    		location.href="${ contextPath }/admin/notice?page=${ param.page }";
    	});
    </script>
</body>
</html>