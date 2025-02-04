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
		.tableArea{
			width : 700px;
			float : left;
			display : block;
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
        .insertBtn{
            background-color: #597a96;
            color: white;
            width: 150px;
            height: 50px;
            border-radius: 5px;
            margin-right : 25px;
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
        	width : 700px;
        	text-align : center;
        }
        .btn1{
        	background-color: #597a96;
            color: white;
            width: 100px;
            height: 30px;
            border-radius: 5px;
        }
        .noticeBoard{
        	width : 100%;
        }
</style>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
		
	<div class="mainbar">
		<div class="titleArea">
			<h2>카테고리</h2>	
		</div>
	<div class="tableArea">
    <table class="noticeBoard">
        <tr>
            <th>NO.</th>
            <th>카테고리명</th>
            <th>카테고리 분류</th>
            <th>수정</th>
            <th>삭제</th>
        </tr>
        <c:forEach items="${ cList }" var="c">
        <tr>
            <td>${ c.cid }</td>
            <td>${ c.cname }</td>
            <td>${ c.cgroup }</td>
            <td><button class="btn1" onclick="location.href='${ contextPath }/admin/categoryUpdate?cid=${ c.cid }'">수정</button></td>
            <td><button class="btn1" onclick="location.href='${ contextPath }/admin/categoryDelete?cid=${ c.cid }'">삭제</button></td>
        </tr>
        </c:forEach>
        
    </table>
    </div>
    <br>
    <br>
    <div class="btnArea">
    <!-- 검색창 -->
    <form method="GET" action="${ contextPath }/admin/cSearch">
    <select class="searchCondition" name="searchCondition">
        <option value="all">전체</option>
        <option value="cid">카테고리번호</option>
        <option value="cname">카테고리이름</option>
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
    	<c:url var="before" value="/admin/category">
    		<c:param name="page" value="${ pi.currentPage - 1 }"/>
    	</c:url>
    	<c:url var="before2" value="/admin/cSearch">
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
    	<c:url var="after" value="/admin/category">
    		<c:param name="page" value="${ pi.currentPage + 1 }"/>
    	</c:url>
    	<c:url var="after2" value="/admin/cSearch">
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
    
    <button class="insertBtn">카테고리 등록</button>
    </div>
    </div>
    <script>
    	$(".insertBtn").on("click", function(){
    		location.href="${ contextPath }/admin/insertCategory";
    	});
    </script>
</body>
</html>