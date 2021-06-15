<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA listPage</title>
<style>
* {
	box-sizing: border-box;
}

div {
	border: 1px solid transparent;
	display: block;
}

h1, h4 {
	color : rgb(52, 73, 94) !important;
}
#listTable tr:nth-child(1):hover { background-color: white; }
#listTable tr:last-child:hover { background-color: white; }
#listTable tr:hover { background-color: rgb(183, 204, 216); }

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

   .content-h {
      background : white;
      width:750px;
      min-height: 800px;
      margin: auto;
      position:relative;
   }
   
   .content-h h1 {
      text-align:center;
   }
   
   .tableArea {
      border: 3px solid #f3f5f7;
      margin: auto;
      width : 750px;
      padding : 5px;
   }
   
   .btnArea {
   	text-align : center;
   }
   
   .btn {
   		background : rgb(52, 73, 94);
   		color : white;
   }
   
   #listTable{
      text-align:center;
      width : 730px;
      line-height : 2.5;
      border-collapse : collapse;
   }
   
   #listTable tr:not(:last-child) {
      border-bottom : 1px solid #f3f5f7;
   }
   
   #listTable td {
      cursor : pointer;
   }
   
   #listTable th {
      text-align:center;
   }
   
   #listTable th:nth-child(1) {
      width : 50px;
   }
   
   #listTable th:nth-child(2) {
      width : 100px;
   }
   
   #listTable th:nth-child(3) {
      width : 500px;
   }
   
   #listTable th:nth-child(4) {
      width : 100px;
   }

</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<jsp:include page="../common/sidebar.jsp"/>
	<div class="part1"></div>
	<div class="part2">
	<div class="content-h">
		<h1 align="center">Q&A</h1><hr>
		<h4 align="center">총 Q&A 글 : ${ pi.listCount }</h4>
		<div class="tableArea">
			<table id="listTable">
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>답변여부</th>
				</tr>
				<c:forEach items="${ qlist }" var="q">
				<tr onclick="selectQlist(${ q.qid});">
					<td>${ q.qid }</td>
					<td>${ q.aid }</td>
					<td>${ q.qtitle }</td>
					<td>${ q.astatus }</td>
				</tr>
				</c:forEach>
				<tr>
					<td colspan="6">
					<c:if test="${ pi.currentPage <= 1 }">
						[이전] &nbsp;
					</c:if>
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="/qna/list">
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
						</c:url>
						<a href="${ before }">[이전]</a> &nbsp;
					</c:if>
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:if test="${ p eq pi.currentPage }">
							<font color="rgb(52, 73, 94);" size="4"><b>[ ${ p } ]</b></font> &nbsp;
						</c:if>
						<c:if test="${ p ne pi.currentPage }">
							<c:url var="pagination" value="/qna/list">
								<c:param name="page" value="${ p }"/>
							</c:url>
							<a href="${ pagination }">${ p }</a> &nbsp;
						</c:if>
					</c:forEach>
					<c:if test="${ pi.currentPage >= pi.maxPage }">
						[다음]
					</c:if>
					<c:if test="${ pi.currentPage < pi.maxPage }">
						<c:url var="after" value="/qna/list">
							<c:param name="page" value="${ pi.currentPage + 1 }"/>
						</c:url>
						<a href="${ after }">[다음]</a>
					</c:if>
					</td>
				</tr>
			</table>
		<c:if test="${ !empty loginUser }">
		<div class="btnArea">
			<button class="btn" onclick="location.href='${ contextPath }/qna/write'">글쓰기</button>
		</div>
		</c:if>
		</div>
		
	</div>
	
	<script>
		function selectQlist(qid){
			location.href = '${ contextPath }/qna/detail?qid=' + qid + '&page=${ pi.currentPage }';
		}
	</script>
	</div>
	<div class="part3"></div>
</body>
</html>