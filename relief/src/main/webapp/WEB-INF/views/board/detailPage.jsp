<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail Page</title>
<style>
* {
	box-sizing: border-box;
}

.outer {
	width: 100%;
	min-height: 800px;
	margin: auto;
}

div {
	border: 1px solid transparent;
	display: block;
}

h1,h2,h3,h4,h5{
	color : rgb(52, 73, 94) !important;
}

.part1 {
	width: 10%;
	height: 100%;
	float: left;
}

.part2 {
	width: 80%;
	height: 100%;
	float: left;
}

.part3 {
	width: 10%;
	height: 100%;
	float: left;
}

.item-detail {
	width: 100%;
	height: 400px;
}

.item-image {
	width: 410px;
	height: 410px;
	display: inline-block;
}

.detail {
	width: 500px;
	height: 410px;
	display: inline-block;
	margin-left : 20px;
}

.category-box {
	width: 100%;
}

.sellerinfo{
	border-top : 1px solid lightgray;
	border-left : 1px solid lightgray;
	border-right : 1px solid lightgray;
	text-align : center;
	height : 30px;
	padding-top : 5px;
}

textarea{
	width : 600px;
	height : 100px;
}

.btn {
	color : white;
	background : rgb(52, 73, 94);
}

#replyTable{
      text-align:center;
      width : 600px;
      line-height : 2.5;
      border-collapse : collapse;
      border : 1px solid lightgray;
   }
   
#replyTable th {
	border : 1px solid lightgray;
}

#replyTable tr {
	border : 1px solid lightgray;
}

#replyTable th:nth-child(1) {
    width : 70px;
    text-align:center;
}
   
#replyTable th:nth-child(2) {
    width : 430px;
    text-align:center;
}
   
#replyTable th:nth-child(3) {
    width : 100px;
    text-align:center;
}

.reviewTable{
	border : 1px solid lightgray;
	margin-bottom : 5px;
	width : 330px;
	height : 50px;
}

.reviewTable th{
	padding: 5px;
	width : 320px;
	white-space : nowrap;
	overflow : hidden;
	text-overflow : ellipsis;
}
.reviewTable td{
	padding: 5px;
}
.reviewBtn{
	text-align : right;
}

.replyText {
	width : 430px;
	resize : none;
}

.replyAreaTd {
	text-align : left;
	padding-left : 30px;
}


/* 버튼 */
.wishbutton, .chatbutton, .reportbutton {
	background-color: rgb(52, 73, 94);
	border: none;
	color: #ffffff;
	cursor: pointer;
	display: inline-block;
	font-family: 'BenchNine', Arial, sans-serif;
	font-size: 1em;
	font-size: 18px;
	line-height: 1em;
	margin: 15px 20px;
	outline: none;
	padding: 12px 10px 10px;
	position: relative;
	text-transform: uppercase;
	font-weight: 700;
}

.wishbutton:before, .wishbutton:after, .chatbutton:before, .chatbutton:after,
	.reportbutton:before, .reportbutton:after {
	border-color: transparent;
	-webkit-transition: all 0.25s;
	transition: all 0.25s;
	border-style: solid;
	border-width: 0;
	content: "";
	height: 24px;
	position: absolute;
	width: 24px;
}

.wishbutton:before, .chatbutton:before, .reportbutton:before {
	border-color: #243366;
	border-right-width: 2px;
	border-top-width: 2px;
	right: -5px;
	top: -5px;
}

.wishbutton:after, .chatbutton:after, .reportbutton:after {
	border-bottom-width: 2px;
	border-color: #617ca3;
	border-left-width: 2px;
	bottom: -5px;
	left: -5px;
}

.wishbutton:hover, .wishbutton.hover, .chatbutton:hover, .chatbutton.hover,
	.reportbutton:hover, .reportbutton.hover {
	background-color: #617ca3;
}

