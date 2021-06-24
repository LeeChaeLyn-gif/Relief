<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
        .homeimg{
            width: 200px;
            height: 100px;
            display: block;
            margin: 0px auto;
        }
        .loginFormDiv{
            
            border: 1px solid gray;
            width: 400px;
            height: 500px;
            text-align: center;
        }
        .idInput{
            width: 250px;
            height: 40px;
            border-radius: 5px;
            margin-top: 50px;
        }
        .pwdInput{
            width: 250px;
            height: 40px;
            border-radius: 3px;
        }
        .loginBtn{
            width: 260px;
            height: 40px;
            background-color: rgb(0, 51, 85);
            color : white;
            border-radius: 3px;
        }
        .findId{
            margin-left: 100px;
            text-decoration: none;
            color: gray;
            font-size: small;
        }
        .findPwd{
            text-decoration: none;
            color: gray;
            font-size: small;
        }
        .findId:hover{
            color: rgb(0, 51, 85);
        }
        .findPwd:hover{
            color: rgb(0, 51, 85);
        }
        .goJoinDiv{
            position: absolute;
            top: 25%;
            left: 40%;
        }
        h3{
            color: gray;
            text-align: center;
        }
        .joinBtn{
            background-color: rgb(0, 51, 85);
            border-radius: 5px;
            color: white;
            margin-left: 150px;
            height: 50px;
            font-weight : bolder;
        }

    </style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<!-- 구글 로그인 -->
<meta name="google-signin-scope" content="profile email">
<meta name ="google-signin-client_id" content="266613007830-lm6qoh0kfvto5i5ld3o77mfqje3nvpvm.apps.googleusercontent.com">

<!-- 구글 api 사용을 위한 스크립트 -->
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>

</head>
<body>
	<c:if test="${ !empty msg }">
		<script>alert(${msg});</script>
		<c:remove var="msg"/>
	</c:if>
	
	<div class="goJoinDiv">
        <div class="loginFormDiv">
            <a href="${ contextPath }/home"><img src="${ contextPath }/resources/images/relief.jpg" class="homeimg"></a>
            <form action="${ contextPath }/account/login" method="POST" onsubmit="validate();">
                <input type="text" name="aid" class="idInput" id="id" placeholder="아이디 입력">
                <br>
                <input type="password" name="pwd" class="pwdInput" id="pwd" placeholder="비밀번호 입력">
                <br>
                <button type="submit" class="loginBtn">로그인</button>
            </form>
            <div class="findAccountDiv">
                <a class="findId" href="${ contextPath }/account/findId">아이디 찾기</a>
                <a class="findPwd" href="${ contextPath }/account/findPwd">비밀번호 찾기</a>
            </div>
            <br>
            
            <!-- 네이버 -->
            <a href="${ url }"><img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"></a>
            
            <!-- 구글 버튼 -->
            <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark" style="margin-left: 88px; margin-top : 20px; width: 223px;"></div>
            
            
        </div>
        &nbsp;
        <h3>아직 회원이 아니신가요?</h3>
        <button type="button" class="joinBtn" id="join">다행가족되기</button>
    </div>
    <script>
        $(function(){
        	$("#join").on("click", function(){
        		location.href = '${ contextPath }/account/join'
        	})
        })
        
        function validate(){
        	if($("#id").val() == ""){
        		alert("아이디를 입력해주세요.");
        		return false;
        	}
        	if($("#pwd").val() == ""){
        		alert("비밀번호를 입력해주세요.");
        		return false;
        	}
        	return true;
        }
    </script>
    
    <!-- 구글 스크립트 -->
    <script>
    function signOut(){
    	var auth2 = gapi.auth2.getAuthInstance();
    	auth2.signOut();
    }
    
    function onSignIn(googleUser) {
      // 자동로그인 방지 (로그아웃)
      signOut();
      // Useful data for your client-side scripts:
      var profile = googleUser.getBasicProfile();

      // The ID token you need to pass to your backend:
      var id_token = googleUser.getAuthResponse().id_token;
      /* console.log("ID Token: " + id_token); */
      
      var auth2 = gapi.auth2.getAuthInstance();

      if(auth2.isSignedIn.get()) {
    	  $.ajax({
    		  url: '${contextPath}/account/googleLogin',
    		  type : 'post',
    		  data : {
    			  id : profile.getId(),
    			  name : profile.getName(),
    	  		  email : profile.getEmail()
    		  },
    		  success : function(data) {
    			  var temp;
    			  
    			  switch(data) {
    			  case "home" :
    				  temp = "${contextPath}/";
    				  break;
    			  
    			  case "join" :
    				  temp = "${contextPath}/account/googleJoin";
    				  break;
    			  default :
    				  temp = "${contextPath}/account/login"
    				  alert(data);
    			  }
    			  
    			  console.log(data);
    			  location.href = temp;
    			  
    		  }, error: function(data){
    	            alert("googleLogin err");
    		  }
   	  	}) 
      }
   	  
    }
	</script>
</body>
</html>