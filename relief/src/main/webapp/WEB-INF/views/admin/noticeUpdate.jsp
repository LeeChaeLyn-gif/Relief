<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            color: rgb(0, 51, 85);
            text-align: center;
        }
        .headDiv2{
            display: inline-block;
            bottom: 30px;
        }
        .insertDiv{
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
            margin-left: 40px;
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
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar">
	<div class="titleArea">
	<h2>공지사항</h2>	
	</div>
        <div class="insertDiv">
            <form action="${ contextPath }/admin/noticeUpdate" method="POST" onsubmit="return validate();" enctype="multipart/form-data">
                <div class="form-group ">
		    		<input type="text" class="form-control" placeholder="제목" name="title" value="${ n.title }" required>
		  		</div>
                <c:if test="${ !empty n.fileName }">
                <input type="hidden" name="fileName" value="${ n.fileName }">
                <input type="hidden" name="renameFileName" value="${ n.renameFileName }">
                </c:if>
                <input type="hidden" name="nid" value="${ n.nid }">
                <br>
                <select class="condition" name="nstatus">
                    <option value="0">-----</option>
                    <option value="1" <c:if test="${ n.nstatus == 1 }">selected</c:if>>공지</option>
                    <option value="2" <c:if test="${ n.nstatus == 2 }">selected</c:if>>광고</option>
                </select>
                <div class="form-group">
		    		<textarea class="content" rows="3" placeholder="내용" style="resize: none; width:100%; height: 400px;" name="ncontent">${ n.ncontent }</textarea>
		  	    </div>
                <div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <span class="input-group-text">첨부파일</span>
				  </div>
				  <div class="custom-file">
				    <input type="file" class="custom-file-input" id="fileName" name="uploadFile" value="${ n.renameFileName }">
				    <label class="custom-file-label" for="fileName">${ n.fileName }</label>
				  </div>
				</div>
		
		<!-- 버튼 -->
		<div class="btnArea">
			<button type="button" class="Btn" onclick="location.href='${ contextPath }/admin/notice'">뒤로가기</button>
			<button type="submit" class="Btn">수정</button>
		</div>
            </form>
        </div>
    </div>
    <script>
    	function validate(){
    		if($(".condition").val() == 0){
    			alert("공지/광고의 구분값 입력해주세요.");
    			return false;
    		}
    		if(confirm("수정하시겠습니까?")){
    			return true;
    		} else {
    			return false;
    		}
    	}

    	
    	$(function(){
    		$("input[type='file']").on('change', function(){
    			$(this).next('.custom-file-label').html(event.target.files[0].name);
    		});
    	})
    </script>
</body>
</html>