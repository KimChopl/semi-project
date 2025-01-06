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
        
        #wrap{
            width: 700px;
            height: 170px;
            margin: auto;
            font-family: 'SUITE-Regular';
            border: 2px outset;
            border-radius: 5px;
        }
        
        #img{
            width: 130px;
            height: 130px;
            border-radius: 5px;
            position: relative;
            left: 130px;
            bottom: 5px;
        }
        
        #farm-no{
            width: 80px;
            height: 25px;
            position: relative;
            left: 25px;
            top: 70px;
            text-align: center;
        }

        #farm-title{
            width: 300px;
            height: 25px;
            position: relative;
            left: 280px;
            bottom: 140px;
        }

        #farm-price{
            width: 140px;
            height: 25px;
            position: relative;
            left: 530px;
            bottom: 130px;
        }

        #state-name{
            width: 90px;
            height: 25px;
            position: relative;
            left: 300px;
            bottom: 140px;
        }

        #district{
            width: 300px;
            height: 45px;
            position: relative;
            left: 300px;
            bottom: 135px;
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
    <div id="wrap">
        <div id="farm-no">11</div>
        <div id="img"><img src=""></div>
        <div id="farm-title">농장이름</div>
        <div id="farm-price">체험 가격 : 10000원</div>
        <div id="state-name">서울시</div>
        <div id="district">상세주소</div>
    </div>
</body>
</html>