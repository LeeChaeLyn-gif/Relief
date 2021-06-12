<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다행 / 판매하기</title>
</head>
<style>
    .star{
        color:red;
    }
    h4,h5, h6{
        display: inline;
    }
    .imageEtc{
        color:royalblue;
    }
    .outer {
        text-align: left;
		width:60%;
		margin: 0 auto;
		margin-bottom:10%;
    }
    .file {
    	display:none;
    }
	#btn_upload{
		outline :0;
		background-color: transparent !important;
   	 	background-image: none !important;
    	border-color: transparent;
    	border: none;
    	color: #FFFFFF;
		width:170px;
		height:170px;
	}
	.etc,
	.title,
	.price,
	.number,
	.state,
	.change {
		display:inline-block;
		width:70px;
	}
	.category,
	.area {
		display:inline-block;
		width:110px;
	}
	.image {
		width:300px;
	}
	.area2
	 {
		display:inline-block;
	}
	.state2,
	.change2{
		display:inline-block;
		margin-left:4%;
	}
	.number2 {
		display:inline-block;
		margin-left:3%;
	}
	.title2 {
		display:inline-block;
		margin-left:5%;
	}
	#title2 {
		width:500px;
	}
	.image2 {
		display:inline-block;
		width:600px;
		margin-left:65%;
		margin-top:-10%;
	}
	.category2 {
		display:inline-block;
		width:600px;
		margin-top:-10%;
	}
	.price2 {
		display:inline-block;
		margin-top:-10%;
		margin-left:3%;
	}
	#etcText{
		display:inline-block;
		margin-top:-3%;
		margin-left:10%;	
		width:70%;
		height:100px;
	}
	.submitBtn {
		background-color:rgb(52, 73, 94);
		color:white;
		border:none;
		width:100px;
		height:40px;
		float:right;
		margin-top:5%;
		border-radius:5px 5px 5px 5px;
	}
</style>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<jsp:include page="../common/sidebar.jsp" /><br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="outer">
		<div class="basicInfo">
			<h4>기본정보</h4>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<h4 class="star">*</h4>
			<h6>필수항목</h6>
		</div>
		<hr>
		<div class="image">
			<h4>상품이미지</h4>
			<h4 class="star">*</h4>
			<h5>(0/12)</h5>
			<div class="image2">
			<button id="btn_upload"><img src="${ contextPath }/resources/images/imageUpload.JPG"></button>
			<input type="file" class="file" id="file" multiple="multiple">
			<h6 class="imageEtc">
				<br> 상품 이미지는 640x640에 최적화 되어 있습니다.<br> 
				- 이미지는 상품등록 시 정사각형으로 짤려서 등록됩니다.<br> 
				- 이미지를 클릭 할 경우 원본이미지를 확인할 수 있습니다.<br>
				- 큰 이미지일경우 이미지가 깨지는 경우가 발생할 수 있습니다.<br> 
				최대 지원 사이즈인 640 X 640 으로 리사이즈 해서 올려주세요.(개당 이미지 최대 10M)
			</h6>
			</div>
		</div>
		<hr>
		<div class="title">
			<h4>제목</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="title2">
			<input type="text" id="title2" placeholder="상품 제목을 입력해주세요. (최대 40자까지 입력가능)" maxlength="40">
		</div>
		<hr>
		<div class="category">
			<h4>카테고리</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="category2">
			<select>
				<option>-------</option>
			</select> <select>
				<option>-------</option>
			</select> <select>
				<option>-------</option>
			</select>
		</div>
		<hr>
		<div class="area">
			<h4>거래지역</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="area2">
			<input type="text" readonly>
		</div>
		<hr>
		<div class="state">
			<h4>상태</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="state2">
			<input type="radio" id="used" name="product" value=""><label for="used">중고상품</label>
			<input type="radio" id="new" name="product" value=""><label for="new">새상품</label>
		</div>
		<hr>
		<div class="change">
			<h4>교환</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="change2">
			<input type="radio" id="ok" name="change" value=""><label for="ok">교환불가</label>
			<input type="radio" id="no" name="change" value=""><label for="no">교환가능</label>
		</div>
		<hr>
		<div class="price">
			<h4>가격</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="price2">
			<input type="text"><h6>원</h6>
			<input type="checkBox" id="price"><label for="price">가격협의 가능</label>
		</div>
		<hr>
		<div class="etc">
			<h4>설명</h4>
		</div>
		<div class="etc2">
			<textarea id="etcText" style="resize: none;">

			</textarea>
		</div>
		<hr>
		<div class="number">
			<h4>수량</h4>
			</div>
			<div class="number2">
			<input type="text">
			<h6>개</h6>
		</div>
		<div class="btnArea">
			<button class="submitBtn" type="submit">등록하기</button>
		</div>
	</div>
</body>
<script>
$(function () {

    $('#btn_upload').click(function (e) {

    e.preventDefault();

    $('#file').click();
      
    });

    })
</script>
</html>