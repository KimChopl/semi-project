<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>퍼리 마켓</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FFF4E0; /* 연한 주황색 배경 */
            margin: 0;
            padding: 0;
        }

        #header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            background-color: #ff8051; /* 밝은 주황색 */
            border-bottom: 1px solid #ddd;
        }

        #header_1_left img {
            height: 50px;
        }

        #header_1_center {
            text-align: center;
        }

        #header_1_center ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 60px;
        }

        #header_1_center ul li {
            display: inline-block;
        }

        #header_1_center ul li a {
            text-decoration: none;
            color: white;
            font-size: 18px;
            font-weight: bold;
        }

        #header_1_center ul li a:hover {
            color: #626262;
        }

        #header_1_right {
            text-align: right;
            color: white;
            font-size: 14px;
        }

        #header_1_right a {
            text-decoration: none;
            color: white;
            margin-left: 10px;
        }

        #header_1_right a:hover {
            text-decoration: underline;
        }

        /* 프로필 이미지 스타일 */
        #profile-pic {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
        }

        /* 프로필 메뉴 스타일 */
        #profile-menu {
            display: none;
            position: absolute;
            background-color: white;
            border: 1px solid #ddd;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            top: 60px;
            right: 20px;
            padding: 10px 15px; /* 여백을 줄여서 메뉴 크기 조정 */
            border-radius: 5px;
            min-width: 200px; /* 메뉴 최소 너비 설정 */
        }

        #profile-menu a {
            display: block;
            padding: 8px;
            text-decoration: none;
            color: #333;
        }

        #profile-menu a:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <!-- 헤더 -->
    <div id="header">
        <!-- 로고 -->
        <div id="header_1_left">
            <img src="https://cdn4.iconfinder.com/data/icons/food-4-9/128/food_Potato-Vegetable-128.png" alt="퍼리 마켓 로고">
            <span style="color: white;">Pugly Market</span>
        </div>

        <!-- 네비게이션 -->
        <div id="header_1_center">
            <ul>
                <li><a href="메인페이지">HOME</a></li>
                <li><a href="농산물핸들러">농산물</a></li>
                <li><a href="농장핸들러">농장</a></li>
                <li><a href="/pugly/boards">게시판</a></li>
            </ul>
        </div>

        <!-- 로그인/유저 메뉴 -->
        <div id="header_1_right">


                    <a href="로그인 경로">로그인</a>


                    <div style="position: relative; display: inline-block;">
                        <img id="profile-pic" src="https://cdn2.iconfinder.com/data/icons/user-interface-169/32/about-128.png" alt="기본이미지" onclick="toggleProfileMenu()">
                        <div id="profile-menu">
                            <label style="color: black;">\${로그인유저이름}님</label>
                            <a href="마이페이지핸들러">마이페이지</a>
                            <a href="예약상태핸들러">예약상태</a>
                            <a href="장바구니핸들러">장바구니</a>
                            <a href="로그아웃핸들러">로그아웃</a>
                        </div>
                    </div>
                    
                    
         </div>
    </div>

    <script>
        // 프로필 메뉴 토글 함수
        function toggleProfileMenu() {
            var menu = document.getElementById('profile-menu');
            menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
        }

        // 프로필 메뉴 외부 클릭 시 닫기
        window.onclick = function(event) {
            var menu = document.getElementById('profile-menu');
            var profilePic = document.getElementById('profile-pic');
            if (event.target !== profilePic && !profilePic.contains(event.target)) {
                menu.style.display = 'none';
            }
        };
    </script>
</body>
</html>