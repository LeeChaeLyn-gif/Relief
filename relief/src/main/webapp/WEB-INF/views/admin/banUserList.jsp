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
        .noticeBoard tr th{
            background-color: lightgray;
            height: 50px;
            width: 300px;
            text-align: center;
            font-weight: bold;
            padding: 0px;
        }
        .noticeBoard tr td{
            height: 50px;
            text-align: center;
            font-weight: bold;
            border-bottom: 1px solid gray;
            padding: 0px;
            cursor : pointer;
        }
        .noticeInsertBtn{
            background-color: #597a96;
            color: white;
            width: 150px;
            height: 50px;
            border-radius: 5px;

        }
        .searchCondition{
            width: 100px;
            height: 30px;
        }
        .searchValue{
            width: 300px;
            height: 23px;
        }
        .searchBtn{
            background-color: #597a96;
            color: white;
            width: 100px;
            height: 30px;
            border-radius: 5px;
        }
        .prev{
            border-radius: 10px;
            background-color: lightgray;
            width: 120px;
            height: 40px;
            color: gray;
            outline: 0;
            border: 0;
        }
        .next{
            border-radius: 10px;
            background-color: lightgray;
            width: 120px;
            height: 40px;
            color: gray;
            outline: 0;
            border: 0;
        }
        .btnArea{
        	text-align : center;
        }
        .noticeBoard{
        	width : 57.4%;
        }
</style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="mainbar">
	<div class="title">
	<h1>제재회원 목록</h1>	
	</div>
    <table class="noticeBoard">
        <tr>
            <th>NO.</th>
            <th>ID</th>
            <th>정지해제 날짜</th>
            <th>신고일</th>
            <th>check</th>
        </tr>
        <c:forEach items="${ aList }" var="a">
        <tr>
            <td>${ a.rid }</td>
            <td>${ a.aid }</td>
            <td>${ a.sanctions }</td>
            <td>${ a.reportDate }</td>
            <td><input type="checkbox" value="${ a.aid }" name="aid"></td>
        </tr>
        </c:forEach>
        
    </table>
    <br>
    <br>
    <div class="btnArea">
    <!-- 검색창 -->
    <form method="GET" action="${ contextPath }/admin/bSearch">
    <select class="searchCondition" name="searchCondition">
        <option value="all">전체</option>
        <option value="aid">ID</option>
        <option value="rid">NO</option>
    </select>
    <input type="text" class="searchValue" name="searchValue" placeholder="검색어를 입력하세요.">
    <button type="submit" class="searchBtn">검색</button>
    </form>
    <br>
    <!-- 페이징 바 -->
    <c:if test="${ pi.currentPage <= 1 }">
    	<button class="prev">&lt;이전으로</button>
    </c:if>
    <c:if test="${ pi.currentPage > 1 }">
    	<c:url var="before" value="/admin/block">
    		<c:param name="page" value="${ pi.currentPage - 1 }"/>
    	</c:url>
    	<c:url var="before2" value="/admin/bSearch">
    		<c:param name="page" value="${ pi.currentPage - 1 }"/>
    		<c:param name="searchCondition" value="${ search.searchCondition }"/>
    		<c:param name="searchValue" value="${ search.searchValue }"/>
    	</c:url>
    	<c:choose>
    		<c:when test="${ !empty search }">
    			<button class="prev" onclick="location.href='${ before2 }'">&lt;이전으로</button>
    		</c:when>
    		<c:otherwise>
    			<button class="prev" onclick="location.href='${ before }'">&lt;이전으로</button>
    		</c:otherwise>
    	</c:choose>
    </c:if>
    <c:if test="${ pi.currentPage >= pi.maxPage }">
    	<button class="next">다음으로&gt;</button>
    </c:if>
    <c:if test="${ pi.currentPage < pi.maxPage }">
    	<c:url var="after" value="/admin/block">
    		<c:param name="page" value="${ pi.currentPage + 1 }"/>
    	</c:url>
    	<c:url var="after2" value="/admin/bSearch">
    		<c:param name="page" value="${ pi.currentPage + 1 }"/>
    		<c:param name="searchCondition" value="${ search.searchCondition }"/>
    		<c:param name="searchValue" value="${ search.searchValue }"/>
    	</c:url>
    	<c:choose>
    		<c:when test="${ !empty search }">
    			<button class="next" onclick="location.href='${ after2 }'">다음으로&gt;</button>
    		</c:when>
    		<c:otherwise>
    			<button class="next" onclick="location.href='${ after }'">다음으로&gt;</button>
    		</c:otherwise>
    	</c:choose>
    </c:if>
    <br><br>
    
    <button class="noticeInsertBtn">정지 해제</button>
    </div>
    </div>
    <script>
    	$(".noticeInsertBtn").on("click", function(){
    		var sArr = [];
    		$("input[name='aid']:checked").each(function(i){
    			sArr.push($(this).val());
    		})
    		if(sArr.length < 1){
    			alert("해제할 유저가 없습니다.");
    		}
    		if(sArr.length > 0){
    		location.href="${ contextPath }/admin/unbanUser?sArr=" + sArr;    			
    		}
    	});
    </script>
</body>
</html>