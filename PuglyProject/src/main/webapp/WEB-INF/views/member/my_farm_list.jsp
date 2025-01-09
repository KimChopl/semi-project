<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 농장 목록</title>

    <style>
        
        div{
            box-sizing: border-box;
        }
        
        .wrap{
            width: 500px;
            height: 140px;
            margin: auto;
            margin-top: 5px;
            font-family: 'SUITE-Regular';
            border: 2px outset;
            border-radius: 5px;
            background-color: rgb(245, 245, 245);
        }
        
        #farm-modify-date{
            width: 150px;
            height: 25px;
            position: relative;
            left: 220px;
            top: 70px;
        }
        
        #farm-no{
            width: 50px;
            height: 25px;
            position: relative;
            left: 5px;
            top: 55px;
            text-align: center;
        }

        #farm-title{
            width: 150px;
            height: 25px;
            position: relative;
            left: 220px;
            bottom: 35px;
        }

        #farm-price{
            width: 140px;
            height: 25px;
            position: relative;
            left: 220px;
            bottom:25px;
        }

        #img{
            width: 120px;
            height: 120px;
            position: relative;
            left: 65px;
            bottom:118px;
        }
        
        .img{
        	width: 100%;
        	height: 100%;
        }

        #count{
            width: 90px;
            height: 25px;
            position: relative;
            left: 390px;
            bottom: 85px;
        }
        
        #title{
        	text-align: center;
        	font-family: 'SUITE-Regular';
        	font-weight: bolder;
        }
        
        #button{
        	width: 60px;
        	height: 60px;
        	position: relative;
        	left:410px;
        	bottom:190px;
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
	
	<h5 id="title">내 농장</h5>
	
	<c:forEach items="${ list }" var="f">
	    <div class="wrap" onclick="detailFarm('${f.farmNo}')">
	        <div id="farm-no">${ f.farmNo }</div>
	        <div id="farm-modify-date"><c:if test="${ not empty f.farmModifyDate }">수정일 : ${ f.farmModifyDate }</c:if></div>
	        <div id="farm-title">${ f.farmTitle }</div>
	        <div id="farm-price">체험 가격 : ${ f.farmPrice }</div>
	        <div id="count">조회수 : ${ f.farmCount }</div>
	        <div id="img"><img src="${ f.imgList[0].imgPath }${ f.imgList[0].changeImgName }" class="img"></div>
	        <div id="button"><button class="btn btn-success">수정하기</button></div>
	    </div>
	</c:forEach>
    <div class="text-center">
	        <ul class="pagination">
		            <li class="page-item" id="pro"><a class="page-link" href="select.myFarmList?memberNo=${ sessionScope.loginUser.memberNo }">이전</a></li>
		        <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="i">
		        
		            <li class="page-item"><a class="page-link" href="select.myFarmList?memberNo=${ sessionScope.loginUser.memberNo }&currentPage=${i}">${ i }</a></li>
		        
		        </c:forEach>
		            <li class="page-item" id="next"><a class="page-link" href="select.myFarmList?memberNo=${ sessionScope.loginUser.memberNo }&currentPage=${pageInfo.endPage + 1 }">다음</a></li>
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
	 		//location.href = `my_farm_detail.member?memberNo=\${num}`;
		}
    </script>
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>