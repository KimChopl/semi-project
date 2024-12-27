<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>footer</title>
    <style>
        #footer {
            width:80%; 
            height:200px; 
            margin:auto;
            margin-top:50px;
        }
        #footer-1 {
            width:100%;
            height:20%;
            border-top:1px solid lightgray;
            border-bottom:1px solid lightgray;
        }
        #footer-2 {width:100%; height:80%;}
        #footer-1, #footer-2 {padding-left:50px;}
        #footer-1>a {
            text-decoration:none;
            font-weight:600;
            margin:10px;
            line-height:40px;
            color:black;
        }
        #footer-2>p {
            margin:0;
            padding:10px;
            font-size:13px;
        }
        #p2 {text-align:center;}
    </style>
</head>
<body>
    <div id="footer">
        <div id="footer-1">
            <a href="#">이용약관</a> | 
            <a href="#">개인정보취급방침</a> | 
            <a href="#">개발자정보</a> | 
            <a href="#">고객센터</a>
        </div>

        <div id="footer-2">
            <p id="p1">
                종로지원 : 서울특별시 중구 남대문로 120 그레이츠청계 2F, 3F <br>
                강병민 : 메인페이지 & 게시판
                박상은 : 마이페이지 & 로그인
                서한솔 : 농산물 관리
                안재성 : 농장 관리리
            </p> 
            <p id="p2">Copyright © 2024-2025 울퉁불퉁감자 Educational Institute All Right Reserved</p>
        </div>
    </div>
</body>
</html>