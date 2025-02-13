<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        div{
            box-sizing: border-box;
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
            font-weight: 600;
            margin:20px;
            font-family: 'SUITE-Regular';
        }
        
        .a{
        	text-decoration: none;
        	color: black;
        	font-family: 'SUITE-Regular';

        }
        
        .a:hover{
            list-style: none;
            font-family: 'SUITE-Regular';
            color: rgb(121, 121, 121);
            cursor: pointer;
            text-decoration: underline;
        }


        #info{
            width: 80%;
            height: 80%;
            margin: 55px auto;
            background-color: rgb(241, 241, 241);
            border-radius: 15px;
        }
        #nick-name{
            width: 200px;
            height: 30px;
            position: relative;
            left: 280px;
            bottom: 100px;
            margin-left: 20px;
            font-family: 'SUITE-Regular';
            font-weight: 700;
        }

        #address{
            width: 400px;
            height: 50px;
            margin-left: 20px;
            position: relative;
            bottom: 80px;
            font-family: 'SUITE-Regular';
            font-weight: 700;
        }

        #member-name{
            width: 300px;
            height: 30px;
            margin-left: 20px;
            position: relative;
            bottom: 70px;
            font-family: 'SUITE-Regular';
            font-weight: 700;
        }
        #phone{
            width: 350px;
            height: 30px;
            margin-left: 20px;
            position: relative;
            left: 280px;
            bottom: 125px;
            font-family: 'SUITE-Regular';
            font-weight: 700;
        }

        #member-type{
            width: 200px;
            height: 30px;
            margin-left: 20px;
            position: relative;
            bottom: 60px;
            font-family: 'SUITE-Regular';
            font-weight: 700;
        }

        #enroll-date{
            position: relative;
            left: 300px;
            bottom: 90px;
            font-family: 'SUITE-Regular';
            font-weight: 700;
        }

        #img{
            margin: 25px 21px 30px 25px ;
            width: 100px;
            height: 100px;
            border-radius: 100px;
            display: inline-block;
            background-color: rgb(255, 255, 255) ;
        }
        
        .img{
            vertical-align: middle;
            width: 100px;
            height : 100px;
            border-radius: 100px;
            margin: 0;
            padding: 0;
        }

        #address-update{
        	width: 100px;
        	height: 40px;
        	background-color: orange;
        	border: outset;
            position: relative;
            left: 360px;
            bottom: 90px;
            font-family: 'SUITE-Regular';
            font-weight: 900;
        }
        
        @font-face {
            font-family: 'SUITE-Regular';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
            font-weight: 400;
            font-style: normal;
        }

        

    </style>


</head>
<body>
	<jsp:include page="../common/menubar.jsp" />

    <div id="body">
        <div id="page-bar">
            <ul id="menu">
                <li><a href="update_enroll_form.member" class="a">내 정보 수정</a></li>
                
                <li><a href="select.cart?memberNo=${ sessionScope.loginUser.memberNo }" class="a">장바구니</a></li>
                
                <li><a href="select.myBook?memberNo=${ sessionScope.loginUser.memberNo }" class="a">내 예약 목록</a></li>
                
                <li><a href="select.myOrder?memberNo=${ sessionScope.loginUser.memberNo }" class="a">내 주문 목록</a></li>
                
                <li><a href="select.attention?memberNo=${ sessionScope.loginUser.memberNo }" class="a">찜 목록</a></li>
                
                <li><a href="select.myBoardList?memberNo=${ sessionScope.loginUser.memberNo }" class="a">내 게시글</a></li>
                
                <li><a href="select.myReplyList?memberNo=${ sessionScope.loginUser.memberNo }" class="a">내 댓글</a></li>
	                <c:choose>
	                    <c:when test="${ sessionScope.loginUser.categoryName eq '판매자' }">
	                        
	                        <!-- 판매자 유저에게만 띄울 메뉴-->
	                        <li><a href="select.myFarmList?memberNo=${ sessionScope.loginUser.memberNo }" class="a">내 농장</a></li>
	                        
	                        <li><a href="select.myProductList?memberNo=${ sessionScope.loginUser.memberNo }" class="a">내 판매 목록</a></li>
	                        <!-- 여기까지 판매자 -->
	                    </c:when>
	                    <c:when test="${ sessionScope.loginUser.categoryName eq '일반이용자' }">
	                        
	                        <!-- 일반 유저에게만 띄울 메뉴(폼 작성) -->
	                        <li><a href="update.seller" class="a">판매자 신청</a></li>   
	                    </c:when>
	                </c:choose>
            </ul>
        </div>
        <div id="memberInfo">
            <div id="info">
            	
                <div id="img">
                	<c:if test="${ not empty memberImage }">
                		<img src="${ memberImage.changeImgName }" class="img">
                	</c:if>
                </div>
                <div id="nick-name">닉네임 : <label>${ sessionScope.loginUser.nickname }</label></div>
                <div id="enroll-date">가입일 : <label>${ sessionScope.loginUser.createDate }</label></div>
                <div id="member-type">사용자 유형 : 
                <c:forEach items="${ memberCategory }" var="m">
                <c:if test="${ m.categoryNo eq sessionScope.loginUser.categoryNo }">
	                	<label>${ m.categoryName }</label>
                </c:if>
                </c:forEach>
	                
                </div>
                <br>
                <div id="member-name">이름 : <label>${ sessionScope.loginUser.memberName }</label></div>
                <br>
                <div id="phone">전화번호 : <label>${ sessionScope.loginUser.phone }</label></div>
                
                
                <c:forEach var="address" items="${ addresses }" begin="0" end="1">
		            <c:if test="${ address.addressType eq 1 }">
		                <div id="address">주소 : 
							<label>${ address.stateName }</label><br>
                          	<label>${ address.district }</label>
		                </div>
		                <br>
		            </c:if>
                </c:forEach>
                <button id="address-update">주소 수정</button>
            </div>
        </div>
    </div>
    <script>
        $(function(){
        	
            $('#address-update').on('click', function(){
                location.href = 'enroll_form.address'
            });
            
        })
</script>

	<jsp:include page="../common/footer.jsp" />


</body>
</html>