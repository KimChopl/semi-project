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
        border: 1px solid red;
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
        height: 140px;
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
        top: 16px;
        left: 10px;
    }

    .img{
        width: 100px;
        height: 100px;
        border-radius: 5px;
    }

    #product-name{
        width: 250px;
        height: 25px;
        position: relative;
        bottom: 90px;
        left: 150px;
    }

    #category-name{
        width: 100px;
        height: 22px;
        position: relative;
        bottom: 95px;
        left: 150px;
    }

    #unit-name{
        width: 40px;
        height: 25px;
        position: relative;
        bottom: 75px;
        left: 180px;
    }

    #order-quantity{
        width: 30px;
        height: 25px;
        position: relative;
        left: 149px;
        bottom: 100px;
    }

    

    #product-price{
        width: 100px;
        height: 25px;
        position: relative;
        left: 250px;
        bottom: 50px;
    }

    .button{
        width: 100px;
        height: 30px;
        background-color: rgb(103, 189, 76);
        border: none;
        color: white;
        position: relative;
        margin-top: 5px;
        left: 210px;
        bottom: 130px;
        font-size: 12px;
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
                <div id="category-name">
                    <span class="span">상품카테고리</span>
                </div>
                <div id="product-name">
                    <span class="span">상품명</span>
                </div>
                <div id="product-price">
                    <span class="span">상품가격</span>
                </div>
                <div id="unit-name">
                    <span class="span">단위</span>
                </div>
                <div id="order-quantity">
                    <span class="span">개수</span>
                </div>
                <form action="insert.cart" method="post">
                    <input type="hidden" name="productNo" value="상품번호" />
                    <button type="submit" class="button">장바구니에 추가</button>
                </form>
            </div>
            <div id="wrap">
                <div id="img"><img src="" class="img"></div>
                <div id="category-name">
                    <span class="span">상품카테고리</span>
                </div>
                <div id="product-name">
                    <span class="span">상품명</span>
                </div>
                <div id="product-price">
                    <span class="span">상품가격</span>
                </div>
                <div id="unit-name">
                    <span class="span">단위</span>
                </div>
                <div id="order-quantity">
                    <span class="span">개수</span>
                </div>
                <form action="insert.cart" method="post">
                    <input type="hidden" name="productNo" value="상품번호" />
                    <button type="submit" class="button">장바구니에 추가</button>
                </form>
            </div>
            <div id="wrap">
                <div id="img"><img src="" class="img"></div>
                <div id="category-name">
                    <span class="span">상품카테고리</span>
                </div>
                <div id="product-name">
                    <span class="span">상품명</span>
                </div>
                <div id="product-price">
                    <span class="span">상품가격</span>
                </div>
                <div id="unit-name">
                    <span class="span">단위</span>
                </div>
                <div id="order-quantity">
                    <span class="span">개수</span>
                </div>
                <form action="insert.cart" method="post">
                    <input type="hidden" name="productNo" value="상품번호" />
                    <button type="submit" class="button">장바구니에 추가</button>
                </form>
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