<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        .categoryRadio{
            margin-left: 400px;
        }
        .c_name{
            width: 300px;
            height: 40px;
            border: 1px solid lightgray;
            border-radius: 5px;
            margin-left: 480px;
            margin-top: 40px;
            font-size: large;
        }
        .condition{
            width: 150px;
            height: 40px;
            margin-top : 10px;
            margin-left: 550px;
        }
        .btn{
            background-color: rgb(0, 51, 85);
            color: white;
            width: 100px;
            height: 30px;
            border-radius: 5px;
            border: 0px;
        }
        h3{
        	text-align : center;
        	margin-right : 300px;
        }
        </style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar"><h1>카테고리</h1>
        <form method="POST" action="${ contextPath }/admin/insertCategory">
        <input type="radio" name="cgroup" id="1" value="0" checked class="categoryRadio"><label for="1">1차 카테고리 등록</label>
        <input type="radio" name="cgroup" id="2" value="1"><label for="2">2차 카테고리 등록</label>
        <input type="radio" name="cgroup" id="3" value="2"><label for="3">3차 카테고리 등록</label>
            <input type="text" name="cname" class="c_name" placeholder="추가할 카테고리명을 입력해주세요.">
            <br>
            <h3>선행 카테고리 선택</h3>
            <select class="condition" name="cid2" disabled>
                <option>-----</option>
            </select>
            <input type="submit" value="확인" class="btn">
        </form>
    </div>
    <script>
       $(function(){
           $("input[name='cgroup']").on('change', function(){
                if($(this).val() == 0){
                    $(".condition").attr("disabled", true)
                    $("input[name='cname']").val("");
                    $('.condition').children('option').remove();
                } else if($(this).val() == 1){
                    $(".condition").attr("disabled", false)
                    $("input[name='cname']").val("");
                    var cgroup = $("input[name='cgroup']:checked").val();
                    
                    $.ajax({
                    	url : "${ contextPath }/admin/selectcnameList",
                    	data : { cgroup : cgroup },
                    	type : "get",
                    	dataType : "json",
                    	success : function(data){
                    		console.log(data);
                    		$('.condition').empty();
                    		var option = "";
                    		for(var i in data.list){
                    			option = $("<option value=" + data.list[i].cid + ">"+ data.list[i].cname + "</option>");
                    			$(".condition").append(option);
                    		}	
                    	},
                    	error : function(e){
                    		alert("error code :" + e.status + "\n"
    								+ "message : " + e.responseText);
                    	}
                    });
                } else if($(this).val() == 2){
                	$(".condition").attr("disabled", false)
                    $("input[name=cname]").val("");
                	var cgroup = $("input[name='cgroup']:checked").val();
                	
                	$.ajax({
                    	url : "${ contextPath }/admin/selectcnameList",
                    	data : { cgroup : cgroup },
                    	type : "get",
                    	dataType : "json",
                    	success : function(data){
                    		console.log(data);
                    		$('.condition').empty();
                    		var option = "";
                    		for(var i in data.list){
                    			option = $("<option value=" + data.list[i].cid + ">"+ data.list[i].cname + "</option>");
                    			$(".condition").append(option);
                    		}	
                    	},
                    	error : function(e){
                    		alert("error code :" + e.status + "\n"
    								+ "message : " + e.responseText);
                    	}
                    });
                }
           });
       })
    </script>
</body>
</html>