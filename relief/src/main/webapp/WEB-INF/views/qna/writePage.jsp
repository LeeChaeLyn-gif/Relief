<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA 등록</title>
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

.content h1 {
	padding-top: 50px;
	text-align: center;
}

#writeForm {
	width: 600px;
	margin: auto;
	padding: 50px 80px;
}

textarea {
	width: 420px;
	height: 200px;
	padding: 10px 10px 14px 10px;
	border: solid 1px #dadada;
}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<div class="part1"></div>
	<div class="part2">
		<div class="content">
			<h1 align="center">Q&A 등록</h1>
			<form action="${ contextPath }/qna/insert" id="writeForm"
				method="post" enctype="multipart/form-data">

				<h4>작성자</h4>
				<span class="input_area"><input type="text" name="bwriter"
					value="${ loginUser.aid }" readonly></span>
				<h4>Q&A 질문 제목</h4>
				<span class="input_area"><input type="text" name="btitle"
					maxlength="30" required></span>
				<h4>질문 내용</h4>
				<textarea name="bcontent" style="resize: none;" required></textarea>
				<div class="btnArea">
					<button class="btn">등록하기</button>
				</div>

			</form>
		</div>
	</div>
	<div class="part3"></div>
</body>
</html>