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
        
        .a{
        	text-decoration: none;
        	color: black;

        }
        
        .a:hover{
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
            position: relative;
            left: 380px;
            bottom: 40px;
        }

        

    </style>


</head>
<body>
	<jsp:include page="../common/menubar.jsp" />

    <div id="body">
        <div id="page-bar">
            <ul id="menu">
                <li><a href="update_enroll_form.member" class="a">내 정보 수정</a></li>
                
                <li><a href="select.cart" class="a">장바구니</a></li>
                
                <li><a href="select.myBook" class="a">내 예약 목록</a></li>
                
                <li><a href="select.myOrder" class="a">내 주문 목록</a></li>
                
                <li><a href="select.attention" class="a">찜 목록</a></li>
                
                <li><a href="select.myBoardList" class="a">내 게시글</a></li>
                
                <li><a href="select.myReplyList" class="a">내 댓글</a></li>
	                <c:choose>
	                    <c:when test="${ sessionScope.loginUser.categoryName eq '판매자' }">
	                        
	                        <!-- 판매자 유저에게만 띄울 메뉴-->
	                        <li><a href="select.myFarmList" class="a">내 농장</a></li>
	                        
	                        <li><a href="select.myProductList" class="a">내 판매 목록</a></li>
	                        <!-- 여기까지 판매자 -->
	                    </c:when>
	                    <c:when test="${ sessionScope.loginUser.categoryName eq '일반이용자' }">
	                        
	                        <!-- 일반 유저에게만 띄울 메뉴 -->
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
                <div id="nick-name">닉네임 : <label>${ sessionScope.loginUser.nickName }</label></div>
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
                
                <c:forEach var="address" items="${ addresses }">
		            <c:if test="${ address.addressType eq 1 }">
		                <div id="address">주소 : 
							<label>${ address.stateName }</label><br>
                          	<label>${ address.district }</label>
		                </div>
		            </c:if>
                </c:forEach>
                <div id="phone">전화번호 : <label>${ sessionScope.loginUser.phone }</label></div>
                <br>
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