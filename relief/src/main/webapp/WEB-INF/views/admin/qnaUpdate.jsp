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
        width: 800px;
        height : 300px;
    }
    .qna h1{
        background-color: white;
        color: black;
        margin: 0 auto;
    }
    .qna h5{
        background-color: white;
        color: black;
        margin: 0 auto;
    }
    .Btn{
        background-color: #597a96;
        width: 100px;
        height: 50px;
        border-radius: 5px;
        color: white;
    }
    .btnArea{
    	text-align : center;
    	width: 800px;
    }
    input[name=atitle]{
    	height : 40px;
    	width : 800px;
    	margin : 0 auto;
    }
    .insert{
    	height : 400px;
    	width: 800px;
    }
    .content{
            width: 700px;
            height: 300px;
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
	        <div class="insert">
	        		<input type="hidden" value="${ q.qid }" name="qid">
	        		<div class="form-group ">
		            <input type="text" class="form-control" name="atitle" value="${ q.atitle }" placeholder="제목을 입력해주세요.">       		
	        		</div>
	        		<div class="form-group">
		            <textarea style="resize: none; width:100%;" class="content" name="acontent">
			            	${ q.acontent }
		            </textarea>
	        		</div>
		        <div class="btnArea">
					<button type="button" class="Btn" onclick="location.href='${ contextPath }/admin/qna'">뒤로가기</button>
					<button type="submit" class="Btn" onclick="removeHTML()">수정</button>
				</div>  
	        </div>
        </form>
    </div>
    <br><br><br><br><br><br>
    <script>
    
    </script>
</body>
</html>