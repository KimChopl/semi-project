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
            width: 650px;
            height: 500px;
            margin: auto;
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
        

        #wrap{
            width: 600px;
            height: 180px;
            margin: auto;
            margin-top: 10px;
            border-radius: 5px;
            background-color: rgb(250, 250, 250);
            text-align: center;
            border: outset;
        }


        #img{
            border-radius: 5px;
            position: relative;
            width: 100px;
            height: 100px;
            top: 35px;
            left: 10px;
        }

        .img{
            width: 100px;
            height: 100px;
            border-radius: 5px;
        }

        #book-date{
            width: 120px;
            height: 25px;
            position: relative;
            bottom: 90px;
            left: 450px;
        }

        #play-date{
            width: 120px;
            height: 25px;
            position: relative;
            bottom: 85px;
            left: 450px;
        }

        
        #farm-name{
            width: 150px;
            height: 25px;
            position: relative;
            left: 149px;
            bottom: 90px;
        }
        
        #total-play-people{
            width: 90px;
            height: 25px;
            position: relative;
            bottom: 75px;
            left: 400px;
        }

        #adult{
            width: 80px;
            height: 25px;
            position: relative;
            bottom: 70px;
            left: 360px;
        }

        #kid{
            width: 80px;
            height: 25px;
            position: relative;
            bottom: 95px;
            left: 450px;
        }

        #farm-product{
            width: 100px;
            height: 25px;
            position: relative;
            bottom: 200px;
            left: 150px;
        }

        #farm-price{
            width: 100px;
            height: 25px;
            position: relative;
            bottom: 150px;
            left: 150px;
        }

        .button{
            width: 600px;
            height: 30px;
            background-color: rgb(87, 87, 255);
            color: white;
            position: relative;
            margin-top: 5px;
            left: 25px;
            font-family: 'SUITE-Regular';
        }

        .span{
            width: 90%;
            height: 80%;
            margin: 0;
            padding: 0;
            background-color: rgb(250, 250, 250);
            border: none;
            font-family: 'SUITE-Regular'; 
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
        <div id="wrap">
            <div id="img"><img src="" class="img"></div>
            <div id="farm-name">
                <span class="span">농장이름</span>
            </div>
            <div id="book-date">
                <span class="span">예약추가한날짜</span>
            </div>
            <div id="play-date">
                <span class="span">예약일</span>
            </div>
            <div id="total-play-people">
                <span class="span">예약 인원</span>
            </div>
            <div id="adult">
                <span class="span">성인 :</span>
            </div>
            <div id="kid">
                <span class="span">아이 :</span>
            </div>
            <div id="farm-product">
                <span class="span">농장대표작물</span>
            </div>
            <div id="farm-price">
                <span class="span">체험가격</span>
            </div>
        </div>
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