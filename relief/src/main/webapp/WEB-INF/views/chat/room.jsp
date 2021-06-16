<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
	<title>다양한 일을 행하다</title>
	<style>
button {
	background-color: #FFBB00;
	font-size: 14px;
	color: #000;
	border: 1px solid #000;
	border-radius: 5px;
	padding: 3px;
	margin: 3px;
}

#container {
	width: 290px;
	background: #fff;
	border-radius: 6px;
	overflow: hidden;
	height: 484px;
	position: absolute;
	top: 100px;
	left: 50%;
	margin-left: -155px;
}

.container h4 {
	text-align: center;
	padding: 5px 5px 5px 15px;
	color: rgb(52, 73, 94);
	border-bottom: 2px solid rgb(52, 73, 94);
}

#roomContainer {
	position: absolute;
	width: 100%;
	height: 100%;
}

.chatRoom {
	height: 70px;
	border-bottom: 1px solid #e7ebee;
	position: relative;
}

.chatRoom:hover {
	background: #f1f4f6;
	cursor: pointer;
}


.chatUserName {
	width:30%;
	text-align:center;
	float:left;
	color: #597a96;
	display : inline-block;
	padding-top:5%;
}

.chatContent {
	width:50%;
	text-align:center;
	font-weight: 600;
	font-size: 15px;
	color: #597a96;
	float:left;
	display : inline-block;
	padding-top:5%;
}

.chatDate {
	width:20%;
	text-align:center;
	font-size: 13px;
	font-weight: 400;
	color: #aab8c2;
	float:left;
	display : inline-block;
	padding-top:5%;
}
</style>
</head>
<body>
	<div class="container">
		<h4>다행톡</h4>
		<div id="roomContainer" class="roomContainer">
			<input type="hidden" id="accountId" name="accountId" value="${ loginUser.aid }">
			<div id="roomList" class="roomList">
			</div>
		</div>
	</div>
<script>
	var ws;
	window.onload = function(){
		chatList();
	}
	
	function chatList(){
		var accountId = $("#accountId").val();
		console.log(accountId);
			
		$.ajax({
			url:"${contextPath}/chatList",
			data:{ accountId : accountId },
			type:"get",
		 dataType:"json", 
			success:function(data){
				console.log(data);
				var value = "";
				$(".chatRoom").remove();
				for(var i in data.cList){
					console.log(data);
					
						
						value = "<div class='chatRoom' onclick='selectChat( "+ data.cList[i].chatId + ")'><div class='chatUserName'>" + data.cList[i].name + "</div><div class='chatContent'>"
						+ data.cList[i].content + "</div><div class='chatDate'>" + data.cList[i].chatDate + "</div></div>"
					$("#roomList").append(value);
				}
			},
			error:function(data){
				console.log(data);
			},
			complete: function(){
				setTimeout(chatList, 2000);
			}
		});
	}
	
	function selectChat(chatId){
		var _width = '650';
	    var _height = '380';
		var _left = Math.ceil(( window.screen.width - _width ));
		var _top = Math.ceil(( window.screen.height - _height )/2);
		
		window.open("${contextPath}/selectChat?chatId=" + chatId, "", "width=550, height=600, left=" + _left + ", top=" + _top);
		
	}

</script>
</body>
</html>