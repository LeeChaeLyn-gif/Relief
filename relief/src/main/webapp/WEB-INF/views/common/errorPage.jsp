<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Page</title>
<style>
	.error-container {
		text-align: center;
	}
	.error-container img {
		width : 300px;
		margin-top : 100px;
	}
	.error-container h2 {
		color : red;
	}
</style>
</head>
<body>
	<div class="error-container">
		<img src="${ contextPath }/resources/images/error-image.png"/>
		<h2>${ msg }<%= request.getAttribute("javax.servlet.error.message") %></h2>
	</div>
</body>
</html>







