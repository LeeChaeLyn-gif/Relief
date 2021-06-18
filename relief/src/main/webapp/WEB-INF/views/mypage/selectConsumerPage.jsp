<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

<!-- bootstrap 4.0ver -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" !important>

<!-- Jquery 3.6 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<meta charset="UTF-8">
<title>selectConsumer</title>

<style>
	* {
		box-sizing: border-box;
	}
	 
	#wrap {
		width: 500px;
		heigth : 500px;
		/* nav를 중앙부로 */
		            
		margin: auto;
	}
	
	.btn-color {
		color : #fff;
		background-color : #34495E;
	}
</style>
	
</head>
<body>

	<div id="wrap">
		<table class="table table-hover">
			<tr>
				<td scope="col">구매자</td>
				<td scope="col">선택</td>
			</tr>
			<c:forEach items="${ list }" var="consumer_id">
			<tr>
				<td scope="col">${consumer_id}</td>
				<td scope="col">
					<button class="btn btn-color"  onclick="selectConsumer('${consumer_id}', '${t_history_id}')">확정</button>
				</td>
			</tr>
			</c:forEach>
		</table>
	
	</div>
	
	<script>
	function selectConsumer(consumer_id, t_history_id) {
		if(confirm("선택하시겠습니까?")) {
			$.ajax({
	            url: "${contextPath}/mypage/T_Complete",
	            type: "GET",
	            data: {consumer_id : consumer_id, t_history_id : t_history_id},
	            success: function(data){
	            	if(data == "true") {
	            		alert("처리 완료되었습니다.");
		                window.close();
	            	} else {
	            		alert("처리 실패했습니다.");
	            	}
	                
	            },
	            error: function(){
	                alert("simpleWithObject err");
	            }
	        });
		}
	} 
	</script>
	

</body>
</html>