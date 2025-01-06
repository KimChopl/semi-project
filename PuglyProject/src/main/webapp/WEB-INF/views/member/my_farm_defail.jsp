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

        #wrap{
            width: 900px;
            height: 800px;
            margin: auto;
            background-color: rgb(243, 243, 243);
            border-radius: 10px;
            border: 3px outset;
        }

        #img{
            width: 400px;
            height: 300px;
            margin: auto;
            position: relative;
            top: 10px;
        }
        
        #farm-count{
            width: 100px;
            height: 25px;
            position: relative;
            bottom: 120px;
            left: 50px;
        }

        #farm-title{
            width: 250px;
            height: 30px;
            position: relative;
            bottom: 10px;
            left: 330px;
        }

        #farm-product{
            width: 100px;
            height: 25px;
            position: relative;
            bottom: 62px;
            left: 330px;
        }

        #farm-content{
            width: 700px;
            height: 100px;
            position: relative;
            left: 100px;
            top: 60px;
        }

        #beware-list{
            width: 700px;
            height: 100px;
            position: relative;
            left: 100px;
            top: 80px;
        }

        #farm-price{
            width: 120px;
            height: 30px;
            position: relative;
            left: 460px;
            bottom: 290px;
        }
        
        #farm-create-date{
            width: 200px;
            height: 30px;
            position: relative;
            left: 30px;
            bottom: 300px;
        }


        #farm-modify-date{
            width: 200px;
            height: 30px;
            position: relative;
            left: 30px;
            bottom: 290px;
        }

        #state-name{
            width: 90px;
            height: 30px;
            position: relative;
            left: 100px;
            bottom: 230px;

        }
        #district{
            width: 600px;
            height: 30px;
            position: relative;
            left: 200px;
            bottom: 260px;
        }

        #facility-name{
            width: 520px;
            height: 30px;
            position: relative;
            left: 190px;
            bottom: 340px;
            text-align: center;
        }

        .checkbox{
            width: 20px;
            height: 20px;
        }

    </style>

</head>
<body>
    <div id="wrap">
        <div id="img"><img src="">농장이미지</div>
        <div id="farm-count">조회 : 0000회</div>
        <div id="farm-title">농장명</div>
        <div id="farm-create-date">농장 생성일 : "2024-01-24"</div>
        <div id="farm-modify-date">최근 수정일 : "2025-01-03"</div>
        <div id="farm-product">농장대표작물</div>
        <div id="farm-content">농장내용</div>
        <div id="beware-list">주의사항</div>
        <div id="farm-price">예약가격</div>
        <div id="state-name">서울시</div>
        <div id="district">상세주소</div>
        <div id="facility-name">
            <input type="checkbox" name="facilityName" class="checkbox" value="">
            <input type="checkbox" name="facilityName" class="checkbox" value="">
            <input type="checkbox" name="facilityName" class="checkbox" value="">
            <input type="checkbox" name="facilityName" class="checkbox" value="">
            <input type="checkbox" name="facilityName" class="checkbox" value="">
            <input type="checkbox" name="facilityName" class="checkbox" value="">
        </div>
    </div>
</body>
</html>