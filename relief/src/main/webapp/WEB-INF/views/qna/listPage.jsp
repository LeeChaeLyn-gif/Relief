<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.part1 {
	width: 10%;
	height: 100%;
	float: left;
}

.part2 {
	width: 80%;
	height: 100%;
	float: left;
}

.part3 {
	width: 10%;
	height: 100%;
	float: left;
}
</style>
</head>
<body>
	<div class="part1"></div>
	<div class="part2">
		<jsp:include page="../common/menubar.jsp"/>
	<div class="content-h">
		<h1 align="center">게시판</h1>
		<h3 align="center">총 게시글 갯수 : ${ pi.listCount }</h3>
		<div class="tableArea">
			<table id="listTable">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>첨부파일</th>
				</tr>
				<c:forEach items="${ list }" var="b">
				<tr onclick="selectBoard(${ b.bid});">
					<td>${ b.bid }</td>
					<td>${ b.btitle }</td>
					<td>${ b.bwriter }</td>
					<td>${ b.bcreateDate }</td>
					<td>${ b.bcount }</td>
					<td>
					<c:if test="${ !empty b.originalFileName }">
					<img src="${ contextPath }/resources/images/fileicon.png" width="30">
					</c:if>
					</td>
				</tr>
				</c:forEach>
				<!-- 페이징 바 구간 -->
				<tr>
					<td colspan="6">
					<!-- [이전] -->
					<c:if test="${ pi.currentPage <= 1 }">
						[이전] &nbsp;
					</c:if>
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="/board/list">
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
						</c:url>
						<a href="${ before }">[이전]</a> &nbsp;
					</c:if>
					<!-- 페이지 숫자 -->
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:if test="${ p eq pi.currentPage }">
							<font color="red" size="4"><b>[ ${ p } ]</b></font> &nbsp;
						</c:if>
						<c:if test="${ p ne pi.currentPage }">
							<c:url var="pagination" value="/board/list">
								<c:param name="page" value="${ p }"/>
							</c:url>
							<a href="${ pagination }">${ p }</a> &nbsp;
						</c:if>
					</c:forEach>
					<!-- [다음] -->
					<c:if test="${ pi.currentPage >= pi.maxPage }">
						[다음]
					</c:if>
					<c:if test="${ pi.currentPage < pi.maxPage }">
						<c:url var="after" value="/board/list">
							<c:param name="page" value="${ pi.currentPage + 1 }"/>
						</c:url>
						<a href="${ after }">[다음]</a>
					</c:if>
					</td>
				</tr>
			</table>
		</div>
		
		<c:if test="${ !empty loginUser }">
		<div class="btnArea">
			<button class="btn" onclick="location.href='${ contextPath }/board/write'">글쓰기</button>
		</div>
		</c:if>
	</div>
	
	<script>
		function selectBoard(bid){
			location.href = '${ contextPath }/board/detail?bid=' + bid + '&page=${ pi.currentPage }';
			// => 상세 페이지 접근 시 기전 page 값도 파라미터로 전달
		}
	</script>
	</div>
	<div class="part3"></div>
</body>
</html>