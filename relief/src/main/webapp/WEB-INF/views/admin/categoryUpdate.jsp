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
            color: #597a96;
            text-align: center;
        }
        .headDiv2{
            display: inline-block;
            bottom: 30px;
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
        .btn1{
            background-color: #597a96;
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
	<div class="mainbar">
	<div class="title">
	<h1>카테고리</h1>	
	</div>
        <form method="POST" action="${ contextPath }/admin/updateCategory" onsubmit="return validate();">
        <input type="radio" name="cgroup" id="1" value="0" <c:if test="${ c.cgroup == 1 }">checked</c:if> class="categoryRadio"><label for="1">1차 카테고리 등록</label>
        <input type="radio" name="cgroup" id="2" value="1" <c:if test="${ c.cgroup == 2 }">checked</c:if>><label for="2">2차 카테고리 등록</label>
        <input type="radio" name="cgroup" id="3" value="2" <c:if test="${ c.cgroup == 3 }">checked</c:if>><label for="3">3차 카테고리 등록</label>
            <input type="text" name="cname" class="c_name" placeholder="추가할 카테고리명을 입력해주세요." value="${ c.cname }">
            <br>
            <h3>선행 카테고리 선택</h3>
            <input type="hidden" id="val" value="${ c.cid2 }">
            <select class="condition" name="cid2">
                <option>-----</option>
            </select>
            <input type="hidden" name="cid" value="${ c.cid }">
            <input type="submit" value="확인" class="btn1">
        </form>
    </div>
    <script>
       $(function(){ 
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
           			option = "<option value=" +"'"+ data.list[i].cid + "'";
           			if($("#val").val() == data.list[i].cid){
        				option +="selected";
        			}
           			option += ">"+ data.list[i].cname + "</option>";
           			$(".condition").append(option);
           		}	
           	},
           	error : function(e){
           		alert("error code :" + e.status + "\n"
							+ "message : " + e.responseText);
           	}
           });
    	   
           $("input[name='cgroup']").on('change', function(){
                if($(this).val() == 0){
                    $(".condition").attr("disabled", true)
                    $('.condition').children('option').remove();
                } else if($(this).val() == 1){
                    $(".condition").attr("disabled", false)
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
       
       function validate(){
    	   var cid = $("input[name=cid]").val();
    	   var flag = true;
    	   $.ajax({
    		   url : "${ contextPath }/admin/checkCategory",
    		   data : { cid : cid },
    		   type : "get",
    		   async : false,
    		   success : function(data){
    			   console.log(data);
    			   if(data == "fail"){
    				   var msg = "하위 카테고리가 존재 합니다.";
    				   alert(msg);
    				   flag = false;
    			   } else if(data == "success"){
    				   flag = true;
    			   }
    		   },
    		   error : function(e){
    			   console.log(e);
    		   }
    	   });
    	   return flag;
       }
    </script>
</body>
</html>