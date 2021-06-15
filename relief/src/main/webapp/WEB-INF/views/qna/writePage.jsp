<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA 등록</title>
<style>
* {
	box-sizing: border-box;
}

div {
	border: 1px solid transparent;
	display: block;
}
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

.content {
	width : 500px;
	margin: auto;
	margin-bottom : 50px;
}

h1 {
	text-align : center;
	color : rgb(52, 73, 94) !important;
}

.tableArea{
	border: 3px solid lightgray;
	margin: auto;
	min-height: 350px;
	width: 500px;
	min-width: 560px;
	padding: 5px;
}

#writeTable {
	border-bottom: 1px solid lightgray;
	text-align: center;
	width: 100%;
	min-height: 300px;
	line-height: 2.5;
	border-collapse: collapse;
}

#writeTable tr:not(:last-child) {
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
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<jsp:include page="../common/sidebar.jsp" />
		<div class="content">
			<h1>Q&A 등록</h1>
			<form action="${ contextPath }/qna/insert" id="writeForm" method="post" enctype="multipart/form-data">
			<div class="tableArea">
				<table id="writeTable">
					<tr>
						<td style="background : rgb(52, 73, 94); color : white; width : 70px;">작성자</td>
						<td>${ loginUser.aid }</td>
					</tr>
					<tr>
						<td colspan="2" style="background : rgb(52, 73, 94); color : white;">Q&A 제목</td>
					</tr>
					<tr>
						<td colspan="2"><input type="text" name="qtitle" maxlength="40" required style="width : 100%;"></td>
					</tr>
					<tr>
						<td colspan="2" style="background : rgb(52, 73, 94); color : white;">내용</td>
					</tr>
					<tr>
						<td colspan="2"><textarea name="qcontent" style="resize: none;" required></textarea></td>
						
					</tr>
				</table>
				<div class="btnArea">
					<button class="btn">등록하기</button>
					<input type="button" class="btn" onclick="location.href='${ contextPath }/qna/list?page=${ param.page }'" value="목록으로">
				</div>
			</div>
			</form>
		</div>
</body>
</html>