.wishbutton:hover:before, .wishbutton.hover:before, .wishbutton:hover:after,
	.wishbutton.hover:after, .chatbutton:hover:before, .chatbutton.hover:before,
	.chatbutton:hover:after, .chatbutton.hover:after, .reportbutton:hover:before,
	.reportbutton.hover:before, .reportbutton:hover:after, .reportbutton.hover:after
	{
	height: 100%;
	width: 100%;
}

#pdetail {
	margin-left: 20px;
}

.content {
	width : 100%;
	min-heignt : 600px;
	margin-top : 100px;
	display : inline-block;
}

.content1{
	width : 70%;
	display : inline-block;
}
.content2{
	width : 28%;
	float : right;
}

.detailBtn{
	display: flex;
    height: 50px;
}

.detailBtn1 : first-child{
	border-left: 1px solid rgb(52, 73, 94);
}

.detailBtn1{
	flex: 1 1 0%;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
    display: flex;
    border-top: 1px solid rgbrgb(52, 73, 94);
    border-right: 1px solid rgbrgb(52, 73, 94);
    border-bottom: 1px solid rgb(255, 255, 255);
    background: rgb(255, 255, 255);
    color: rgb(52, 73, 94);
    font-weight: 600;
}

.detailBtn2{
	flex: 1 1 0%;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
    display: flex;
    border-top: 1px solid rgb(52, 73, 94);
    border-right: 1px solid rgb(52, 73, 94);
    border-bottom: 1px solid rgb(255, 255, 255);
    background: rgb(255, 255, 255);
    color: rgb(52, 73, 94);
    font-weight: 600;
}

.detailInfo{
	width : 300px;
	border : 1px solid lightgray;
	display : inline-block;
	text-align : center;
}

.info_area{
	width : 55%;
	float : left;
	border-right : 1px solid lightgray;
}

.info_category{
	width : 45%;
	float : left;
	text-align : center;
}

.infoValue{
	width : 100%;
	height : 35px;
	padding-top : 5px;
	background : rgb(52, 73, 94);
	
}

#clabel{
	font-size : 25px;
	margin-right : 10px;
	margin-left : 10px;
}

select { 

	padding: 5px 5px;
	font-family: inherit;
	background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%;
	border: 1px solid #999; 
	border-radius: 0px;
	-webkit-appearance: none;
	-moz-appearance: none; 
	appearance: none; 
}


/* 이미지 슬라이드 */
/*GLOBALS*/
* {
	margin: 0;
	padding: 0;
	list-style: none;
}

#wrapper {
	width: 410px;
	margin: 50px auto;
	height: 410px;
	position: relative;
	color: #fff;
	text-shadow: rgba(0, 0, 0, 0.1) 2px 2px 0px;
}

#slider-wrap {
	width: 410px;
	height: 410px;
	position: relative;
	overflow: hidden;
}

#slider-wrap ul#slider {
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	left: 0;
}

#slider-wrap ul#slider li {
	float: left;
	position: relative;
	width: 408px;
	height: 410px;
}

#slider-wrap ul#slider li>div {
	position: absolute;
	top: 20px;
	left: 35px;
}

#slider-wrap ul#slider li img {
	display: block;
	width: 100%;
	height: 100%;
}

/*btns*/
.btns {
	position: absolute;
	width: 50px;
	height: 60px;
	top: 50%;
	margin-top: -25px;
	line-height: 57px;
	text-align: center;
	cursor: pointer;
	background: rgba(0, 0, 0, 0.1);
	z-index: 100;
	-webkit-user-select: none;
	-moz-user-select: none;
	-khtml-user-select: none;
	-ms-user-select: none;
	-webkit-transition: all 0.1s ease;
	-moz-transition: all 0.1s ease;
	-o-transition: all 0.1s ease;
	-ms-transition: all 0.1s ease;
	transition: all 0.1s ease;
}

.btns:hover {
	background: rgba(0, 0, 0, 0.3);
}

#next {
	right: -50px;
	border-radius: 7px 0px 0px 7px;
}

