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
        width: 50%;
        height : 300px;
        margin-left: 20%;
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
    .btn1{
        background-color: #597a96;
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
    .insert{
    	height : 400px;
    	width: 50%;
        margin-left: 20%;
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
        <form action="${ contextPath }/admin/qnaUpdate" method="post">
	        <div class="insert">
	        		<input type="hidden" value="${ q.qid }" name="qid">
	        		<div class="form-group ">
		            <input type="text" class="form-control" name="atitle" value="${ q.atitle }" placeholder="제목을 입력해주세요.">       		
	        		</div>
	        		<div class="form-group">
		            <textarea id="summernote" class="content" name="acontent">
			            	${ q.acontent }
		            </textarea>
	        		</div>
		        <div class="text-right marginTop">
					<button type="button" class="btn btn-primary btsSize marginLeft" onclick="location.href='${ contextPath }/admin/qna'">뒤로가기</button>
					<button type="submit" class="btn btn-primary btsSize marginLeft" onclick="removeHTML()">수정</button>
				</div>  
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
    
    function removeHTML(){
		var str = $(".content").val();
		str = str.replace(/<br\/>/ig, "\n");
		str = str.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
		$(".content").val(str);
	}
    </script>
</body>
</html>