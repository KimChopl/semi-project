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
        div{
            box-sizing: border-box;
        }

        #body{
            width: 700px;
            height: 600px;
            margin: auto;  
            font-family: 'SUITE-Regular';
        }

        #wrap{
            width: 640px;
            height: 130px;
            margin: auto;
            border-radius: 5px;
            background-color: rgb(245, 245, 245);
            border:2px outset;
        }

        #img{
            width: 110px;
            height: 110px;
            border-radius: 4px;
            position: relative;
            left: 10px;
            top: 9px;
        }

        #farm-title{
            width: 180px;
            height: 25px;
            position: relative;
            left: 180px;
            bottom: 100px;
        }

        #farm-address{
            width: 190px;
            height: 50px;
            position: relative;
            left: 180px;
            bottom: 80px;
        }

        #attention{
            width: 100px;
            height: 25px;
            position: relative;
            left: 450px;
            bottom: 150px;
        }

        #like{
            width: 100px;
            height: 25px;
            position: relative;
            left: 450px;
            bottom: 140px; 
        }

        .text-center{
            margin: auto;
            width: 220px;
            text-align: center;
        }
            
        .text-center > ul > li{
            margin:0 auto;
            text-align: center;
        }

        @font-face {
            font-family: 'SUITE-Regular';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
            font-weight: 400;
            font-style: normal;
        }   

    </style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />

	    <div id="body">
	        <br>
	        <div id="wrap">
	            <div id="img"></div>
	            <div id="farm-title">농장이름 : </div>
	            <div id="farm-address">주소 : </div>
	            <div id="attention">찜 : </div>
	            <div id="like">좋아요 : </div>
	        </div>
	        <div class="text-center">
	            <ul class="pagination">
	                <li class="page-item"><a class="page-link" href="#">이전</a></li>
	                <li class="page-item"><a class="page-link" href="#">1</a></li>
	                <li class="page-item"><a class="page-link" href="#">2</a></li>
	                <li class="page-item"><a class="page-link" href="#">3</a></li>
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