<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	* {
		box-sizing: border-box;
	}
	
	div {
		border: 1px solid transparent;
		display: block;
	}
	.content {
		width:500px;
		margin : auto;
	}
	
	h1 {
		text-align:center;
		color : rgb(52, 73, 94) !important;
	}
	
	#writeForm {
		width : 500px;
		margin:auto;
	} 
	
	textarea {
		width : 420px;
		height : 200px;
		padding : 10px 10px 14px 10px;
		border: solid 1px #dadada;
	}
	.tableArea{
	border: 3px solid lightgray;
	margin: auto;
	min-height: 350px;
	width: 500px;
	min-width: 560px;
	padding: 5px;
}

#updateTable {
	border-bottom: 1px solid lightgray;
	text-align: center;
	width: 100%;
	min-height: 300px;
	line-height: 2.5;
	border-collapse: collapse;
}

#updateTable tr:not(:last-child) {
	border-bottom: 1px solid lightgray;
}


textarea {
	width: 100%;
	height: 200px;
	padding: 10px 10px 14px 10px;
	border: solid 1px #dadada;
}

.btnArea{
	text-align : center;
}

.btn {
	text-align : center;
	color : white;
	background : rgb(52, 73, 94);
}
	
	
</style>
<title>Q&A 수정</title>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<jsp:include page="../common/sidebar.jsp" />
	<div class="content">
		<h1 align="center">Q&A 수정</h1>
		<form action="${ contextPath }/qna/update" id="writeForm" method="post" enctype="multipart/form-data">
		<div class="tableArea">	
			<table id="updateTable">
				<tr>
					<td style="background : rgb(52, 73, 94); color : white; width : 70px;">작성자</td>
					<td>${ loginUser.aid }</td>
				</tr>
				<tr>
					<td colspan="2" style="background : rgb(52, 73, 94); color : white;">제목</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="qtitle" maxlength="30" value="${ qna.qtitle }" required style="width : 100%;"></td>
				</tr>
				<tr>
					<td colspan="2" style="background : rgb(52, 73, 94); color : white;">내용</td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="qcontent" style="resize:none;" required>${ qna.qcontent }</textarea></td>
				</tr>
			
			</table>
			<input type="hidden" name="qid" value="${ qna.qid }"/>
			<div class="btnArea">
				<button class="btn">수정하기</button>
				<input type="button" class="btn" onclick="location.href='${ contextPath }/qna/list?page=${ param.page }'" value="취소하기">
			</div>
		</div>
		</form>
	</div>
</body>
</html>



