<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        width: 700px;
        padding: 0px;
        margin-left: 750px;
        border : 1px solid lightgray;
    }
    .ban{
		margin-left : 400px;
        height: 30px;
        width: 100px;
        border-radius: 5px;

    }
    .dBtn{
        background-color: rgb(0, 51, 85);
        height: 30px;
        width: 100px;
        border-radius: 5px;
        color: white;
    }
    .btn{
    	background-color: rgb(0, 51, 85);
        width: 140px;
        height : 50px;
        border-radius: 5px;
        color : white;
        margin-left : 300px;
    }
    .mainbar{
    	text-align : center;
    }
    h5{
    	text-align : center;
    	margin-left : 300px;
    }
	.textareaDiv{
		height: 500px;
        width: 700px;
        padding: 0px;
        margin-left: 750px;
	}
</style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	
	<div class="mainbar"><h1>신고</h1>
        <div class="info">
            <div class="create"><h3>등록일</h3></div>
            <p class="createValue">${ r.reportDate }</p>
            <div class="create"><h3>게시자</h3></div>
            <p class="createValue">${ r.aid }</p>
            <div class="create"><h3>피신고자</h3></div>
            <p class="createValue">${ r.aid2 }</p>
            <div class="create"><h3>분류</h3></div>
            <c:choose>
            	<c:when test="${ r.chid != 0 }">
            		<p class="createValue">채팅<input type="hidden" value="${ r.chid }"></p>
            	</c:when>
            	<c:when test="${ r.bid != 0 }">
            		<p class="createValue">게시글<input type="hidden" value="${ r.bid }"></p>
            	</c:when>
            	<c:when test="${ r.cmid != 0 }">
            		<p class="createValue">댓글<input type="hidden" value="${ r.cmid }"></p>
            	</c:when>
            </c:choose>
        </div>
        <p class="content">${ r.reportReason }</p>
        <br>
        <button type="button" class="btn">해당 페이지로 가기</button>
        <form method="post" action="${ contextPath }/admin/ban">
        	<h5>제재 사유</h5>
        	<div class="textareaDiv">
	        <textarea rows="7" cols="20" class="summernote" id="summernote" name="sanctionsReason"></textarea>
	        </div>
	        <select name="ban" id="ban" class="ban">
	            <option value="0">정지없음</option>
	            <option value="7">7일정지</option>
	            <option value="15">15일정지</option>
	            <option value="100">영구정지</option>
	        </select>
	        <input type="hidden" value="${ r.aid2 }" name="aid">
	        <input type="hidden" value="${ r.rpid }" name="rpid">
	        <button type="submit" class="dBtn">제재하기</button>
        </form>
    </div>
    <c:choose>
    	<c:when test="${ r.chid != 0 }">
    		<script>
    			$(function(){
    				$(".btn").on("click", function(){
    					location.href="${ contextPath }/chat/detail?chid=${ r.chid }";
    				});
    			})
    		</script>
    	</c:when>
    	<c:when test="${ r.bid != 0 }">
    		<script>
    			$(function(){
    				$(".btn").on("click", function(){
    					location.href="${ contextPath }/board/detail?bid=${ r.bid }";
    				});
    			})
    		</script>
    	</c:when>
    	<c:otherwise>
    		<script>
    			$(function(){
    				$(".btn").on("click", function(){
    					location.href="${ contextPath }/admin/commentDetail?cmid=${ r.cmid }";
    				});
    			})
    		</script>
    	</c:otherwise>
    </c:choose>
	
	<script>
	$('#summernote').summernote({
    	placeholder: '제제사유를 입력해주세요.', 
    	tabsize: 2,
    	minHeight: null,
    	maxHeight: null,
    	lang : 'ko-KR',
    	height: 370 });
	
	function removeHTML(){
		var str = $(".summernote").val();
		str = str.replace(/(<([^>]+)>)/ig,"");
		$(".summernote").val(str);
	}
	</script>
</body>
</html>