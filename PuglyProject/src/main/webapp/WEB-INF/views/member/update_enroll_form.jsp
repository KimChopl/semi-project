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
            /*border: 1px solid red;*/
            box-sizing: border-box;
        }
        
        #wrap{
            margin: auto;
            width: 400px;
            height: 415px;
            text-align: center;
            border-radius: 20px;
            background-color: rgb(245, 245, 245);
        }

        #image{
            border-radius: 100px;
            width: 100px;
            height: 100px;
            margin-left: 15px;
            margin-top: 15px;
            border: 1px solid black;
            background-color: white;
        }

        #file{
            position: relative;
            left: 100px;
            bottom: 80px;
        }

        input{
            width: 250px;
            height: 30px;
            margin: 5px;
            border-radius: 5px;
            
        }
        select{
            width: 100px;
            height: 25px;
        }

        button{
            width: 150px;
            height: 30px;
            margin-top: 5px;
            border-radius: 5px;
        }

        #update-member{
            background-color: rgb(68, 68, 255);
            border: 1px solid rgb(68, 68, 255);
            color: white;
        }

        #update-member:hover{
            background-color: rgb(30, 30, 253);
            border:2px double rgb(68, 68, 255)
        }

        #delete-member{
            background-color: rgb(255, 38, 0);
            border: 1px solid rgb(255, 38, 0);
            color: white;
        }

        #delete-member:hover{
            background-color: rgb(207, 31, 0);
            border:2px double rgb(255, 38, 0)
        }
        

    </style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <div id="wrap">
        <div id="image"></div>
        <form action="update.memberInfo" method="post">
            <input type="hidden" value="${ sessionScope.loginUser.memberNo }" name="memberNo"/>
            <input type="file" id="file" name="img"/>
            <input type="text" value="${ sessionScope.loginUser.nickName }" name="nickName"/>
            <!-- ajax를 사용해서 비밀번호가 같은지 검사 -->
            <input type="password" placeholder="변경 전 비밀번호를 입력해주세요" name="password"/>
            <br>
            <input type="password" placeholder="새 비밀번호" name="memberPwd"/>
            <br>
            <input type="text" value="${ sessionScope.loginUser.phone }" name="phone"/>
            <br>
            <button id="update-member">수정하기</button>
        </form>
        <br>
        <button id="delete-member">회원탈퇴</button>
    </div>

    <script>
        $('#delete-member').on('click', function(){
            //console.log(1);
            location.href = 'delete.enrollForm'
        });

    </script>


</body>
</html>