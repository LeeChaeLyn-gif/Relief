<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="ContextPath" value="${ pageContext.servletContext.contextPath }"
scope="application"/>
<html>
<head>
	<title>Home</title>
</head>
<body>
<jsp:include page="./mypage/listNavPage.jsp"/>
<br><br><br>
<center>
<h2><a href="${ContaxtPath}/faq/list">fqa 바로가기</a></h2>
<hr>
<h2><a href="${ContaxtPath}/notice/list">notice 바로가기</a></h2>
</center>
</body>

</html>
