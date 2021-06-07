<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 4.0ver -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

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
	
</style>
</head>
<body>
	<div id="wrap">
		<h2 class="marginTop text-center">Notice 작성</h2>
		<hr>
		<!-- 제목,내용  -->
		<form action="${ contextPath }/notice/insert" method="post" enctype="multipart/form-data">
		<div>
		  <div class="form-group ">
		    <input type="text" class="form-control" placeholder="제목" name="title">
		  </div>
		  <div class="form-group">
		    <textarea class="form-control" rows="3" placeholder="내용" style="resize: none; width:100%; height: 400px;" name="ncontent"></textarea>
		  </div>
		</div>
		
		<!-- 첨부파일 -->
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" id="fileName" name="uploadFile">
		    <label class="custom-file-label" for="fileName">파일선택</label>
		  </div>
		</div>
		
		<!-- 버튼 -->
		<div class="text-right marginTop">
			<button type="button" class="btn btn-primary btsSize marginLeft" onclick="location.href='${ contextPath }/notice/list?page=${ param.page }'">뒤로가기</button>
			<%-- <c:if test="${ loginUser.id eq 'admin' }"> --%>
			<button type="submit" class="btn btn-primary btsSize marginLeft">작성</button>
			<%-- </c:if> --%>
		</div>
		
		</form>
	</div>
	
	
	<script>
	$(function(){
		$("input[type='file']").on('change', function(){
			$(this).next('.custom-file-label').html(event.target.files[0].name);
		});
	})
	
	
	</script>
</body>
</html>