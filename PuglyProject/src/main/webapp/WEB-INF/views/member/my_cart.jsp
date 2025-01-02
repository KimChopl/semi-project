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

        .pagination{
            position: relative;
            left: 190px;
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
            bottom: 240px;
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
            position: relative;
            margin-top: 5px;
            left: 25px;
            font-family: 'SUITE-Regular';
        }

        .input{
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
    <div id="body">
        <form action="" method="post">
            <div id="wrap">
                <input type="hidden" name="productNo" value="상품번호" />
                <div id="img"><img src="" class="img"></div>
                <div id="category-name"><input type="text" readonly name="categoryName" value="상품카테고리" class="input"></div>
                <div id="product-name"><input type="text" readonly name="productName" value="상품명" class="input"></div>
                <div id="product-price"><input type="number" readonly name="productPrice" value="10000" class="input"></div>
                <div id="unit-name"><input type="text" readonly name="unitName" value="box" class="input"></div>
                <div id="product-quantity"><input type="number" readonly name="productQuantity" value="0" class="input"></div>
                <div id="delivery-price"><input type="number" readonly name="deliveryPrice" value="2500" class="input"></div>
                <input type="checkbox" class="checkbox">
            </div>
            <button type="submit" class="button">주문하기</button>   
        </form>
        <ul class="pagination">
            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
            <li class="page-item"><a class="page-link" href="my_cart.member">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
        </ul>
    </div>
   

</body>
</html>