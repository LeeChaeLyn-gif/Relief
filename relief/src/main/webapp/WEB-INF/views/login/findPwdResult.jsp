<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }"
scope="application"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.pwd{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-top: 15px;
            margin-right: 95px;
            margin-left : 95px;
            border: 1px solid gray;
        }
        .checkPwd{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-right: 95px;
            margin-left : 95px;
            border: 1px solid gray;
        }
        .insertFormDiv{
            border: 1px solid gray;
            width: 450px;
            height: 750px;
            text-align: center;
            position: absolute;
            top: 10%;
            left: 40%;
        }
        h1{
            color: rgb(0, 51, 85);
        }
        .updateBtn{
            background-color: rgb(0, 51, 85);
            border-radius: 5px;
            color: white;
            height: 50px;
            width:  120px;
            font-weight : bolder;
        }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
</head>
<body>
	<script>
		$(function(){
			alert("${ msg }");
		})
	</script>
	
	<div class="insertFormDiv">
       	<h1>비밀번호 변경</h1>
       	<form action="${ contextPath }/account/findPwdUpdate" method="POST" id="joinForm" onsubmit="return joinValidate();">
       		<input type="hidden" name="aid" value="${ user.aid }">
       		<input type="password" id="pwd" class="pwd" name="pwd" placeholder="비밀번호 입력" required>
           	<input type="password" id="checkPwd" class="checkPwd" name="checkPwd" placeholder="비밀번호 확인">
            <button type="submit" class="updateBtn" id="updateBtn">확인</button>
       	</form>
    </div>
    <script>
    function joinValidate(){
    	if($("#joinForm input[name=pwd]").val() != $("#joinForm input[name=checkPwd]").val()){
    		alert('비밀번호가 일치하지 않습니다.');
    		return false;
    	}
    	return true;
    }
    </script>
</body>
</html>