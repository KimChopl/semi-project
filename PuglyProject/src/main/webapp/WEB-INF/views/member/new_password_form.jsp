<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 비밀번호 설정</title>

    
    <style>
        div{
            box-sizing: border-box;
        }

        #wrap{
            width: 350px;
            height: 300px;
            margin: auto;
            text-align: center;
            border-radius: 5px;
            background-color: rgb(245, 245, 245);
        }

        .input{
            width: 230px;
            height: 40px;
            margin: auto;
            margin-top: 20px;
            margin-bottom: 10px;
            font-family: 'SUITE-Regular' ;
        }

        #form{
            width: 100px;
            height: 30px;
            font-family: 'SUITE-Regular' ;
        }

        #find-pwd-btn{
            font-family: 'SUITE-Regular' ;
            width: 250px;
            height: 30px;
            margin-top: 30px;
            color: white;
            border-radius: 5px;
            border: none;
            background-color: forestgreen;
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
    
    <div id="wrap">
	        <form action="change_password.member" method="post">
	            <input type="text" class="input" name="memberId" readonly value="${ loginMember.memberId }" />
	            <input type="text" class="input" placeholder="새로운 비밀번호를 입력해주세요" name="memberPwd" />
	            
	            <br>
	            <br>
	            
	            <br>
	            <button id="find-pwd-btn">비밀번호 변경</button>
	        </form>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>