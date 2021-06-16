<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		.adminMainPage{
			width : 70%;
			float : left;
		}
		.top{
			width : 100%;
			float : left;
		}
        .el{
            border: 1px solid rgb(0, 51, 85);
            width: 250px;
            height: 150px;
            display: inline-block;

        }
        .el p{
            text-align: center;
        }
        .el h3{
            text-align: center;
        }
        .container{
            width: 600px;
            height: 200px;
            margin-right: 790px;
        }
        .myChart{
        	width : 700px !important;
        }
</style>
 
    <!-- 차트 링크 --> 
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
</head>
<body>
	<jsp:include page="../admin/menubar.jsp"/>
	<div class="adminMainPage">
		<div class="top">
        	<div class="el">
	            <p>다행 회원수</p>
	            <h3>${ aCount }명</h3>
	        </div>
	        <div class="el">
	            <p>오늘 가입한회원수</p>
	            <h3>${ todayAccount }명</h3>
	        </div>
	        <div class="el">
	            <p>오늘 접수된 신고</p>
	            <h3>${ rCount }건</h3>
	        </div>
        </div>
        <div class="container"><canvas id="myChart" class="myChart"></canvas></div>
    </div>
    <!-- 부트스트랩 --> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script> 
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
     <!-- 차트 --> 
    <script>
     var ctx = document.getElementById('myChart'); 
     var myChart = new Chart(ctx, { 
         type: 'bar',
         data: { labels: [<c:forEach items="${ chart }" var="c" varStatus="status">'${ c.c_name }'<c:if test="${status.last eq false}">,</c:if></c:forEach>],
         datasets: [{ label: '카테고리별 물품수 ',
         data: [<c:forEach items="${ chart }" var="c" varStatus="status">${ c.count }<c:if test="${status.last eq false}">,</c:if></c:forEach>],
         backgroundColor: [ 'rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)', 'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)' ],
         borderColor: [ 'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)' ],
         borderWidth: 1 }] },
         options: { scales: { yAxes: [{ ticks: { beginAtZero: true } }] } } }); 
    </script>
</body>
</html>