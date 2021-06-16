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
	
	.table td, .table th{
		text-align : center;
	}
	
	.marginTop {
		margin-top : 50px;
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
		<h2 class="text-center marginTop">Notice</h2>
		<hr>
		<!-- 게시글 테이블 -->
		<div style="width:100%;">
		  <table class="table">
			  <thead>
			    <tr>
			      <th scope="col" width="10%;">글번호</th>
			      <th scope="col" width="65%;">제목</th>
			      <th scope="col" width="15%;">작성일</th>
			      <th scope="col" width="10%;">FILE</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach items="${ list }" var="n">
				<tr onclick="selectNotice(${ n.notice_id });">
					<td>${ n.notice_id}</td>
					<td>${ n.title }</td>
					<td>${ n.create_date }</td>
					<td>
					<c:if test="${ !empty n.fileName }">
					<img src="${ contextPath }/resources/images/file.png" width="30">
					</c:if>
					</td>
				</tr>
				</c:forEach>
			    
			    
			    <!-- 페이징 바 구간 -->
				<tr>
					<td colspan="4" style='padding-top: 50px;'>
					<!-- [이전] -->
					<c:if test="${ pi.currentPage <= 1 }">
						<button type="button" class="btn btn-secondary">이전</button>
					</c:if>
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="/notice/list">
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
							<c:url var="pagination" value="/notice/list">
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
						<c:url var="after" value="/notice/list">
							<c:param name="page" value="${ pi.currentPage + 1 }"/>
						</c:url>
						<a href="${ after }"><button type="button" class="btn btn-secondary">다음</button></a>
					</c:if>
					</td>
				</tr>
			    
			    
			  </tbody>
		  </table>
		</div>
		
		<!-- 작성버튼 
		<div class="text-right marginTop">
			<button id="insertBts" type="button" class="btn btn-color">작성</button>
		</div>
		-->
		
		<script>
		$(function(){
			$("#insertBts").on('click', function(){
				location.href="/notice/write";
			});
		});
		</script>
	
		<script>
		function selectNotice(notice_id){
			location.href = '${contextPath}/notice/detail?notice_id=' + notice_id + '&page=${ pi.currentPage }';	
			// => 상세 페이지 접근 시 기존 page 값도 파라미터로 전달
		}
		</script>
		
</body>
</html>