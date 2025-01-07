<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

<style>
    
    .text-center{
        margin: auto;
        width: 220px;
        text-align: center;
    }
    
    .text-center > ul > li{
        margin:0 auto;
        text-align: center;
    }
       
    .container{
        width: 800px;
        height: 500px;
        margin: auto;
        font-family: 'SUITE-Regular';
    }

    .table{
        width: 750px;
        height: 50px;
        margin: auto;
        margin-top: 10px;
        border-radius: 5px;
        background-color: rgb(250, 250, 250);
        text-align: center;
        border: outset;
        font-family: 'SUITE-Regular';
    }

    @font-face {
        font-family: 'SUITE-Regular';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
        font-weight: 400;
        font-style: normal;
    }
    /*8개의 댓글 조회*/
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />

		<div class="container">
			<table class="table table-hover">
			  <thead>
			    <tr>
			      <th>번호</th>
			      <th>제목</th>
			      <th>조회수</th>
			      <th>좋아요</th>
			      <th>생성일</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td>10000</td>
			      <td>게시글제목10자</td>
			      <td>100</td>
			      <td>160</td>
			      <td>2024-12-12</td>
			    </tr>
			    
			  </tbody>
			</table>
			<div class="text-center">
			    <ul class="pagination">
			        <li class="page-item"><a class="page-link" href="#">이전</a></li>
			        <li class="page-item"><a class="page-link" href="#">1</a></li>
			        <li class="page-item"><a class="page-link" href="#">다음</a></li>
			    </ul>
			</div>
		</div>
		<script>
		    	let endPage = "${pageInfo.endPage}";
		    	let maxPage = "${pageInfo.maxPage}";
		    	let pageLimit = "${pageInfo.pageLimit}";
		    	let currentPage = "${pageInfo.currentPage}";
		    	
		    	if(maxPage <= pageLimit){
		    		$("#next").attr("class", "page-item disabled")
		    	}
		    	
		    	if(endPage == maxPage){
		    		$("#next").attr("class", "page-item disabled")
		    	}
		    	
		    	if(currentPage <= pageLimit){
		    		$("#pro").attr("class", "page-item disabled")
		    	}
		    	
	    </script>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>