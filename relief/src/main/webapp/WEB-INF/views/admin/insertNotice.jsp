<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
    	.mainbar{
			width : 70%;
			float : left;
		}
		.titleArea{
			width : 700px;
			height : 52px;
			float : left;
			background-color: #597a96;
		}
		
		h2{
			color : white;
			font-weight : bold;
			text-align : center;
			padding-top : 7px;
		}
        .headDiv{
            display: inline-block;
        }
        .homeimg{
            width: 200px;
            height: 100px;
            display: inline-block;
            margin-left: 100px;
        }
        .adminPage{
            display: inline-block;
            margin-bottom: 0px;
            margin-top: 0px;
            margin-left: 20px;
            color: #597a96;
            text-align: center;
        }
        .headDiv2{
            display: inline-block;
            bottom: 30px;
        }
        .insertDiv{
            border: 1px solid lightgray;
            width: 700px;
            height: 675px;
            text-align : center;
            margin-top : 1%;
        }
        .title1{
            width: 300px;
            height: 40px;
            border: 1px solid lightgray;
            border-radius: 5px;
            margin-top: 40px;
            font-size: large;
        }
        .adImg{
            margin-left: 100px;
        }
        .condition{
            width: 150px;
            height: 40px;
            margin-top : 10px;
        }
        .content{
            width: 700px;
            height: 300px;
            margin-top : 10px;
            margin-left: 20px;
        }
        .Btn{
            background-color: #597a96;
            width: 100px;
            border-radius: 5px;
            color: white;
        }
        #imgVal{
        	text-align : center;
        	display : block;
        	height : 20px;
        }
        .btnArea{
        	width : 700px;
        	text-align : center;
        }
    </style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar">
	<div class="titleArea">
	<h2>공지사항</h2>	
	</div>
        <div class="insertDiv">
            <form action="${ contextPath }/admin/insertNotice" method="POST" onsubmit="return validate();" enctype="multipart/form-data">
            	<div class="form-group ">
		    		<input type="text" class="form-control" placeholder="제목" name="title">
		  		</div>
                <select class="condition" name="nstatus">
                    <option value="0">-----</option>
                    <option value="1">공지</option>
                    <option value="2">광고</option>
                </select>
               <div class="form-group">
		    		<textarea id="summernote" class="content" rows="3" placeholder="내용" style="resize: none; width:100%; height: 400px;" name="ncontent"></textarea>
		  	   </div>
                <!-- 첨부파일 -->
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" id="fileName" name="uploadFile">
		    <label class="custom-file-label" for="fileName">파일선택</label>
		  </div>
		</div>
		
		<!-- 버튼 -->
		<div class="btnArea">
			<button type="button" class="Btn" onclick="location.href='${ contextPath }/admin/notice'">뒤로가기</button>
			<button type="submit" class="Btn" onclick="removeHTML()">작성</button>
		</div>
            </form>
        </div>
    </div>
    <script>
	    $('#summernote').summernote({
	    	placeholder: '답변을 입력해주세요.', 
	    	tabsize: 2,
	    	minHeight: null,
	    	maxHeight: null,
	    	lang : 'ko-KR',
	    	height: 370 });
	    
    	function validate(){
    		if($(".condition").val() == 0){
    			alert("공지/광고의 구분값 입력해주세요.");
    			return false;
    		}
    		return true;
    	}
    	
    	function removeHTML(){
    		var str = $(".content").val();
    		str = str.replace(/<br\/>/ig, "\n");
    		str = str.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
			$(".content").val(str);
    	}
    	
    	$(function(){
    		$("input[type='file']").on('change', function(){
    			$(this).next('.custom-file-label').html(event.target.files[0].name);
    		});
    	})
    </script>
</body>
</html>