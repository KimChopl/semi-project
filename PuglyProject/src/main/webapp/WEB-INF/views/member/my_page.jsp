<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        div{
            box-sizing: border-box;
            /*border: 1px solid red;*/
        }

        #body{
            width: 800px;
            height: 600px;
            margin: auto;
        }
        #page-bar, #memberInfo{
            float: left;
        }
        #page-bar{
            width: 20%;
            height: 71%;
            background-color: rgb(241, 241, 241);
            border-radius: 10px;
            text-align: center;
        }

        #memberInfo{
            width: 80%;
            height: 100%;
        }

        #page-bar > ul{
            margin: 5;
            padding: 0;
        }

        #page-bar > ul > li{
            list-style: none;
            font-family: 'Courier New', Courier, monospace;
            font-weight: 600;
            margin:20px;
        }

        #page-bar > ul > li:hover{
            list-style: none;
            font-family: 'Courier New', Courier, monospace;
            color: rgb(121, 121, 121);
            cursor: pointer;
            text-decoration: underline;
        }

        #info{
            width: 80%;
            height: 80%;
            margin: 55px auto;
            background-color: rgb(241, 241, 241);
        }
        #nick-name{
            width: 200px;
            height: 30px;
            position: relative;
            left: 280px;
            bottom: 100px;
            margin-left: 20px;
        }

        #address{
            width: 400px;
            height: 50px;
            margin-left: 20px;
        }

        #member-name{
            width: 300px;
            height: 30px;
            margin-left: 20px;
        }
        #phone{
            width: 350px;
            height: 30px;
            margin-left: 20px;
        }

        #member-type{
            width: 200px;
            height: 30px;
            margin-left: 20px;
        }

        #enroll-date{
            position: relative;
            left: 300px;
            bottom: 90px;
        }

        #img{
            margin: 25px 21px 30px 25px ;
            width: 100px;
            height: 100px;
            border-radius: 100px;
            display: inline-block;
            border: 1px solid black;
            background-color: rgb(255, 255, 255) ;
        }

        #address-update{
            position: relative;
            left: 380px;
            bottom: 40px;
        }

        

    </style>


</head>
<body>
    <div id="body">
        <div id="page-bar">
            <ul>
                <li>내 정보 수정</li>
                
                <li>장바구니</li>
                
                <li>내 예약 목록</li>
                
                <li>내 주문 목록</li>
                
                <li>찜 목록</li>
                
                <li>내 게시글</li>
                
                <li>내 댓글</li>
                <c:choose>
                    <c:when test="${ sessionScope.loginUser.categoryNo eq 2 }">
                        
                        <!-- 판매자 유저에게만 띄울 메뉴-->
                        <li>내 농장</li>
                        
                        <li>내 판매 목록</li>
                        <!-- 여기까지 판매자 -->
                    </c:when>
                    <c:when test="${ sessionScope.loginUser.categoryNo eq 3 }">
                        
                        <!-- 일반 유저에게만 띄울 메뉴 -->
                        <li>판매자 신청하기</li>   
                    </c:when>
                </c:choose>
            </ul>
        </div>
        <div id="memberInfo">
            <div id="info">
                <div id="img"><img src="" alt=""></div>
                <div id="nick-name">닉네임 : <label>${ sessionScope.loginUser.nickName }</label></div>
                <div id="enroll-date">가입일 : <label>${ sessionScope.loginUser.createDate }</label></div>
                <div id="member-type">사용자 유형 : 
                <c:choose>
	                <c:when test="${ sessionScope.loginUser.categoryNo eq 3 }">
	                	<label>일반</label>
	                </c:when>
	                <c:when test="${ sessionScope.loginUser.categoryNo eq 2 }">
	                	<label>판매자</label>
	                </c:when>
	                <c:when test="${ sessionScope.loginUser.categoryNo eq 1 }">
	                	<label>관리자</label>
	                </c:when>
	                
                </c:choose>
                </div>
                <br>
                <div id="member-name">이름 : <label>${ sessionScope.loginUser.memberName }</label></div>
                <br>
                
                <c:forEach var="address" items="${ sessionScope.addresses }">
                <div id="address">주소 : 
            							<label>${ address.stateName }</label><br>
                                        <label>${ address.district }</label></div>
                </c:forEach>
                <div id="phone">전화번호 : <label>${ sessionScope.loginUser.phone }</label></div>
                
                <br>
                <button id="address-update">주소 수정</button>
            </div>
        </div>
    </div>

    <script>

        $(function(){

            $('li').eq(0).on('click', function(){
                location.href = 'update.memberInfo'
            });
            $('li').eq(1).on('click', function(){
                location.href = 'select.cart'
            });
            $('li').eq(2).on('click', function(){
                location.href = 'select.myBook'
            });
            $('li').eq(3).on('click', function(){
                location.href = 'select.myOrder'
            });
            $('li').eq(4).on('click', function(){
                location.href = 'select.attention'
            });
            $('li').eq(5).on('click', function(){
                location.href = 'select.myBoardList'
            });
            $('li').eq(6).on('click', function(){
                location.href = 'select.myReplyList'
            });
            $('li').eq(7).on('click', function(){
                location.href = 'select.myFarmList'
            });
            $('li').eq(8).on('click', function(){
                location.href = 'select.myProductList'
            });
            $('li').eq(9).on('click', function(){
                location.href = 'update.seller'
            });
            $('#address-update').on('click', function(){
                location.href = 'enroll-form.address'
            });
            
        })
</script>


</body>
</html>