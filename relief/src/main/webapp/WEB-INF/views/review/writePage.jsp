<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 4.0ver -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<!-- Jquery 3.6 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<style type="text/css">
	* {
		box-sizing: border-box;
	}
	 
	#wrap {
		width: 1140px;
		heigth : auto;
		
		/* nav를 중앙부로 */
		margin: auto;
	}
	
	#files{
		width : 100%;
	}
	
	#cotent{
		height : 200px;
	}
	.BmarginSize {
		margin-bottom : 50px;
	}
	.TmarginSize {
		margin-top : 50px;
	}
	.RmarginSize {
		margin-right : 20px;
	}
	
	.starR{
	  background: url('${ contextPath }/resources/images/star.jpg') no-repeat right 0;
	  background-size: auto 100%;
	  width: 30px;
	  height: 30px;
	  display: inline-block;
	  text-indent: -9999px;
	  cursor: pointer;
	  
	}
	.starR.on{background-position:0 0;}
	
	.btn-color {
		color : #fff;
		background-color : #34495E;
	}
</style>

</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<br><br><br><br><br><br><br><br><br>

<div id="wrap">
	<form action="${ contextPath }/review/insert" method="post" onsubmit="return starValue();">
		<h1 class="text-center TmarginSize">리뷰작성</h1>
		<hr class="BmarginSize">
		<!-- t_histroy_id 값 넘겨주기 -->
		<input type="hidden" value="${t_history_id}" name="t_history_id">
		
		<div class="starRev" style="margin-bottom : 15px">
		별점&nbsp;
		  <span class="starR on">1</span>
		  <span class="starR">2</span>
		  <span class="starR">3</span>
		  <span class="starR">4</span>
		  <span class="starR">5</span>
		  <!-- star 값 넘겨주기 -->
		  <input id="star" type="hidden" value="0" name="star">
		</div>
		
		<div class="mb-3">
		  <label for="title" class="form-label">제목</label>
		  <input type="text" class="form-control" id="title" placeholder="제목 입력" name="title">
		</div>
		<div class="mb-3">
		  <label for="content" class="form-label">내용</label>
		  <textarea class="form-control" id="cotent" rows="3" style="resize: none;" name="content"></textarea>
		</div>

		<div class="text-right">
			<button type="button" class="btn btn-color RmarginSize" onclick="location.href='${ contextPath }/review/list">뒤로가기</button>
			<button type="submit" class="btn btn-color">작성</button>
		</div>
	</form>
</div>

<script type="text/javascript">
function starValue(){
	var star = $('.on').last().text();
	$('#star').val(star);
	true;
}
</script>

<script>
$(function(){
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  return false;
	});

})

</script>

</body>
</html>