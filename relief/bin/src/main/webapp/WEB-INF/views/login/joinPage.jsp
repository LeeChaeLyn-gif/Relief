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
            margin-top: 50px;
            border: 1px solid gray;
            margin-left: 30px;
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
        <h1>가입 정보 입력</h1>
        <form action="${ contextPath }/account/join" method="POST" id="joinForm" onsubmit="return joinValidate();">
            <input type="text" class="id" name="aid" placeholder="아이디 입력" required>
            <button type="button" class="checkId" id="checkId">아이디 중복확인</button>
            <input type="password" id="pwd" class="pwd" name="pwd" placeholder="비밀번호 입력" required>
            <p id="informPassword">&nbsp;</p>
            <input type="password" id="checkPwd" class="checkPwd" name="checkPwd" placeholder="비밀번호 확인">
            <input type="text" class="name" name="name" placeholder="이름 입력" required>
            <input type="tel" class="phone" name="phone" placeholder="전화번호 입력" required>
            <input type="email" class="email" name="email" placeholder="이메일 입력" required>
            <br>
            <input type="text" class="postcodify_postcode5" name="post" placeholder="우편번호" readonly>
            <input type="text" class="postcodify_address" name="address1" placeholder="주소 입력" readonly>
            <input type="text" class="postcodify_details" name="address2" placeholder="상세 주소 입력">
            <button type="button" class="searchAddressBtn" id="postcodify_search_button">검색</button>
            <br><br>
            <button type="submit" class="insertMemberBtn" id="insertMemberBtn" disabled="true">회원가입</button>
        </form>
    </div>
    <script>
        var pwd = document.getElementById("pwd");
        var checkPwd = document.getElementById("checkPwd");
        var informPassword = document.getElementById("informPassword");
        var insertMemberBtn = document.getElementById("insertMemberBtn");
        
        var informId = document.getElementById("informId");
        var id = document.getElementById("id")
        checkPwd.addEventListener("input", function(){
            if(pwd.value == checkPwd.value){
                informPassword.innerHTML ="비밀번호가 일치합니다.";

            } else {
                informPassword.innerHTML ="비밀번호가 불일치합니다.";
            }
        });
        
        function joinValidate(){
        	var aid = $("#joinForm input[name=aid]").val();
        	if(!(/^[a-z][a-z\d]{3,14}$/.test(aid))){
        		alert('아이디는 영소문자로 시작해서 4~15자 입력해주세요(숫자 포함 가능)');
        		$("#joinForm input[name=aid]").select();
        		return false;
        	}
        	if($("#joinForm input[name=pwd]").val() != $("#joinForm input[name=checkPwd]").val()){
        		alert('비밀번호가 일치하지 않습니다.');
        		return false;
        	}
        	if(!(/^[가-힣]{2,}$/.test($("#joinForm input[name=name]").val()))){
				alert('이름은 한글로 2글자 이상 입력해주세요.');
				$("#joinForm input[name=name]").select();
				return false;
			}
        	if($("#joinForm input[name=phone]").val() == '' || $("#joinForm input[name=post]").val() == '' || $("#joinForm input[name=address1]").val() == '' || $("#joinForm input[name=address2]").val() == ''){
        		alert('입력하지 않은 정보가 있습니다.');
        		return false;
        	}
        	return true;
        }
        
        $(function(){
        	var usable = false;
        	$("#checkId").on('click', function(){
        		var aid = $("#joinForm input[name=aid]");
        		
        		if(!aid || aid.val().length < 4){
        			alert("아이디는 4자리 이상이여야합니다.");
        			aid.focus();
        		} else {
        			$.ajax({
        				url : "checkId",
        				type : "post",
        				data : {aid : aid.val()},
        				success : function(data){
        					console.log(data);
        					if(data == "fail"){
        						alert("중복된 아이디입니다.");
        						aid.focus();
        					}else{
        						if(confirm("사용가능한아이디입니다. 사용하시겠습니까?")){
        							aid.prop('readonly', true);
									usable = true;
        						} else{
        							aid.prop('readonly', false);
        							aid.focus();
									usable = false;
        						}
        					}
        					if(usable){
        		                insertMemberBtn.style.backgroundColor = "rgb(0, 51, 85)";
        		                insertMemberBtn.disabled = false;
        					} else {
        						insertMemberBtn.style.backgroundColor = "gray";
        		                insertMemberBtn.disabled = true;
        					}
        				},
        				error : function(e){
        					console.log(e);
        				}
        			})
        		}
        	});
        });
    </script>
     <script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
    	<script>
    		// 검색 단추를 누르면 팝업 레이어가 열리도록 설정
    		$(function(){
    				$("#postcodify_search_button").postcodifyPopUp();
    		});
    	</script>
</body>
</html>