<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 4.0ver -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" !important>

<!-- Jquery 3.6 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<style type="text/css">
	* {
		box-sizing: border-box;
	}
	
	#wrap {
		width: 1140px;
		heigth : auto;
		
		/* nav를 중앙부로 */
		margin: auto;
	}
	
	.marginTop {
		margin-top : 100px;
	}
	
	.marginLeft {
		margin-left : 20px;
	}
	
	.form-control[readonly] {
    background-color: white;
    }
    
    .btn-color {
		color : #fff;
		background-color : #34495E;
	}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<br><br><br><br><br><br><br><br>
	<div id="wrap">
		<h2 class="marginTop text-center">FAQ 상세</h2>
		<hr>
		<!-- 제목,내용  -->
		<div>
		  <div class="form-group ">
		    <input type="text" class="form-control" placeholder="제목" value="${ faq.title }" readonly>
		  </div>
		  <div class="form-group">
		    <textarea class="form-control" rows="3" placeholder="내용" style="resize: none; width:100%; height: 400px;" readonly style="background-color: white;">${faq.content}</textarea>
		  </div>
		</div>
		
		<!-- 첨부파일 -->
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <c:if test="${ !empty faq.fileName }">
			<a class="btn btn-color" href="${ contextPath }/resources/FAQuploadFiles/${ faq.rename_fileName }" download="${ faq.fileName }">
			${ faq.fileName }</a>
			</c:if>
		  </div>
		</div>
		<!-- 버튼 -->
		<div class="text-right marginTop">
			<button type="button" class="btn btn-color btsSize marginLeft" onclick="location.href='${ contextPath }/faq/list?page=${ param.page }'">뒤로가기</button>
			
			<!-- 
			<button type="button" class="btn btn-color btsSize marginLeft" onclick="location.href='${ contextPath }/faq/updatePage?faq_id=${ faq.faq_id }&page=${ param.page }'">수정</button>
			<button type="button" class="btn btn-color btsSize marginLeft" onclick="location.href='${ contextPath }/faq/delete?faq_id=${ faq.faq_id  }'">삭제</button>
			-->
		</div>
	</div>

</body>
</html>