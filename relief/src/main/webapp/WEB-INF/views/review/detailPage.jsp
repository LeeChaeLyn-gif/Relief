<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
	
	#files{
		width : 100%;
	}
	
	#cotent{
		height : 200px;
	}
	.BmarginSize {
		margin-bottom : 50px;
	}
	.TmarginSize {
		margin-top : 50px;
	}
	.RmarginSize {
		margin-right : 20px;
	}
	
	.starR{
	  background: url('${ contextPath }/resources/images/star.jpg') no-repeat right 0;
	  background-size: auto 100%;
	  width: 30px;
	  height: 30px;
	  display: inline-block;
	  text-indent: -9999px;
	  cursor: pointer;
	  
	}
	.starR.on{background-position:0 0;}
	
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
	<br><br><br><br><br><br><br><br><br>
	
<div id="wrap">
	<h1 class="text-center TmarginSize">리뷰 상세</h1>
	<hr class="BmarginSize">
	
	<!-- r.review_id 값 넘겨주기 -->
	<input type="hidden" value="${r.review_id}" name="review_id" disabled>
	
	<div class="starRev" style="margin-bottom : 15px">
	별점&nbsp;
	<c:forEach var="i" begin="1" end="5">
		<c:choose>
			<c:when test="${ i <= r.star}">
				<span class="starR on">${i}</span>
			</c:when>
			<c:otherwise>
				<span class="starR">${i}</span>
			</c:otherwise>
		</c:choose>
	</c:forEach>	
		
	  <!-- star 값 넘겨주기 -->
	  <input id="star" type="hidden" value="0" name="star">
	  
	</div>
	
	<div class="mb-3">
	  <label for="title" class="form-label">제목</label>
	  <input type="text" class="form-control" id="title" placeholder="제목 입력" name="title" value="${r.title}" readonly>
	</div>
	
	<div class="mb-3">
	  <label for="content" class="form-label">내용</label>
	  <textarea class="form-control" id="cotent" rows="3" style="resize: none;" name="content" readonly>${r.content}</textarea>
	</div>

	<div class="text-right">
		<button type="button" class="btn btn-color RmarginSize" onclick="window.history.back()">뒤로가기</button>
		
		<!-- 본인 일때만 수정 버튼 보이기 -->
		<c:if test="${ loginUser.aid == r.consumer_id }">
			<button type="button" class="btn btn-color" onclick="deleteBtn(${ r.review_id  })">삭제</button>
			<button type="button" class="btn btn-color" onclick="location.href='${ contextPath }/review/modify?review_id=${ r.review_id  }'">수정</button>
		</c:if>
		
	</div>
</div>
	<script>
	function deleteBtn(review_id){
		if(confirm("삭제 하시겠습니까?")) {
			location.href = '${ contextPath }/review/delete?review_id=' + review_id +'&pageNum=' + 0 ;
		}
	}
	</script>

</body>
</html>