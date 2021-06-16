<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    .ban{
		margin-left : 45%;
        height: 30px;
        width: 120px;
        border-radius: 5px;

    }
    .dBtn{
        background-color: #597a96;
        height: 30px;
        width: 100px;
        border-radius: 5px;
        color: white;
        text-align : center;
    }
    h5{
    	text-align : center;
    }
	.textareaDiv{
		height: 500px;
        width: 700px;
        padding: 0px;
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
	<h2>신고</h2>	
	</div>
        <div class="info">
            <div class="create"><h3>등록일</h3></div>
            <p class="createValue">${ r.reportDate }</p>
            <div class="create"><h3>게시자</h3></div>
            <p class="createValue">${ r.aid }</p>
            <div class="create"><h3>신고대상</h3></div>
            <p class="createValue">${ r.aid2 }</p>
            <div class="create"><h3>분류</h3></div>
            <c:choose>
            	<c:when test="${ r.chid != 0 }">
            		<p class="createValue">채팅<input type="hidden" value="${ r.chid }"></p>
            	</c:when>
            	<c:when test="${ r.bid != 0 }">
            		<p class="createValue">게시글<input type="hidden" value="${ r.bid }"></p>
            	</c:when>
            	<c:when test="${ r.rid != 0 }">
            		<p class="createValue">댓글<input type="hidden" value="${ r.rid }"></p>
            	</c:when>
            </c:choose>
        </div>
        <p class="content">${ r.reportReason }</p>
        <br>
        <button type="button" class="btn1">해당 페이지로 가기</button>
        <form method="post" action="${ contextPath }/admin/ban" onsubmit="removeHTML()">
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
    				$(".btn1").on("click", function(){
    					var _width = '650';
    				    var _height = '380';
    					var _left = Math.ceil(( window.screen.width - _width ));
    					var _top = Math.ceil(( window.screen.height - _height )/2);
    					
    					window.open("${contextPath}/selectChat?chatId=${ r.chid }", "", "width=550, height=600, left=" + _left + ", top=" + _top);
    				});
    			})
    		</script>
    	</c:when>
    	<c:when test="${ r.bid != 0 }">
    		<script>
    			$(function(){
    				$(".btn1").on("click", function(){
    					location.href="${ contextPath }/board/detail?board_id=${ r.bid }";
    				});
    			})
    		</script>
    	</c:when>
    	<c:otherwise>
    		<script>
    			$(function(){
    				$(".btn1").on("click", function(){
    					location.href="${ contextPath }/admin/commentDetail?rid=${ r.rid }";
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