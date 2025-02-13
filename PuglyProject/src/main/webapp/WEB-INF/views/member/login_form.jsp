<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <style>

        div{
            box-sizing: border-box;
        }

        #body{
            width: 400px;
            height: 300px;
            text-align: center;
            margin: auto;
            border-radius: 5px;
            background-color: rgb(245, 245, 245);
        } 

        #type > select{
            width: 120px;
            height: 30px;
            text-align: center;
            font-family: 'SUITE-Regular';
        }

        #type > select:hover{
           cursor: pointer;
           border: 2px solid rgb(135, 135, 135);
        }

        #memberInfo{
            padding: 25px;
        }

        #memberInfo >input:hover{
            border: 2px double rgb(88, 88, 88);
        }

        .a{
            font-size: small;
            font-family: 'Courier New', Courier, monospace;
        }

        #memberInfo > input{
            width: 200px;
            height: 40px;
            margin-top: 5px;
            font-family: 'SUITE-Regular';
        }

        #submit > button{
            width: 200px;
            height: 30px;
            background-color: rgb(220, 143, 0);
            border: 1px solid rgb(220, 143, 0);
            border-radius: 5px;
            font-family: 'SUITE-Regular';
        }

        #submit > button:hover{
            cursor:pointer ;
            font-weight: bolder; 
            border: 3px solid rgb(229, 172, 64);           
        }

        #user-find-or-join > a{
            text-decoration: none;
            font-weight: 500;
            color: black;
            font-weight: 600;
        }  

        #user-find-or-join > a:hover{
            color: rgb(126, 126, 126);
            cursor: pointer;
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
        <form action="login.member" method="post">
            <div id="memberInfo">
                <input type="text" required placeholder="아이디를 입력해주세요." name="memberId" />
                <br>
                <input type="password" required placeholder="비밀번호를 입력해주세요." name="memberPwd"/>
                <br>
            </div>
            <div id="type">
                <select name="categoryNo" id="memberType">
					<c:forEach items="${ memberCategory }" var="mc">
						<c:if test="${ mc.categoryName ne '정지' }">
	                    	<option value="${ mc.categoryNo }">${ mc.categoryName }</option>
						</c:if>
					</c:forEach>                
                </select>
            </div>
            <br>

            <div id="submit">
                <button>로그인</button>
            </div>
        </form>
        <br>
        <div id="user-find-or-join">
            <!-- header에 회원가입이 있다면 사라질 요소 -->
            <a href="join_enroll_form.member" class="a"> 회원가입 </a>|

            <a href="find_id.member" class="a"> 아이디 찾기 </a>|
            <a href="find_pwd.member" class="a"> 비밀번호 찾기</a>
        </div>
    </div>

	<jsp:include page="../common/footer.jsp" />




</body>
</html>