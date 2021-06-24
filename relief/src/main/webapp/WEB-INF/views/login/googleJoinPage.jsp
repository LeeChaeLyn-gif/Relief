<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
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
        .id{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-top: 15px;
            margin-right: 95px;
            border: 1px solid gray;
        }
        .pwd{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-top: 15px;
            margin-right: 95px;
            border: 1px solid gray;
        }
        .checkPwd{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-right: 95px;
            border: 1px solid gray;
        }
        .name{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-top: 15px;
            margin-right: 95px;
            border: 1px solid gray;
        }
        .phone{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-top: 15px;
            margin-right: 95px;
            border: 1px solid gray;
        }
        .postcodify_postcode5{
            width: 125px;
            height: 40px;
            border-radius: 5px;
            margin-top: 15px;
            margin-right: 220px;
            border: 1px solid gray;
        }
        .postcodify_address{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-top: 15px;
            margin-right: 95px;
            border: 1px solid gray;
        }
        .email{
        	width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-top: 15px;
            margin-right: 95px;
            border: 1px solid gray;
        }
        .postcodify_details{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-top: 15px;
            border: 1px solid gray;
        }
        .searchAddressBtn{
            background-color: rgb(0, 51, 85);
            border-radius: 5px;
            color: white;
            height: 50px;
            width:  90px;
            font-weight : bolder;
        }
        .insertMemberBtn{
            background-color: rgb(0, 51, 85);
            border-radius: 5px;
            color: white;
            margin-right : 25px;
            height: 50px;
            width:  120px;
            font-weight : bolder;
        }
        p{
            font-size: small;
            margin: 0;
            color: red;
        }
        .checkId{
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
	<div class="insertFormDiv">
        <h1>추가 정보 입력[필수]</h1>
        <form name="frm" action="${ contextPath }/account/insertGoogle" method="POST" onsubmit="pwdValidate()">
            <input type="text" class="id" name="aid" placeholder="아이디 입력" required value="${googleLogin.aid}" readonly>
            <input type="text" class="name" name="name" placeholder="이름 입력" required value="${googleLogin.name}" readonly>
            <input type="password" class="pwd" id="pwd1" name="pwd" placeholder="비밀번호 입력" required/>
            <input type="password" class="pwd" id="pwd2" placeholder="비밀번호 확인" required/>
            <input type="tel" class="phone" name="phone" placeholder="전화번호 입력" required>
            <input type="email" class="email" name="email" placeholder="이메일 입력" required readonly value="${googleLogin.email}">
            <br>
            <input type="text" class="postcodify_postcode5" name="post" placeholder="우편번호" readonly required>
            <input type="text" class="postcodify_address" name="address1" placeholder="주소 입력" readonly required>
            <input type="text" class="postcodify_details" name="address2" placeholder="상세 주소 입력" required>
            <button type="button" class="searchAddressBtn" id="postcodify_search_button">검색</button>
            <br><br>
            <button type="submit" class="insertMemberBtn" id="insertMemberBtn" >회원가입</button>
        </form>
    </div>

     <script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
    	<script>
    		// 검색 단추를 누르면 팝업 레이어가 열리도록 설정
    		$(function(){
    				$("#postcodify_search_button").postcodifyPopUp();
    		});
    	</script>
    	
    	<script>
    	function pwdValidate() {
		    var pwd1 = document.getElementById('pwd1').value;
		    var pwd2 = document.getElementById('pwd2').value;
		    if ( pwd1 != pwd2 ) {
		    	alert("비밀번호가 일치하지 않습니다.");
		      	return false;
		    }
	   }
    	</script>

</body>
</html>