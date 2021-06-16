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
	
	.textCenter {
		text-align : center;
	}
	.paddingtop {
		padding-top: 50px;
	}
	.tabSize {
		width : 100%;
		height: auto; 
	 
	}
	
	.btsSize {
		width : 70px;
		margin-top : 2px;
	}
	
	.marginTop {
		margin-top : 100px;
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
		<h2 class="text-center paddingtop">판매 내역</h2>	
		<hr>
		<div>
			<table class="table text-center">
			  <thead>
			    <tr>
			      <th scope="col">사진</th>
			      <th scope="col">판매상태</th>
			      <th scope="col">상품명</th>
			      <th scope="col">가격</th>
			      <th scope="col">판매자</th>
			      <th scope="col">등록일</th>
			      <th scope="col">기능</th>
			      
			    </tr>
			  </thead>
			  <tbody>
				  <c:forEach items="${ list }" var="s">
				  <input type="hidden" value="${s.board_id}"/>
					<tr class="tdClick">
						<td><img src="${ contextPath }/resources/buploadFiles/${ s.rename_fileName }" width="150"/></td>
						
						<td>
						<!-- 판매 상태 -->
							<c:if test="${s.status == 'Y'}">
							<select class="custom-select mr-sm-1" width="100px;" disabled>
						        <option value="${s.t_history_id},Y" selected>판매완료</option>
						        <option value="${s.t_history_id},A">거래중</option>
					        </select>
							</c:if>
							<c:if test="${s.status == 'A'}">
							<select class="custom-select mr-sm-1" width="100px;">
						        <option value="${s.t_history_id},Y">판매완료</option>
						        <option value="${s.t_history_id},A" selected>거래중</option>
					        </select>
							</c:if>
						</td>
						
						<td>${ s.title }</td>
						<td>${ s.price }</td>
						<td>${ s.seller_id }</td>
						<td>${ s.modify_date }</td>
						<td>
							<c:if test="${s.status != 'Y'}">
							<div><button type="button" class="btn btn-color btsSize" onclick="upBtn('${s.pull_date}', ${s.board_id});">UP</button></div>
							</c:if>
					      	<div><button type="button" class="btn btn-color btsSize" onclick="updateBtn(${s.board_id});">수정</button></div>
					      	<div><button type="button" class="btn btn-color btsSize" onclick="deleteBtn(${s.t_history_id});">삭제</button></div>
					    </td>
					    
					</tr>
				    </c:forEach>
			    
			     	<!-- 페이징 바 구간 -->
					<tr>
						<td colspan="7" style="padding-top: 50px;">
						<!-- [이전] -->
						<c:if test="${ pi.currentPage <= 1 }">
							<button type="button" class="btn btn-secondary">이전</button>
						</c:if>
						<c:if test="${ pi.currentPage > 1 }">
							<c:url var="before" value="/mypage/hiddenList">
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
								<c:url var="pagination" value="/mypage/hiddenList">
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
							<c:url var="after" value="/mypage/hiddenList">
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
			$(".tdClick td:nth-child(1), .tdClick td:nth-child(n+3):nth-child(-n+6)").on("click", function(){
				/* var bid = $(this).find("input[name=bid]").val(); */
				var bid = $(this).parent().prev().val();
				selectBoard(bid);
			})
			
			$("select").on('change', function(){
				statusUpdate(this.value);
			});
			
			if ('${msg}' != "") {
				var msg = '${msg}';
				alert(msg);
			}
		})
		
	</script>
	<script type="text/javascript">
		function selectBoard(board_id){
			location.href = '${contextPath}/board/detail?board_id=' + board_id;	
		}
		
		function updateBtn(board_id) {
			location.href = '${contextPath}/board/update?board_id=' + board_id;
		}
		
		function deleteBtn(t_history_id){
			if(confirm("삭제 하시겠습니까?")) {
				location.href = '${contextPath}/mypage/deleteT_History?t_history_id=' + t_history_id +'&pageNum=' + 1 ;
			}
				
		}
		
		function upBtn(pull_date, board_id){
			var date = new Date();
			date = getFormatDate(date);
			console.log(date);
			if(date === pull_date) {
				alert("하루에 한 번씩 할 수 있습니다.");
			} else {
				location.href = '${contextPath}/mypage/updatePull_Date?board_id=' + board_id;
				
			}
				
		}
		
		
		// 날짜 포맷 변경
		function getFormatDate(date){
		    var year = date.getFullYear();              //yyyy
		    var month = (1 + date.getMonth());          //M
		    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
		    var day = date.getDate();                   //d
		    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
		    return  year + '/' + month + '/' + day;     // '-' 추가하여 yyyy-mm-dd 형태 생성 가능
		}
		
		function statusUpdate(status){
			location.href = '${contextPath}/mypage/statusUpdate?status=' + status ;	
		}
		
		
		
	</script>
	
</body>
</html>