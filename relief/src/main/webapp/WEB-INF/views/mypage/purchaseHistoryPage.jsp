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
	
	.marginTop{
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
	<jsp:include page="listNavPage.jsp"/>
	 
	<div id="wrap">
		<h2 class="text-center paddingtop">구매 내역</h2>	
		<hr>
		<div>
			<table class="table text-center">
			  <thead>
			    <tr>
			      <th scope="col">사진</th>
			      <th scope="col">상품명</th>
			      <th scope="col">가격</th>
			      <th scope="col">판매자</th>
			      <th scope="col">구매일</th>
			      <th scope="col">리뷰</th>
			      <th scope="col">기능</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach items="${ list }" var="t">
			  	<input type="hidden" value="${t.board_id}">
				<tr class="tdClick">
					<td><img src="${ contextPath }/resources/buploadFiles/${ t.rename_fileName }" width="150"/></td>
					<td>${ t.title }</td>
					<td>${ t.price }</td>
					<td>${ t.seller_id }</td>
					<td>${ t.t_date }</td>
					
					<td>
				    	<div>
				    	<c:if test="${t.status == 'Y' and t.r_status == 'N'}">
				    		<button type="button" class="btn btn-color" onclick="reviewWrite('${t.t_history_id}');">작성</button>
				    	</c:if>
				    	<c:if test="${t.status == 'Y' and t.r_status == 'Y'}">
				    		<button type="button" class="btn btn-color" onclick="reviewDetail('${t.t_history_id}');">보기</button>
				    	</c:if>
				    	</div>
			    	</td>
			    	
					<td>
					<button type="button" class="btn btn-color" onclick="deleteBtn('${ t.t_history_id}');">삭제</button>
					</td>
					
					
				</tr>
				
			    </c:forEach>
			    
			    
			    <!-- 페이징 바 구간 -->
				<tr>
					<td colspan="7" style='padding-top: 50px;'>
					<!-- [이전] -->
					<c:if test="${ pi.currentPage <= 1 }">
						<button type="button" class="btn btn-secondary">이전</button>
					</c:if>
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="/mypage/purchaseHistory">
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
							<c:url var="pagination" value="/mypage/purchaseHistory">
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
						<c:url var="after" value="/mypage/purchaseHistory">
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
		$(function(){
			$(".tdClick td:nth-child(-n+5)").on("click", function(board_id){
				var bid = $(this).parent().prev().val();
				selectBoard(bid);
			})
		})
	</script>
	<script type="text/javascript">
		function selectBoard(board_id){
			location.href = '${contextPath}/board/detail?board_id=' + board_id;	
		}
		
		function deleteBtn(t_history_id){
			if(confirm("삭제 하시겠습니까?")) {
				location.href = '${contextPath}/mypage/deleteT_History?t_history_id=' + t_history_id +'&pageNum=' + 0 ;
			}
		}
		
		function reviewWrite(t_history_id){
			location.href = '${contextPath}/review/write?t_history_id=' + t_history_id;
				
		}
		
		function reviewDetail(t_history_id){
			location.href = '${contextPath}/review/detail?t_history_id=' + t_history_id;
				
		}
		
	</script>
	
	
</body>
</html>