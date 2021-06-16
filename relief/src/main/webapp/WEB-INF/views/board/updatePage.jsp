<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다행 / 판매하기</title>
</head>
<style>
	* {
      box-sizing: border-box;
      }
      
   div {
         border: 1px solid transparent;
         display: block;
      }
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
	.categoryDiv,
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
	.categoryDiv2 {
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
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {-webkit-appearance: none;margin: 0;}
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
	<form action="${ contextPath }/board/update" method="POST" enctype="multipart/form-data">
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
			<div class="image2">
			<button id="btn_upload"><img src="${ contextPath }/resources/images/imageUpload.JPG"></button>
			<input type="file" onchange="previewImage(this, 'viewArea')" name="file" class="file" id="file" multiple="multiple">
			<span id="viewArea"></span>
			<h6 class="imageEtc">
				<br> 상품 이미지는 640x640에 최적화 되어 있습니다.<br> 
				- 이미지는 상품등록 시 정사각형으로 짤려서 등록됩니다.<br> 
				- 이미지를 클릭 할 경우 등록된 이미지를 삭제할 수 있습니다.<br>
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
			<input type="text" id="title2" name="title" placeholder="상품 제목을 입력해주세요. (최대 40자까지 입력가능)" maxlength="40" required>
		</div>
		<hr>
		<div class="categoryDiv">
			<h4>카테고리</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="categoryDiv2">
			<select class="category">
				<option value="0">1차 카테고리</option>
				<c:forEach items="${ list }" var="c">
					<option value="${ c.cid }">${ c.cname }</option>
				</c:forEach>
			</select> 
			<select class="category2">
			<option value="0">2차 카테고리</option>
			</select> 
			<select class="category3" name="category_id">
			<option value="0">3차 카테고리</option>
			</select>
		</div>
		<hr>
		<div class="area">
			<h4>거래지역</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="area2">
			<input type="text" readonly name="area" value="${ addr }">
		</div>
		<hr>
		<div class="state">
			<h4>상태</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="state2">
			<input type="radio" id="used" name="product_status" value="중고상품"><label for="used">중고상품</label>
			<input type="radio" id="new" name="product_status" value="새상품"><label for="new">새상품</label>
		</div>
		<hr>
		<div class="change">
			<h4>교환</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="change2">
			<input type="radio" id="ok" name="exchange_status" value="N"><label for="ok">교환불가</label>
			<input type="radio" id="no" name="exchange_status" value="Y"><label for="no">교환가능</label>
		</div>
		<hr>
		<div class="price">
			<h4>가격</h4>
			<h4 class="star">*</h4>
			</div>
			<div class="price2">
			<input type="number" min="0" name="price"><h6>원</h6>
			<input type="checkBox" id="price" name="price_status" value="Y"><label for="price">가격협의 가능</label>
		</div>
		<hr>
		<div class="etc">
			<h4>설명</h4>
		</div>
		<div class="etc2">
			<textarea id="etcText" name="content" style="resize: none;"></textarea>
		</div>
		<hr>
		<div class="number">
			<h4>수량</h4>
			</div>
			<div class="number2">
			<input type="number" min="1" name="amount">
			<h6>개</h6>
		</div>
		<div class="btnArea">
			<button class="submitBtn" type="submit">등록하기</button>
		</div>
	</div>
	</form>
</body>
<script>
	var fileArr;
	var fileInfoArr=[];

	$(function () {

    	$('#btn_upload').click(function (e) {

    	e.preventDefault();

    	$('#file').click();
      
    	});

    });
    
	
	function fileRemove(index) {
	    console.log("index: "+index);
	    fileInfoArr.splice(index,1);
	 
	    var imgId="#img_id_"+index;
	    $(imgId).remove();
	    console.log(fileInfoArr);
	}
	
	function previewImage(targetObj, viewArea) {
	    var files=targetObj.files;
	    fileArr=Array.prototype.slice.call(files);
	    
	    var preview = document.getElementById(viewArea); //div id
	    var ua = window.navigator.userAgent;

	    //ie일때(IE8 이하에서만 작동)
	    if (ua.indexOf("MSIE") > -1) {
	        targetObj.select();
	        try {
	            var src = document.selection.createRange().text; // get file full path(IE9, IE10에서 사용 불가)
	            var ie_preview_error = document.getElementById("ie_preview_error_" + viewArea);
	 
	 
	            if (ie_preview_error) {
	                preview.removeChild(ie_preview_error); //error가 있으면 delete
	            }
	 
	            var img = document.getElementById(viewArea); //이미지가 뿌려질 곳
	 
	            //이미지 로딩, sizingMethod는 div에 맞춰서 사이즈를 자동조절 하는 역할
	            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+src+"', sizingMethod='scale')";
	        } catch (e) {
	            if (!document.getElementById("ie_preview_error_" + viewArea)) {
	                var info = document.createElement("<p>");
	                info.id = "ie_preview_error_" + viewArea;
	                info.innerHTML = e.name;
	                preview.insertBefore(info, null);
	            }
	        }
	        //ie가 아닐때(크롬, 사파리, FF)
	    } else {
	        var files = targetObj.files;
	        for ( var i = 0; i < files.length; i++) {
	            var file = files[i];
	            fileInfoArr.push(file);
	 
	            var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
	            if (!file.type.match(imageType))
	                continue;
	            // var prevImg = document.getElementById("prev_" + View_area); //이전에 미리보기가 있다면 삭제
	            // if (prevImg) {
	            //     preview.removeChild(prevImg);
	            // }
	 
	            var span=document.createElement('span');
	            span.id="img_id_" +i;
	            span.style.width = '160px';
	            span.style.height = '160px';
	            preview.appendChild(span);
	 
	            var img = document.createElement("img");
	            img.className="addImg";
	            img.classList.add("obj");
	            img.file = file;
	            img.style.width='inherit';
	            img.style.height='inherit';
	            img.style.cursor='pointer';
	            const idx=i;
	            img.onclick=()=>fileRemove(idx);   // 이미지를 클릭했을 때.
	            span.appendChild(img);
	 
	            if (window.FileReader) { // FireFox, Chrome, Opera 확인.
	                var reader = new FileReader();
	                reader.onloadend = (function(aImg) {
	                    return function(e) {
	                        aImg.src = e.target.result;
	                    };
	                })(img);
	                reader.readAsDataURL(file);
	            } else { // safari is not supported FileReader
	                //alert('not supported FileReader');
	                if (!document.getElementById("sfr_preview_error_"
	                    + View_area)) {
	                    var info = document.createElement("p");
	                    info.id = "sfr_preview_error_" + viewArea;
	                    info.innerHTML = "not supported FileReader";
	                    preview.insertBefore(info, null);
	                }
	            }
	        }
	    }
	}
	
	function dataSubmit() {
	    var token = $("meta[name='_csrf']").attr("content");
	    var header = $("meta[name='_csrf_header']").attr("content");
	 
	    var data=new FormData($("#storeAddForm")[0]);
	 
	    $.ajax({
	        beforeSend: function(xhr){
	            xhr.setRequestHeader(header,token);
	        },
	        url: "${contextPath}/board/url",
	        data: data,
	        processData:false,
	        contentType:false,
	        enctype:'multipart/form-data',
	        type:"POST",
	    }).done(function (fragment) {
	        $("#resultDiv").replaceWith(fragment);
	    });
	}

	$(".category").on("change", function(){
		var cid = $(".category").val();
		$.ajax({
			url:"${contextPath}/board/category",
			data: {cid:cid},
			type: "get",
			dataType:"json",
			success : function(data){
				console.log(data);
				
				$(".category2").empty();
				
				var option2="<option>2차 카테고리</option>";
				var option = "";
				$(".category2").append(option2);
				for(var i in data.list){
					option = "<option value=" + "'" + data.list[i].cid + "'" ;
					option += ">" + data.list[i].cname + "</option>";
					$(".category2").append(option);
				}
				
			},
			error : function(e){
				alert("잘못 선택하셨습니다.");
			}
		});
	});
	
	$(".category2").on("change", function(){
		var cid = $(".category2").val();
		$.ajax({
			url:"${contextPath}/board/category",
			data: {cid:cid},
			type: "get",
			dataType:"json",
			success : function(data){
				console.log(data);
				
				$(".category3").empty();
				
				var option2="<option>3차 카테고리</option>";
				var option = "";
				$(".category3").append(option2);
				for(var i in data.list){
					option = "<option value=" + "'" + data.list[i].cid + "'" ;
					option += ">" + data.list[i].cname + "</option>";
					$(".category3").append(option);
				}
				
			},
			error : function(e){
				alert("잘못 선택하셨습니다.");
			}
		});
	});
	
</script>
</html>