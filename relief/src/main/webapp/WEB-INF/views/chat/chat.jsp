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
		*{
			margin:0;
			padding:0;
		}
		.container{
			width: 500px;
			margin: 0 auto;
			padding: 25px;
		}
	    .container h4{
	        text-align: center;
	        padding: 5px 5px 5px 15px;
	        color: rgb(52, 73, 94);
	        border-bottom: 3px solid rgb(52, 73, 94);
	        margin-bottom: 20px;
	    }
		.chating{
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.chating .me{
			background-color : #597a96;
			margin-bottom : 1%;
			margin-left : 70%;
			color: #F6F6F6;
			text-align: center;
			border-radius: 10px;
			padding : 5px 9px;
		}
		.chating .others{
			background-color : rgb(140, 140, 140);
			margin-bottom : 1%;
			margin-right : 70%;
			color: #F6F6F6;
			text-align: center;
			border-radius: 10px;
			padding : 5px 9px;
		}
		input{
			width: 330px;
			height: 25px;
			text-align:center;
		}
		ul, li {
			list-style : none;
			margin:0;
			padding:0;
		}
		#chatMenu {
			text-align:right;
		}
		#sendBtn{
			color : #F6F6F6;
			background-color : #597a96;
			width : 60px;
			height : 30px;
			border-radius:30px;
		}
		#chatMenu2 {
			float:right;
		}
		#chatSubMenu > li {
			display:inline-block;
		}
		.inputTable {
			margin: auto;	
		}
	</style>
</head>

<body>
	
	<div id="container" class="container">
		<h4>다행톡</h4> <!-- 채팅상대 이름 불러와야함 -->
		<div id="chatMenu" class="chatMenu">
		<ul id="myChatMenu" class="myChatMenu">
			<li id="chatMenu2" class="chatMenu2"> <img src="${ contextPath }/resources/images/menu.png"/>
				<ul id="chatSubMenu" class="chatSubMenu">
					<li>차단</li>
					<li>알림</li>
					<li>나가기</li>
				</ul>
			</li>
		</ul>
		</div>
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="chatId" value="${chatId}">
		
		<div id="chating" class="chating">
		<c:if test="${!empty chList }">
			<c:forEach items="${ chList }" var="ch">
			<c:if test="${ loginUser.aid == ch.accountId }">
				<p class='me'> ${ ch.content } </p> 
			</c:if>
			<c:if test="${ loginUser.aid != ch.accountId }">
				<p class='others'> ${ ch.content } </p>
			</c:if>
			</c:forEach>
		</c:if>
		</div>
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
<script type="text/javascript">
	$('#chating').scrollTop($('#chating')[0].scrollHeight);
	
	var ws;

	 $(function(){
			wsOpen();	 
		 });
	
	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://" + location.host + "/chat/"+$("#chatId").val());
		wsEvt();
	}
	
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 동작
			console.log(data);
		}
		
		ws.onmessage = function(data) {
			//메시지를 받으면 동작
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				var d = JSON.parse(msg);
				if(d.type == "getId"){
					var si = d.sessionId != null ? d.sessionId : "";
					if(si != ''){
						$("#sessionId").val(si); 
					}
				}else if(d.type == "message"){
					if(d.sessionId == $("#sessionId").val()){
						$("#chating").append("<p class='me'>" + d.msg + "</p>");	
					}else{
						$("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
					}
						
				}else{
					console.warn("unknown type!")
				}
				$('#chating').scrollTop($('#chating')[0].scrollHeight);
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
	}
	 
	function send() {
		var option ={
			type: "message",
			chatId: $("#chatId").val(),
			sessionId : $("#sessionId").val(),
			chatId : '${chatId}',
			accountId : '${loginUser.aid}',
			chatSender : '${loginUser.aid}',
			msg : $("#chatting").val()
		}
		console.log(option)
		ws.send(JSON.stringify(option));
		$('#chatting').val("");
	}
	
	
	$('#chatSubMenu').hide();
	$('#chatMenu2').click(function(){
		$('#chatSubMenu').slideToggle(300);
	});
	
</script>
</html>