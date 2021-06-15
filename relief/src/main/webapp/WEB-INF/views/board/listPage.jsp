<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
     body{
             height: 100%;
             width: 100%;
         }
         .result{
             border: 2px solid lightgray;
             width: 80%;
             height: 80%;
             margin-left : 10%;
         }

         .searchValue{
             margin: 0 auto;
             width: 50px;
             display: inline-block;
             color: red;
             text-align: center;
         }
         .h5{
             color: lightgray;
             display: inline-block;
             margin: 0 auto;
             width: 100px;
         }
         .desc{
             text-decoration-line: none;
             float: right;
             margin: 5px;
             color: black;
         }
         .searchResult{
             float: left;
         }
         .line{
             margin-top: 80px;
             text-align: center;
         }
         .elements{
             height: 300px;
             width: 300px;
             border: 1px solid lightgray;
             display: inline-block;
             margin-bottom: 10px;
             color : black;
         }
         .img{
            height: 150px;
            width: 300px;
         }
         .btnArea{
            text-align: center;
            margin-right: 100px;
         }
         .btn{
             background-color: white;
             border: 0px;
             margin: 2px;
             border-radius: 5px;
             width: 30px;
             height: 30px;
         }
         .btn:hover{
             background-color: red;
             color: white;
         }
         hr{
             margin: 0 auto;
             margin-top: 30px;
         }
         .addr{
            margin-top: 10px;
         }
         h5{
             display: inline-block;
         }
         .content{
         }
         .price{

         }
         .resultP{
            margin: 0 auto;
             width: 150px;
             float: left;
         }
         .material-icons{
            color: rgb(0, 51, 85);
         }
         .side-menu{
         	margin-left : 1600px;
         }
    </style>
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<jsp:include page="../common/sidebar.jsp" /><br>
	<br><br><br><br><br><br><br><br><br>
	<div class="main">
        <div class="result">
            <div class="searchResult">
                <p class="resultP"><h5 class="searchValue">
                <c:choose>
                	<c:when test="${ !empty searchValue }">
                		${ searchValue }
                	</c:when>
                	<c:otherwise>
                		${ categoryName }
                	</c:otherwise>
                </c:choose></h5>의 검색결과&nbsp;<h5 class="h5">${ listCount }개의 결과</h5></p>   
                <select name="category1" id="category1">
                <c:forEach items="${ cList }" var="c">
                	<c:if test="${ c.cgroup == 1 }">
                		 <option value="${ c.cid }" <c:if test="${ c.cid == firstCid }">selected</c:if>>
                		 ${ c.cname }
                		 </option>              	
                	</c:if>
                </c:forEach>
                </select>
                
                <select name="category2" id="category2">
                <c:forEach items="${ cList }" var="c">
                	<c:if test="${ c.cgroup == 2 }">
                		 <option value="${ c.cid }" <c:if test="${ c.cid == secondCid }">selected</c:if>>
                		 ${ c.cname }
                		 </option>              	
                	</c:if>
                </c:forEach>
                </select>
                
                <select name="category3" id="category3">
                <c:forEach items="${ cList }" var="c">
                	<c:if test="${ c.cgroup == 3 }">
                		 <option value="${ c.cid }" <c:if test="${ c.cid == cid }">selected</c:if>>
                		 ${ c.cname }
                		 </option>              	
                	</c:if>
                </c:forEach>
                </select>
            </div>
            <div class="sort">
            	<c:choose>
            		<c:when test="${ !empty searchValue }">
            			<a href="${ contextPath }/board/sort?sortValue=desc&searchValue=${searchValue}" class="desc">가격낮은순</a>
            			<a href="${ contextPath }/board/sort?sortValue=asc&searchValue=${searchValue}" class="desc">가격높은순</a>
            		</c:when>
            		<c:otherwise>
            			
            		</c:otherwise>
            	</c:choose>
                
                
            </div>
            <div class="line">
            	<c:forEach items="${ bList }" var="b">
            		<a class="elements" href="${ contextPath }/board/detail?board_id=${ b.board_id }">
		                <img src="${ contextPath }/resources/buploadFiles/${ b.renameFileName }" class="img">
	                    <p>${ b.title }</p>
	                    <p>${ b.price }원</p>
	                    <hr>
	                    <div class="addr">
		                    <span class="material-icons"> add_location_alt</span>
		                    <small>${ b.area }</small>
	                    </div>
	                </a>
            	</c:forEach>        
            </div>
            <br>
        </div>
            <div class="btnArea">
            <!-- 이전 -->
	            <c:if test="${ pi.currentPage <= 1 }">
	                <button class="btn">&lt;&lt;</button>
	            </c:if>
	            <c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="/board/list">
							<c:param name="searchValue" value="${ searchValue }"/>
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
						</c:url>
						<c:url var="before2" value="/board/sort">
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
							<c:param name="searchValue" value="${ searchValue }"/>
							<c:param name="sortValue" value="${ sortValue }"/>
						</c:url>
						<c:url var="before3" value="/board/category1">
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
							<c:param name="cid" value="${ categoryValue }"/>
						</c:url>
						<c:url var="before4" value="/board/category2">
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
							<c:param name="cid" value="${ categoryValue2 }"/>
						</c:url>
						<c:url var="before5" value="/board/category3">
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
							<c:param name="cid" value="${ categoryValue3 }"/>
						</c:url>
						<c:choose>
							<c:when test="${ !empty sortValue }">
								<button class="btn" onclick="location.href='${before2}'">&lt;&lt;</button>
							</c:when>
							<c:when test="${ !empty categoryValue }">
								<button class="btn" onclick="location.href='${before3}'">&lt;&lt;</button>
							</c:when>
							<c:when test="${ !empty categoryValue2 }">
								<button class="btn" onclick="location.href='${before4}'">&lt;&lt;</button>
							</c:when>
							<c:when test="${ !empty categoryValue3 }">
								<button class="btn" onclick="location.href='${before5}'">&lt;&lt;</button>
							</c:when>
							<c:otherwise>
								<button class="btn" onclick="location.href='${before}'">&lt;&lt;</button>
							</c:otherwise>
						</c:choose>
				</c:if>
				<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:if test="${ p eq pi.currentPage }">
							<button class="btn" style="background : red">${ p }</button>
						</c:if>
						<c:if test="${ p ne pi.currentPage }">
							<c:url var="pagination" value="/board/list">
								<c:param name="searchValue" value="${ searchValue }"/>
								<c:param name="page" value="${ p }"/>
							</c:url>							
							<c:url var="pagination2" value="/board/sort">
								<c:param name="searchValue" value="${ searchValue }"/>
								<c:param name="sortValue" value="${ sortValue }"/>
								<c:param name="page" value="${ p }"/>
							</c:url>
							<c:url var="pagination3" value="/board/category1">
								<c:param name="cid" value="${ categoryValue }"/>
								<c:param name="page" value="${ p }"/>
							</c:url>
							<c:url var="pagination4" value="/board/category2">
								<c:param name="cid" value="${ categoryValue2 }"/>
								<c:param name="page" value="${ p }"/>
							</c:url>
							<c:url var="pagination5" value="/board/category3">
								<c:param name="cid" value="${ categoryValue3 }"/>
								<c:param name="page" value="${ p }"/>
							</c:url>
						<c:choose>
							<c:when test="${ !empty sortValue }">
								<button class="btn" onclick="location.href='${pagination2}'">${ p }</button>
							</c:when>
							<c:when test="${ !empty categoryValue }">
								<button class="btn" onclick="location.href='${pagination3}'">${ p }</button>
							</c:when>
							<c:when test="${ !empty categoryValue2 }">
								<button class="btn" onclick="location.href='${pagination4}'">${ p }</button>
							</c:when>
							<c:when test="${ !empty categoryValue3 }">
								<button class="btn" onclick="location.href='${pagination5}'">${ p }</button>
							</c:when>
							<c:otherwise>
								<button class="btn" onclick="location.href='${pagination}'">${ p }</button>
							</c:otherwise>
						</c:choose>
						</c:if>
					</c:forEach>
				<!-- 다음 -->
				<c:if test="${ pi.currentPage >= pi.maxPage }">
	                <button class="btn">&gt;&gt;</button>
	            </c:if>
	            <c:if test="${ pi.currentPage < pi.maxPage }">
						<c:url var="after" value="/board/list">
							<c:param name="searchValue" value="${ searchValue }"/>
							<c:param name="page" value="${ pi.currentPage + 1 }"/>
						</c:url>
						<c:url var="after2" value="/board/sort">
							<c:param name="page" value="${ pi.currentPage + 1 }"/>
							<c:param name="searchValue" value="${ searchValue }"/>
							<c:param name="sortValue" value="${ sortValue }"/>
						</c:url>
						<c:url var="after3" value="/board/category1">
							<c:param name="cid" value="${ categoryValue }"/>
							<c:param name="page" value="${ pi.currentPage + 1 }"/>
						</c:url>
						<c:url var="after4" value="/board/category2">
							<c:param name="cid" value="${ categoryValue2 }"/>
							<c:param name="page" value="${ pi.currentPage + 1 }"/>
						</c:url>
						<c:url var="after5" value="/board/category3">
							<c:param name="cid" value="${ categoryValue3 }"/>
							<c:param name="page" value="${ pi.currentPage + 1 }"/>
						</c:url>
						<c:choose>
							<c:when test="${ !empty sortValue }">
								<button class="btn" onclick="location.href='${after2}'">&gt;&gt;</button>
							</c:when>
							<c:when test="${ !empty categoryValue }">
								<button class="btn" onclick="location.href='${after3}'">&gt;&gt;</button>
							</c:when>
							<c:when test="${ !empty categoryValue2 }">
								<button class="btn" onclick="location.href='${after4}'">&gt;&gt;</button>
							</c:when>
							<c:when test="${ !empty categoryValue3 }">
								<button class="btn" onclick="location.href='${after5}'">&gt;&gt;</button>
							</c:when>
							<c:otherwise>
								<button class="btn" onclick="location.href='${after}'">&gt;&gt;</button>
							</c:otherwise>
						</c:choose>
				</c:if>
            </div>
    </div>
    <script>
    	$(function(){
    		$("#category1").on('change', function(){
    			var cid = $("#category1 option:selected").val();
    			location.href="${ contextPath }/board/category1?cid=" + cid;
    		})
    		
    		$("#category2").on('change', function(){
    			var cid = $("#category2 option:selected").val();
    			location.href="${ contextPath }/board/category2?cid=" + cid;
    		})
    		
    		$("#category3").on('change', function(){
    			var cid = $("#category3 option:selected").val();
    			location.href="${ contextPath }/board/category3?cid=" + cid;
    		})
    		
    </script>
</body>
</html>