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
        .navbar1 ul li a{
            text-decoration: none;
            color: white;
            background-color: rgb(0, 51, 85);
            display: block;
            width: 300px;
            height: 50px;
        }
        .navbar1 ul li{
            float: left;
        }
        .navbar1{
            width: 50px;
        }
        ul{
            list-style:none;
        }
        .navbar1 ul li a h2{
            text-align: center;
            margin: 0px;
            padding: 5px;
        }
        .navbar1 ul li a:hover{
            background-color: red;
        }
        .mainbar h1{
            color: white;
            background-color: rgb(0, 51, 85);
            margin: 0px;
            margin-left: 340px;
        }
        .insertDiv{
            border: 1px solid lightgray;
            width: 400px;
            height: 650px;
            margin-left: 850px;
        }
        .title{
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
	<div class="mainbar"><h1>공지사항</h1>
        <div class="insertDiv">
            <form action="${ contextPath }/admin/noticeUpdate" method="POST" onsubmit="return validate();" enctype="multipart/form-data">
                <input type="text" class="title" name="title"placeholder="제목" value="${ n.title }" required>
                <br><br>
                <button type="button" class="Btn" id="btn-upload">이미지 변경</button>
                <p id="imgVal">
                <c:if test="${ !empty n.fileName }">
                ${ n.fileName }
                <input type="hidden" name="fileName" value="${ n.fileName }">
                <input type="hidden" name="renameFileName" value="${ n.renameFileName }">
                </c:if>
                </p>
                <input type="file" class="adImg" name="uploadFile" id="file">
                <input type="hidden" name="nid" value="${ n.nid }">
                <br>
                <select class="condition" name="nstatus">
                    <option value="0">-----</option>
                    <option value="1" <c:if test="${ n.nstatus == 1 }">selected</c:if>>공지</option>
                    <option value="2" <c:if test="${ n.nstatus == 2 }">selected</c:if>>광고</option>
                </select>
                <br>
                <textarea class="content" name="ncontent">${ n.ncontent }</textarea>
                <br>
                <button type="submit" class="Btn">수정</button>
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