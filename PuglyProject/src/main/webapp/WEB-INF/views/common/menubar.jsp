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
    <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
  	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/bootstrap.min.css"/>
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
	<c:if test="${ not empty alertMsg }">
		<script>
		alertify.alert('${ alertMsg }').set('${ alertMsg }', true); 
		</script>
		<c:remove var="alertMsg" scope="session"/>
	</c:if>
    <div id="header">
        <!-- 로고 -->
        <div id="header_1_left">
            <a href="/pugly" style="text-decoration-line: none;">
            	<img src="https://cdn4.iconfinder.com/data/icons/food-4-9/128/food_Potato-Vegetable-128.png" alt="퍼리 마켓 로고">
            </a>
            <span style="color: white;">Pugly Market</span>
        </div>

        <!-- 네비게이션 -->
        <div id="header_1_center">
            <ul>
                <li><a href="/pugly/products">농산물</a></li>
                <li><a href="/pugly/farms">농장</a></li>
                <li><a href="/pugly/boards">게시판</a></li>
                <li><a href="/pugly/inquiries">고객소리함</a></li>
            </ul>
        </div>

        <!-- 로그인/유저 메뉴 -->
        <div id="header_1_right">

        	<c:choose>
	        	<c:when test="${empty sessionScope.loginUser }">
	                   	<a href="/pugly/login_form.member" style = "color : white;">로그인</a>
	            </c:when>
	            <c:otherwise>
	                    <div style="position: relative; display: inline-block; z-index: 1000;">
						    <img id="profile-pic" src="https://cdn2.iconfinder.com/data/icons/user-interface-169/32/about-128.png" 
						         alt="기본이미지" 
						         onclick="toggleProfileMenu()" 
						         style="cursor: pointer;">
						    <div id="profile-menu" style="position: absolute; background-color: white; z-index: 1001; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); display: none;">
						        <label style="color: black;">${ sessionScope.loginUser.nickname }님</label>
						        <a href="/pugly/my_page.member">마이페이지</a>
						        <a href="/pugly/list.book">예약상태</a>
						        <a href="/pugly/select.cart?memberNo=${ sessionScope.loginUser.memberNo }">장바구니</a>
						        <a href="/pugly/logout.member">로그아웃</a>
						    </div>
						</div>
	         	</c:otherwise>
         	</c:choose>

         </div>
    </div>

    <script>
        // 프로필 메뉴 토글 함수
        function toggleProfileMenu() {
            var menu = document.getElementById('profile-menu');
            menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
        }
    </script>
</body>
</html>