<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   .content h1 {
      padding-top : 50px;
      text-align:center;
   }
   
   .tableArea {
      margin-top:100px;
      border: 3px solid #f3f5f7;
      margin: auto;
      height : 580px;
      width : 80%;
      min-width : 560px;
      padding : 5px;
   }
   
   #boardTable{
       text-align:center;
       width : 100%;
      min-width : 550px;
      line-height : 2.5;
      border-collapse : collapse;
   }
   
   #boardTable tr:not(:last-child)
    {
      border-bottom : 1px solid #f3f5f7;
   }
   
   #boardTable tr:last-child {
      height : 400px;
   }
   
   #boardTable pre {
      height : 400px;
      text-align:left;
      overflow:auto;
   }
   
   #boardTable td:nth-child(1) {
      width : 50px;
   }
   
   #boardTable td:nth-child(2) {
      width : 50px;
   }
   
   #boardTable td:nth-child(3) {
      width : 100px;
   }
   
   #boardTable td:nth-child(4) {
      width : 200px;
   }
   
   #boardTable td:nth-child(5) {
      width : 100px;
   }
   
   #boardTable td:nth-child(5) {
      width : 150px;
   }
   
      /* 댓글 영역 */
   .outer {
      width : 700px;
      margin:auto;
   }
   
   .replySelectArea {
      width : 600px;
      margin:auto;
   }
   
   #replyTable {
   text-align: center;
    min-width: 550px;
    line-height: 2.5;
    border-collapse: collapse;
   }
   
   #replyTable td:nth-child(1),
   #replyTable td:nth-child(3) {
      width : 100px;
   } 
   .replyWriterArea {
       text-align:center;
       padding-top : 50px;
   }
   
   .replyWriterArea textarea {
      width : 600px;
      height : 100px;
      padding : 10px 10px 14px 10px;
      border: solid 1px #dadada;
      resize:none;
   }
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<div class="content">
		<h1>Q&A</h1>
		<div class="tableArea">
			<table id="boardTable">
				<tr>
					<td>번호</td>
					<td>${ qna.qid }</td>
					<td>작성자</td>
					<td>${ qna.aid }</td>
					<td>제목</td>
					<td>${ qna.qtitle }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="5">${ qna.qtitle }</td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="5"><pre>${ qna.qcontent }</pre></td>
				</tr>
			</table>
		</div>
		
		<div class="btnArea">
			<button class="btn" onclick="location.href='${ contextPath }/board/list?page=${ param.page }'">목록으로</button>
			<c:if test="${ loginUser.aid eq qna.aid }">
			<button class="btn" onclick="location.href='${ contextPath }/board/updatePage?bid=${ board.bid }&page=${ param.page }'">수정하기</button>
			<button class="btn" onclick="location.href='${ contextPath }/board/delete?bid=${ board.bid }'">삭제하기</button>
			</c:if>
		</div>
	</div>
	
	<div class="content">
		<div class="outer">
			<div class="replyWriterArea">
				<h4>댓글 작성</h4>
				<textarea id="replyContent"></textarea>
				<br>
				<button class="btn" id="addReply">댓글 등록</button>
			</div>
			<br><hr><br>
			<div class="replySelectArea">
				<table id="replyTable">
					<thead>
						<tr>
							<th>제목</th>
							<th>내용</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${ !empty rlist }">
						<c:forEach items="${ rlist }" var="r">
						<tr>
							<td>${ r.atitle }</td>
							<td>${ r.acontent }</td>
						</tr>
						</c:forEach>
					</c:if>
					<c:if test="${ empty rlist }">
					<tr>
						<td colspan="3">작성 된 댓글이 없습니다.</td>
					</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<script>
		$("#addReply").on("click", function(){
			var rcontent = $("#replyContent").val();
			var refBid = ${ board.bid};
			
			$.ajax({
				url : "${ contextPath }/board/insertReply",
				data : { rcontent : rcontent, refBid : refBid },
				type : "post",
				dataType : "json",
				success : function(data){
					console.log(data); // 해당 게시글에 작성 된 댓글 리스트 받아오기
					
					// -> <tbody> 안에 data의 댓글 리스트를 형식에 맞게 세팅
					tableBody = $("#replyTable tbody");
					tableBody.html("");
					
					for(var i in data){
						tr = $("<tr>");
						rwriter = $("<td width='100'>").text(data[i].rwriter);
						rcontent = $("<td>").text(data[i].rcontent);
						rcreateDate = $("<td width='100'>").text(data[i].rcreateDate);
						
						tr.append(rwriter, rcontent, rcreateDate);
						tableBody.append(tr);
					}
					
					// -> 댓글 작성 <textarea> 비워주기
					$("#replyContent").val("");
				}
			});
		});
	</script>
</body>
</html>