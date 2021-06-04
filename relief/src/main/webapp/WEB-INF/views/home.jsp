<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }"
scope="application"/>
<html>
<head>
	<title>Home</title>
</head>
<body>
<c:if test="${ empty sessionScope.loginUser }">
<a href="${ contextPath }/account/login">로그인</a>
</c:if>
<c:if test="${ sessionScope.loginUser.aid eq 'admin' }">
	<a href="${ contextPath }/admin/main">관리자페이지</a>
</c:if>
<c:if test="${ !empty sessionScope.loginUser }">
<a href="${ contextPath }/account/logout">로그아웃</a>
</c:if>
<form action="${ contextPath }/board/list" method="get">
<input type="text" name="searchValue">
<button type="submit">검색</button>
</form>
</body>
</html>
