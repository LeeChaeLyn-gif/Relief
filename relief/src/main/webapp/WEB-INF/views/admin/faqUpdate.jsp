<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
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
            color: rgb(0, 51, 85);
            text-align: center;
        }
        .headDiv2{
            display: inline-block;
            bottom: 30px;
        }
        .insertDiv{
            border: 1px solid lightgray;
            width: 50%;
            height: 600px;
            text-align : center;
            margin-left : 20%;
            margin-top : 1%;
        }
        .adImg{
            margin-left: 100px;
        }
        .condition{
            width: 150px;
            height: 40px;
            margin-top : 10px;
            margin-left: 120px;
        }
        .content{
            width: 350px;
            height: 300px;
            margin-top : 10px;
            margin-left: 20px;
        }
        .Btn{
            background-color: rgb(0, 51, 85);
            color: white;
            width: 100px;
            height: 30px;
            border-radius: 5px;
            border: 0px;
            margin-left: 148px;
        }
        #imgVal{
        	text-align : center;
        	display : block;
        	height : 20px;
        }
    </style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar">
	<div class="title">
	<h1>FAQ</h1>	
	</div>
        <div class="insertDiv">
            <form action="${ contextPath }/admin/faqUpdate" method="POST" enctype="multipart/form-data" onsubmit="removeHTML();">
            	<div class="form-group ">
                <input type="text" class="form-control" name="title"placeholder="제목" value="${ f.title }" required>
                </div>

                <c:if test="${ !empty f.fileName }">
                <input type="hidden" name="fileName" value="${ f.fileName }">
                <input type="hidden" name="renameFileName" value="${ f.renameFileName }">
                </c:if>
                
                <input type="hidden" name="fid" value="${ f.fid }">
                
                <div class="form-group">
                <textarea id="summernote" class="content" style="resize: none; width:100%; name="content">${ f.content }</textarea>
                </div>
                <div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <span class="input-group-text">첨부파일</span>
				  </div>
				  <div class="custom-file">
				    <input type="file" class="custom-file-input" id="fileName" name="uploadFile" value="${ f.renameFileName }">
				    <label class="custom-file-label" for="fileName">${ f.fileName }</label>
				  </div>
				</div>
                
				<!-- 버튼 -->
				<div class="text-right marginTop">
					<button type="button" class="btn btn-primary btsSize marginLeft" onclick="location.href='${ contextPath }/admin/faqDetail?fid=${ f.fid }'">뒤로가기</button>
					<button type="submit" class="btn btn-primary btsSize marginLeft" onclick="removeHTML()">수정</button>
				</div>
            </form>
        </div>
    </div>
    <script>
	    $('#summernote').summernote({
	    	placeholder: '내용을 입력해주세요.', 
	    	tabsize: 2,
	    	minHeight: null,
	    	maxHeight: null,
	    	lang : 'ko-KR',
	    	height: 370 });
	    
    	function removeHTML(){
    		var str = $(".content").val();
    		str = str.replace(/<br\/>/ig, "\n");
    		str = str.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
			$(".content").val(str);
    	}
    	$(function () {

    		$('#btn-upload').click(function (e) {

    		e.preventDefault();

    		$('#file').click();
				
    		});

    		})
    	var imgVal = document.getElementById("imgVal");
    	$("#file").on("change", function(){
    		if(window.FileReader){
    		      var filename = $(this)[0].files[0].name;
    		    } else {
    		      var filename = $(this).val().split('/').pop().split('\\').pop();
    		    }
				console.log(filename);
    		    imgVal.innerHTML = filename;
    	})
    </script>
</body>
</html>