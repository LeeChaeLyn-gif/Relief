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
        .info{
            border: 2px solid lightgray;
            margin-left : 100px;
        	width : 70%;
        }
        .title1{
            background-color: #597a96;
            border-radius: 5px;
            display: inline-block;
            width : 10%;
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
        .content{
            resize: none;
            height: 500px;
            width: 53%;
            padding: 0px;
            margin-left : 40px;
        }
        .uBtn{
            background-color: #597a96;
            width: 100px;
            border-radius: 5px;
            color: white;
        }
        .dBtn{
            background-color: #597a96;
            width: 100px;
            border-radius: 5px;
            color: white;
        }
        .Btn{
        	background-color: #597a96;
            width: 100px;
            border-radius: 5px;
            color: white;
        }
        .btnArea{
        	width : 91%;
        	text-align : center;
        }
    </style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar">
	<div class="title">
	<h1>공지사항</h1>	
	</div>
        <div class="info">
            <div class="title1"><h3>제목</h3>
            </div>
            <p class="titleValue">${ n.title }</p>
            <div class="create"><h3>등록일</h3></div>
            <p class="createValue">${ n.createDate }</p>
        </div>
        <textarea readonly class="content">${ n.ncontent }</textarea>
        <br>
        <div class="btnArea">
	        <button type="button" class="uBtn">수정</button>
	        <button type="button" class="Btn">목록으로</button>
	        <button type="button" class="dBtn">삭제</button>
        </div>
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