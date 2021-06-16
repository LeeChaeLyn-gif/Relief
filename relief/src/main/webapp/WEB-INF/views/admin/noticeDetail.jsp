<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		.mainbar{
			width : 70%;
			float : left;
		}
		.titleArea{
			width : 700px;
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
            color: rgb(0, 51, 85);
            text-align: center;
        }
        .headDiv2{
            display: inline-block;
            bottom: 30px;
        }
        .info{
        	width : 700px;
        }
        .title1{
            background-color: #597a96;
            width : 80px;
            height : 50px;
            display: inline-block;
        }
        .title1 h3{
            text-align: center;
            color: white;
        }
        .titleValue{
            display: inline-block;
            width : 300px;
            padding-left: 10px;
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
            width : 190px;
            padding-left: 10px;
            display: inline-block;
            font-weight: bolder;
        }
        .content{
            resize: none;
            height: 500px;
            width: 700px;
            padding: 0px;
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
        .textArea{
        	width : 700px;
        }
        .btnArea{
        	width : 700px;
        	text-align : center;
        }
    </style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar">
		<div class="titleArea">
			<h2>공지사항</h2>	
		</div>
        <div class="info">
            <div class="title1"><h3>제목</h3></div>
            <div class="titleValue"><h5>${ n.title }</h5></div>
            <div class="create"><h3>등록일</h3></div>
            <div class="createValue"><h5>${ n.createDate }</h5></div>
        </div>
        <div class="textArea">
        <textarea readonly class="content">${ n.ncontent }</textarea>
        </div>
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