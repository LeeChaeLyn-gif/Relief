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

	.paddingtop {
		padding-top: 50px;
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
		<h2 class="text-center paddingtop">리뷰 게시판</h2>	
		<hr>
		<div style="width:100%;">
			<table class="table text-center">
			  <thead>
			    <tr>
			      <th scope="col" width="20%" style="text-align:center">별점</th>
			      <th scope="col" width="40%" style="text-align:center">제목</th>
			      <th scope="col" width="20%" style="text-align:center">작성자</th>
			      <th scope="col" width="20%" style="text-align:center">날짜</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach items="${ list }" var="r">
				<tr onclick="selectReview(${r.review_id});">
					<td width="20%">
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
					</td>
					<td>${ r.title }</td>
					<td>${ r.consumer_id}</td>
					<td>${ r.modify_date}</td>
				</tr>
			    </c:forEach>
			    
			    
			    <!-- 페이징 바 구간 -->
				<tr>
					<td colspan="4" style="padding-top: 50px;">
					<!-- [이전] -->
					<c:if test="${ pi.currentPage <= 1 }">
						<button type="button" class="btn btn-secondary">이전</button>
					</c:if>
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="/review/list">
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
						</c:url>
						<a href="${ before }"><button type="button" class="btn btn-secondary">이전</button></a>
					</c:if>
					<!-- 페이지 숫자  -->
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:if test="${ p eq pi.currentPage }">
							<button type="button" class="btn btn-color"><b>${ p }</b></button>
						</c:if>
						<c:if test="${ p ne pi.currentPage }">
							<c:url var="pagination" value="/review/list">
								<c:param name="page" value="${ p }"/>
							</c:url>
							<a href="${ pagination }"><button type="button" class="btn btn-secondary">${ p }</button></a>
						</c:if>
					</c:forEach>
					<!-- [다음] -->
					<c:if test="${ pi.currentPage >= pi.maxPage }">
						<button type="button" class="btn btn-secondary">다음</button>
					</c:if>
					<c:if test="${ pi.currentPage < pi.maxPage }">
						<c:url var="after" value="/review/list">
							<c:param name="page" value="${ pi.currentPage + 1 }"/>
						</c:url>
						<a href="${ after }"><button type="button" class="btn btn-secondary">다음</button></a>
					</c:if>
					</td>
				</tr>
			    
			  </tbody>
			</table>
		</div>
		
	</div>
	
	<script type="text/javascript">
	function selectReview(review_id){
		location.href = '${contextPath}/review/detail?review_id=' + review_id;	
	}
	

	</script>
</body>
</html>