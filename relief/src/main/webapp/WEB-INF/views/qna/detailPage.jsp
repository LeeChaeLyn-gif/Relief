<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	box-sizing: border-box;
}

div {
	border: 1px solid transparent;
	display: block;
}

.content h1 {
	padding-top: 50px;
	text-align: center;
}

.tableArea {
	margin-top: 100px;
	border: 3px solid lightgray;
	margin: auto;
	min-height: 350px;
	width: 600px;
	min-width: 560px;
	padding: 5px;
}

.btnArea {
	text-align : center;
}

.btn {
	color : white;
	background : rgb(52, 73, 94);
}

h1, h3 {
	color : rgb(52, 73, 94) !important;
}

#boardTable {
	border-bottom: 1px solid lightgray;
	text-align: center;
	width: 100%;
	min-width: 550px;
	min-height: 300px;
	line-height: 2.5;
	border-collapse: collapse;
}

#boardTable tr:not(:last-child) {
	border-bottom: 1px solid lightgray;
}

#boardTable tr:last-child {
	height: 200px;
}

#boardTable pre {
	min-height: 200px;
	text-align: left;
	overflow: auto;
}

#boardTable td:nth-child(1) {
	width: 50px;
}

#boardTable td:nth-child(2) {
	width: 50px;
}

#boardTable td:nth-child(3) {
	width: 100px;
}

#boardTable td:nth-child(4) {
	width: 200px;
}

#boardTable td:nth-child(5) {
	width: 100px;
}

#boardTable td:nth-child(5) {
	width: 150px;
}

/* 댓글 영역 */
.outer {
	width: 600px;
	margin: auto;
	text-align: center;
}

.replySelectArea {
	width: 600px;
	min-height : 100px;
	margin: auto;
	margin-bottom : 50px;
	border: 3px solid lightgray;
}

#replyTable {
	text-align: center;
	width: 100%;
	line-height: 2.5;
	border-collapse: collapse;
	border-bottom: 1px solid lightgray;
}

#replyTable td:nth-child(1), #replyTable td:nth-child(3) {
	width: 100px;
}

#replyTable tr:not(:last-child) {
	border-bottom: 1px solid lightgray;
}

.replyWriterArea {
	text-align: center;
	padding-top: 50px;
	border-bottom: 1px solid lightgray;
	
}

.replyWriterArea textarea {
	width: 600px;
	height: 100px;
	padding: 10px 10px 14px 10px;
	border: solid 1px #dadada;
	resize: none;
}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<jsp:include page="../common/sidebar.jsp" />
	<div class="content">
		<h1>Q&A</h1>
		<div class="tableArea">
			<table id="boardTable">
				<tr>
					<td style="background : rgb(52, 73, 94); color : white;">번호</td>
					<td>${ qna.qid }</td>
					<td style="background : rgb(52, 73, 94); color : white;">작성자</td>
					<td>${ qna.aid }</td>
				</tr>
				<tr>
					<td style="background : rgb(52, 73, 94); color : white;">제목</td>
					<td colspan="5">${ qna.qtitle }</td>
				</tr>
				<tr>
					<td colspan="5" style="background : rgb(52, 73, 94); color : white;">내용</td>
				</tr>
				<tr>
					<td colspan="5">
					<pre style="font-size : 15px;">${ qna.qcontent }</pre>
					</td>
				</tr>
			</table>
			
		<div class="btnArea">
			<button class="btn"
				onclick="location.href='${ contextPath }/qna/list?page=${ param.page }'">목록으로</button>
			<c:if test="${ loginUser.aid eq qna.aid && qna.astatus == 'Y'}">
				<button class="btn"
					onclick="alert('답변이 있는 글은 삭제할 수 없습니다.')">수정하기</button>
				<button class="btn" onclick="checkDelete()">삭제하기</button>
			</c:if>
			<c:if test="${ loginUser.aid eq qna.aid && qna.astatus == 'N'}">
				<button class="btn"
					onclick="location.href='${ contextPath }/qna/updatePage?qid=${ qna.qid }&page=${ param.page }'">수정하기</button>
				<button class="btn" onclick="checkDelete()">삭제하기</button>
			</c:if>
		</div>
			
		</div>

	</div>
	<script>
		function checkDelete() {
			if (confirm("정말 삭제하시겠습니까?")) {
				location.href = '${ contextPath }/qna/delete?qid=${ qna.qid }'
			}
		}
	</script>

	<div class="content">
		<div class="outer">
			<br>
			<hr>
			<br>
			<h3>답변</h3>
			<div class="replySelectArea">
				<table id="replyTable">
						<c:if test="${ qna.astatus =='Y' }">
						<tr>
							<td style="background : rgb(52, 73, 94); color : white;">제목</td>
							<td>${ qna.atitle }</td>
						</tr>
							<tr>
								<td colspan="2" style="background : rgb(52, 73, 94); color : white;">내용</td>
								
							</tr>
							<tr>
								<td colspan="2">${ qna.acontent }</td>
							</tr>
						</c:if>
						<c:if test="${ qna.astatus == 'N' }">
							<tr>
								<td style="background : rgb(52, 73, 94); color : white;">제목</td>
								<td></td>
							</tr>
							<tr>
								<td colspan="2" style="background : rgb(52, 73, 94); color : white;">내용</td>
								
							</tr>
							<tr>
								<td colspan="2">작성 된 답변이 없습니다.</td>
							</tr>
						</c:if>
				</table>
			</div>
		</div>
	</div>

	<script>
		$("#addReply").on("click", function() {
			var rcontent = $("#replyContent").val();
			var refQid = $
			{
				qna.qid
			}
			;

			$.ajax({
				url : "${ contextPath }/qna/insertReply",
				data : {
					rcontent : rcontent,
					refQid : refQid
				},
				type : "post",
				dataType : "json",
				success : function(data) {
					console.log(data);

					tableBody = $("#replyTable tbody");
					tableBody.html("");

					for ( var i in data) {
						tr = $("<tr>");
						rwriter = $("<td width='100'>").text(data[i].aid);
						rcontent = $("<td>").text(data[i].acontent);

						tr.append(rwriter, rcontent);
						tableBody.append(tr);
					}

					$("#replyContent").val("");
				}
			});
		});
	</script>
</body>
</html>