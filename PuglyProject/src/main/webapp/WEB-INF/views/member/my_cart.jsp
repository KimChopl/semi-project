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
            text-align: center;
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

        .checkbox{
            width: 25px;
            height: 25px;
            position: relative;
            bottom: 215px;
            left: 275px;
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

        #product-quantity{
            width: 30px;
            height: 25px;
            position: relative;
            left: 149px;
            bottom: 100px;
        }

        #delivery-price{
            width: 90px;
            height: 25px;
            position: relative;
            left: 500px;
            bottom: 130px;
        }

        #product-price{
            width: 100px;
            height: 25px;
            position: relative;
            left: 250px;
            bottom: 50px;
        }

        .button{
            width: 600px;
            height: 30px;
            background-color: rgb(87, 87, 255);
            color: white;
            margin-top: 5px;
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
        <form action="insert.myOrder" method="post">
        <c:forEach items="${ cartList }" var="c">
            <div id="wrap" onclick="detailProduct('${c.productNo}')">
                <input type="hidden" name="productNo" value="${ c.productNo }" />
                <div id="img"><img src="${ c.image.changeImgName }" class="img"></div>
                <div id="category-name"><span class="span">${ c.productType }</span></div>
                <div id="product-name"><span class="span">${ c.productName }</span></div>
                <div id="product-price"><span class="span">${ c.productPrice }원</span></div>
                <div id="unit-name"><span class="span">${ c.unitName }</span></div>
                <div id="product-quantity"><span class="span">${ c.productQuantity }</span></div>
                <c:if test="${ c.deliveryPrice ne '무료' }">
                <div id="delivery-price"><span class="span">${ c.deliveryPrice }원</span></div>
                </c:if>
                <input type="checkbox" class="checkbox">
            </div>
        </c:forEach>
         <script>
         	function detailProduct(num) {
         		location.href = `products/\${num}`;
			}
         </script>
            
            <button type="submit" class="button">주문하기</button>   
        </form>
        <br>
        <div class="text-center">
	        <ul class="pagination">
		            <li class="page-item" id="pro"><a class="page-link" href="select.cart?memberNo=${ sessionScope.loginUser.memberNo }">이전</a></li>
		        <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="i">
		        
		            <li class="page-item"><a class="page-link" href="select.cart?memberNo=${ sessionScope.loginUser.memberNo }&currentPage=${i}">${ i }</a></li>
		        
		        </c:forEach>
		            <li class="page-item" id="next"><a class="page-link" href="select.cart?memberNo=${ sessionScope.loginUser.memberNo }&currentPage=${pageInfo.endPage + 1 }">다음</a></li>
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