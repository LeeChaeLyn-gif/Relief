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
	<h2>FAQ</h2>	
	</div>
        <div class="insertDiv">
            <form action="${ contextPath }/admin/insertFaq" method="POST" enctype="multipart/form-data" onsubmit="removeHTML();">
                <div class="form-group ">
                <input type="text" class="form-control" name="title"placeholder="제목" required>                
                </div>
                <div class="form-group">
		    		<textarea class="content" rows="3" placeholder="내용" style="resize: none; width:100%; height: 400px;" name="content"></textarea>
		  	   </div>
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
					<button type="button" class="Btn" onclick="location.href='${ contextPath }/admin/faq'">뒤로가기</button>
					<button type="submit" class="Btn">작성</button>
				</div>
            </form>
        </div>
    </div>
</body>
</html>