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
        
        .wrap{
            width: 420px;
            height: 130px;
            margin: auto;
            font-family: 'SUITE-Regular';
            border: 2px outset;
            border-radius: 5px;
            background-color: rgb(245, 245, 245);
        }
        
        #farm-modify-date{
            width: 130px;
            height: 25px;
            position: relative;
            left: 260px;
            bottom: 10px;
        }
        
        #farm-no{
            width: 80px;
            height: 25px;
            position: relative;
            left: 5px;
            top: 50px;
            text-align: center;
        }

        #farm-title{
            width: 150px;
            height: 25px;
            position: relative;
            left: 100px;
            bottom: 35px;
        }

        #farm-price{
            width: 140px;
            height: 25px;
            position: relative;
            left: 100px;
            bottom:25px;
        }

        #seller{
            width: 90px;
            height: 25px;
            position: relative;
            left: 100px;
            bottom:15px;
        }

        #count{
            width: 90px;
            height: 25px;
            position: relative;
            left: 300px;
            bottom: 65px;
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
<br>
	
	
	<c:forEach items="${ list }" var="f">
	    <div class="wrap" onclick="detailFarm('${f.farmNo}')">
	        <div id="farm-no">${ f.farmNo }</div>
	        <div id="farm-modify-date"><c:if test="${ not empty f.farmModifyDate }">수정일 : ${ f.farmModifyDate }</c:if></div>
	        <div id="farm-title">${ f.farmTitle }</div>
	        <div id="farm-price">체험 가격 : ${ f.farmPrice }</div>
	        <div id="seller">${ f.seller }</div>
	        <div id="count">조회수 : ${ f.farmCount }</div>
	    </div>
	</c:forEach>
    <div class="text-center">
	        <ul class="pagination">
		            <li class="page-item" id="pro"><a class="page-link" href="select.cart?memberNo=${ sessionScope.loginUser.memberNo }">이전</a></li>
		        <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="i">
		        
		            <li class="page-item"><a class="page-link" href="select.cart?memberNo=${ sessionScope.loginUser.memberNo }&currentPage=${i}">${ i }</a></li>
		        
		        </c:forEach>
		            <li class="page-item" id="next"><a class="page-link" href="select.cart?memberNo=${ sessionScope.loginUser.memberNo }&currentPage=${pageInfo.endPage + 1 }">다음</a></li>
	        </ul>
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
    <script>
	    function detailFarm(num) {
	 		location.href = `my_farm_detail.member?memberNo=\${num}`;
		}
    </script>
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>