#previous {
	left: -50px;
	border-radius: 0px 7px 7px 7px;
}

#counter {
	top: 30px;
	right: 30px;
	width: auto;
	position: absolute;
}

#slider-wrap.active #next {
	right: 0px;
}

#slider-wrap.active #previous {
	left: 0px;
}

/*bar*/
#pagination-wrap {
	min-width: 20px;
	margin-top: 350px;
	margin-left: auto;
	margin-right: auto;
	height: 15px;
	position: relative;
	text-align: center;
}

#pagination-wrap ul {
	width: 100%;
}

#pagination-wrap ul li {
	margin: 0 4px;
	display: inline-block;
	width: 5px;
	height: 5px;
	border-radius: 50%;
	background: #fff;
	opacity: 0.5;
	position: relative;
	top: 0;
}

#pagination-wrap ul li.active {
	width: 12px;
	height: 12px;
	top: 3px;
	opacity: 1;
	box-shadow: rgba(0, 0, 0, 0.1) 1px 1px 0px;
}

/*ANIMATION*/
#slider-wrap ul, #pagination-wrap ul li {
	-webkit-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
	-moz-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
	-o-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
	-ms-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
	transition: all 0.3s cubic-bezier(1, .01, .32, 1);
}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<jsp:include page="../common/sidebar.jsp" /><br>
	<br><br><br><br><br><br><br><br><br>
	<div class="outer">
		<div class="part1"></div>
		<div class="part2">
			<div class="category-box">
				<form>
					<label for="category" id="clabel">카테고리</label> 
					<select id="category1" name="category1">
						<option value="">카테고리 1</option>
						<c:forEach items="${ clist }" var="c">
						<c:if test="${ c.cgroup == 1 }">
							<option value="${ c.cid }" <c:if test="${ c.cid == firstCid }">selected</c:if>>
                		 ${ c.cname }
                		 </option>  
							</c:if>
						</c:forEach>
						
					</select> 
					<select id="category2" name="category2">
						<option value="">카테고리 2</option>
						<c:forEach items="${ clist }" var="c">
						<c:if test="${ c.cgroup == 2 }">
							<option value="${ c.cid }" <c:if test="${ c.cid == secondCid }">selected</c:if>>
                		 ${ c.cname }
                		 </option>
							</c:if>
						</c:forEach>
					</select> 
					<select id="category3" name="category3">
						<option value="">카테고리 3</option>
						<c:forEach items="${ clist }" var="c">
						<c:if test="${ c.cgroup == 3 }">
							<option value="${ c.cid }" <c:if test="${ c.cid == cid }">selected</c:if>>
                		 ${ c.cname }
                		 </option>
							</c:if>
						</c:forEach>
					</select>
				</form>
			</div>
			<hr>
			<div class="item-detail">
				<div class="item-image">
					<div id="wrapper">
						<div id="slider-wrap">
							<ul id="slider">
								<c:forEach items="${ ilist }" var="i">
									<li>
										<img src="${ contextPath }/resources/buploadFiles/${ i.renameFileName }">
									</li>
								</c:forEach>
							</ul>

							<!--controls-->
							<div class="btns" id="next">
								<i class="fa fa-arrow-right"></i>
							</div>
							<div class="btns" id="previous">
								<i class="fa fa-arrow-left"></i>
							</div>
							<div id="counter"></div>

							<div id="pagination-wrap">
								<ul>
								</ul>
							</div>
							<!--controls-->

						</div>

					</div>
				</div>

				<script>
				var price = "${ board.price }";
				$(function(){
					var price2 = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				    document.getElementById('price').innerHTML = price2 + "원";
				})
				 
				
				function interval(){
					var today = new Date();
					var timeValue = new Date("${ board.create_date }");
				
					
					const betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
					console.log(betweenTime);
			        if (betweenTime < 1) return "방금전";
			        if (betweenTime < 60) {
			            return betweenTime+"분전";
			        }
			
			        const betweenTimeHour = Math.floor(betweenTime / 60);
			        if (betweenTimeHour < 24) {
			            return betweenTimeHour+"시간전";
			        }
			
			        const betweenTimeDay = Math.floor(betweenTime / 60 / 24);
			        if (betweenTimeDay < 365) {
			            return betweenTimeDay+"일전";
			        }
			
			        return Math.floor(betweenTimeDay / 365)+"년전";
					
			        
					
				};

				
				</script>
				<div class="detail">
					<div id="pdetail">
						<h1>${ board.title }</h1>
						<Br>
						<h2 id="price"></h2>
						<br>
						<p id="create_date">조회수 : ${ board.count } / 글올린시간 : <script>document.write(interval());</script></p>
						<input type="hidden" id="board_id" value="${ board.board_id }">
						<h5 class="sub"></h5>
						<br>
						<p>상품상태 : ${ board.product_status }</p>
						<p>교환여부 : ${ board.exchange_status }</p>
						<p>거래지역 : ${ board.area }</p>
					</div>
					<div id="detail-btn">
						<button class="wishbutton"><i class="fa fa-heart" aria-hidden="true"></i>찜버튼</button>

						<button class="chatbutton" onclick="chat()"><i class="fa fa-commenting" aria-hidden="true"></i>채팅</button>
						<button class="reportbutton" onclick="report()"><i class="fa fa-bell" aria-hidden="true"></i>신고하기</button>

					</div>
					<br>
				</div>
			</div>
			<div class="content">
				<div class="content1">
					<div class="detailBtn">
					<button id="btn1" type="button" class="detailBtn1">상품 정보</button>
					<button id="btn2" type="button" class="detailBtn2">상품 문의</button>
					</div>
					<br><br>
					<div class="btn1">
					<h4 style="font-weight : bold;">상품 정보</h4><hr><br>
					<h5>${ board.content }</h5>
					<br>
					<hr>
					<br>
					<div class="detailInfo">
						<div class="info_area">
						<div class="infoValue"><h5 style="color : white !important;">거래지역</h5></div>
						${ board.area }
						</div>
						<div class="info_category">
						<div class="infoValue"><h5 style="color : white !important;">카테고리</h5></div>
						${ c.cname }
						</div>
					</div>
					</div>
					<br>
					<hr>
					<br>
					<div>
					<h4 class="btn2" style="font-weight : bold;">상품 문의</h4><hr>
					<br>
					<h5>상품 문의 댓글</h5>
						<textarea id="replyContent" style="resize : none;"></textarea>
						<br>
						<c:if test="${ !empty loginUser }">
						<button class="btn" id="addReply">댓글 등록</button>
						</c:if>
						<c:if test="${ empty loginUser }">
						<button class="btn" onclick="validate()">댓글 등록</button>
						</c:if>
						<br><hr><br>
						<div class="replySelectArea">
							<table id="replyTable">
								<thead>
									<tr>
										<th>작성자</th>
										<th>내용</th>
										<th>작성일</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${ !empty relist }">
									<c:forEach items="${ relist }" var="e">
											<tr class="replyArea">
												<td>${ e.aid }<input type="hidden" name="rid" value="${ e.reply_id }"></td>
												<td class="replyAreaTd">${ e.title }<input type="hidden" name="rid2" value="${ e.reply_id2 }"></td>
												<td>${ e.create_date }</td>
											</tr>
											<tr class="replyArea2" style="display : none;">
												<td></td>
												<td>
												<textarea class="replyText" id="${ e.reply_id }"></textarea>
												<c:choose>
												<c:when test="${ loginUser.aid == board.account_id }">
												<button onclick="addReply(${ e.reply_id })" class="btn" type="button">답글달기</button>
												</c:when>
												<c:otherwise>
												<button onclick="validate2()" class="btn" type="button">답글달기</button>
												</c:otherwise>
												</c:choose>
												</td>
												<td></td>
											</tr>
									</c:forEach>
								</c:if>
								<c:if test="${ empty relist }">
								<tr>
									<td colspan="3">작성 된 댓글이 없습니다.</td>
								</tr>
								</c:if>
								</tbody>
							</table>
						</div>
					<br><br><br><br><br><br><br><br><br>
					</div>
				</div>
				<div class="content2">
					<div class="sellerinfo"><p style="font-weight : bold">판매자 정보</p></div>
					<hr>
					<h4>판매자 아이디</h4>
					<p class="accountId">${ board.account_id }</p>
					<hr>
					<h4>리뷰</h4>
					<c:forEach items="${ rlist }" begin="0" end="2" var="r">
					<table class="reviewTable">
					<tr>
					<th colspan="2"><p>${ r.content }</p></th>
					</tr>
					<tr>
					<td><p>${ r.consumer_id }</p></td>
					<td align="right"><p>${ r.create_date }</p></td>
					</tr>
					</table>
					</c:forEach>
					<div class="reviewBtn">
					<button class="btn">더보기</button>
					</div>
				</div>
			</div>
			<script>
			const btnArr = document.getElementsByTagName('button'); 
			for(let i = 0; i < btnArr.length; i++){ 
				btnArr[i].addEventListener('click',function(e){ 
					e.preventDefault(); 
					document.querySelector('.btn' + (i + 1)).scrollIntoView(true); 
					}); 
				}
			
			
			
			$(document).ready(function(){

				$('#btn2').click(function(){

					var offset = $('.btn2').offset();

			        $('html').animate({scrollTop : offset.top}, 400);
				});
			});
	
			$(".wishbutton").on("click", function(){
				var board_id = $("#board_id").val();
				location.href="${ contextPath }/board/wish?board_id=" + board_id;
			});
			
			
			$(function(){
	    		$("#category1").on('change', function(){
	    			var cid = $("#category1 option:selected").val();
	    			location.href="${ contextPath }/board/category1?cid=" + cid;
	    		})
	    		
	    		$("#category2").on('change', function(){
	    			var cid = $("#category2 option:selected").val();
	    			location.href="${ contextPath }/board/category2?cid=" + cid;
	    		})
	    		
	    		$("#category3").on('change', function(){
	    			var cid = $("#category3 option:selected").val();
	    			location.href="${ contextPath }/board/category3?cid=" + cid;
	    		})
	    	})

			</script>
		</div>
		<div class="part3"></div>
	</div>
	
	<script>
		$("#addReply").on("click", function(){
			var title = $("#replyContent").val();
			var bid = ${ board.board_id };
			
			$.ajax({
				url : "${ contextPath }/board/insertReply",
				data : { title : title, bid : bid },
				type : "post",
				dataType : "json",
				success : function(data){
					tableBody = $("#replyTable tbody");
					tableBody.html("");
					
					for(var i in data){
						tr = $("<tr>");
						account = $("<td width='70'>").text(data[i].aid);
						content = $("<td>").text(data[i].title);
						createDate = $("<td width='100'>").text(data[i].create_date);
						
						tr.append(account, content, createDate);
						tableBody.append(tr);
					}
					
					$("#replyContent").val("");
				}
			});
		});
		
		
		$(document).ready(function(){
			
			$(".replyArea").on("click", function(){
				var currentRow = $(this).closest('tr');
				var detail = currentRow.next('tr');
				var rid = $(this).find("input[name=rid2]").val();
				if(detail.is(":visible")){
					detail.hide();
				} else {
					detail.show();
				}
				if(rid == 2){
					detail.hide();
				}
			})
			
		})

		function refreshMemList(){
		location.reload();
		}
		
		function addReply(rid){
			var title = $("#"+rid).val();
			var bid = ${ board.board_id };
			
			var currentRow = $("#"+rid).closest('tr');
			
			if(title == ""){
				alert('답변을 적어주세요.');
				return false;
			}
	
			$.ajax({
				async : false,
				url : "${ contextPath }/board/insertReply2",
				data : { title : title, bid : bid, rid : rid },
				type : "post",
				dataType : "json",
				success : function(data){
					tableBody = $("#replyTable tbody");
					tableBody.html("");
					
					for(var i in data){
						tr = $("<tr>");
						account = $("<td width='70'>").text(data[i].aid);
						content = $("<td style='text-align : left; padding-left : 30px'>").text(data[i].title);
						createDate = $("<td width='100'>").text(data[i].create_date);
						
						tr.append(account, content, createDate);
						tableBody.append(tr);
					}
					
					$("#"+rid).val("");
					currentRow.hide();
					
					refreshMemList();
				}
			})
		}
			$('#slider-wrap ul#slider').css('left', -(sliderWidth * pos));

			countSlides();
			pagination();
		}

			$('#counter').html(pos + 1 + ' / ' + totalSlides);

		function validate(){
			if(confirm('다행 회원만 이용 가능합니다. 로그인 하시겠습니까?')){
				location.href = "${ contextPath }/account/login";
			} else {
				return false;
			}
		}
		
		// 글쓴이가 아닐 경우
		function validate2(){
			alert('글쓴이만 답변을 달 수 있습니다.');
			
		}
	</script>
	<script>

	var pos = 0;

	var totalSlides = $('#slider-wrap ul li').length;

	var sliderWidth = $('#slider-wrap').width();


	$(document).ready(function(){
	  
	  $('#slider-wrap ul#slider').width(sliderWidth*totalSlides);
	  
	  $('#next').click(function(){
	    slideRight();
	  });
	  
	  $('#previous').click(function(){
	    slideLeft();
	  });
	  
	  
	  var autoSlider = setInterval(slideRight, 3000);
	  
	  $.each($('#slider-wrap ul li'), function() { 

	     var li = document.createElement('li');
	     $('#pagination-wrap ul').append(li);    
	  });
	  
	  countSlides();
	  
	  pagination();
	  
	  $('#slider-wrap').hover(
	    function(){ $(this).addClass('active'); clearInterval(autoSlider); }, 
	    function(){ $(this).removeClass('active'); autoSlider = setInterval(slideRight, 3000); }
	  );

	});
	  

	function slideLeft(){
	  pos--;
	  if(pos==-1){ pos = totalSlides-1; }
	  $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos));  
	  
	  countSlides();
	  pagination();
	}


	function slideRight(){
	  pos++;
	  if(pos==totalSlides){ pos = 0; }
	  $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos)); 
	  

	  countSlides();
	  pagination();
	}

	function countSlides(){
	  $('#counter').html(pos+1 + ' / ' + totalSlides);
	}

	function pagination(){
	  $('#pagination-wrap ul li').removeClass('active');
	  $('#pagination-wrap ul li:eq('+pos+')').addClass('active');
	}
	
	function chat(){
		var _width = '650';
	    var _height = '380';
		var _left = Math.ceil(( window.screen.width - _width ));
		var _top = Math.ceil(( window.screen.height - _height )/2);
		var accountId2 = $(".accountId").text();
		
		if('${loginUser.aid}' === '${board.account_id}'){
			alert("자신과는 채팅이 불가능합니다.");
		} else {
		window.open("${contextPath}/createChat?accountId2=" + accountId2, "", "width=550, height=600, left=" + _left + ", top=" + _top);
		}
		
	}
	
	function report(){
		var _width = '650';
	    var _height = '380';
		var _left = Math.ceil(( window.screen.width - _width ));
		var _top = Math.ceil(( window.screen.height - _height )/2);
		var accountId2 = $(".accountId").text();
		var bid = ${board.board_id};
		
		if('${loginUser.aid}' === '${board.account_id}'){
			alert("자신은 신고가 불가능합니다.");
		} else {
		window.open("${contextPath}/board/reportUser?accountId2=" + accountId2 + "&bid=" + bid, "", "width=500, height=400, left=" + _left + ", top=" + _top);
		}		
	}
	</script>
	
</body>
</html>