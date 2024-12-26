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
        #wrap{
            box-sizing: border-box;
            margin: auto;
            /*border: 1px solid red;*/
            text-align: center;
            width: 400px;
            height: 300px;
            background-color: rgb(243, 243, 243);
            border-radius: 5px;
        }

        input{
            width: 250px;
            height: 30px;
            margin-top: 10px;
            margin-bottom: 3px;
            border-radius: 5px;
            border: 1px solid;
        }

        div{
            width: 400px;
            height: 50px;
        }

        select{
            width: 70px;
            height: 25px;
            margin-left: 10px;
        }

        button{
            width: 100px;
            height: 30px;
            color: white;
            border-radius: 3px;
            background-color: rgb(0, 141, 7);
            border: none;
        }

        button:hover{
            background-color: green;
            border: 3px double rgb(0, 141, 7);
        }

    </style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />
    
    <div id="wrap">
        <form action="insert.member" method="post">
            <div>
                <input type="text" placeholder="이름" name="memberName" required/>
            </div>
            <div>
                <input type="text" placeholder="아이디" name="memberId" required/>
            </div>
            <div>
                <input type="text" placeholder="비밀번호" name="memberPwd" required/>
            </div>
            <div>
                <input type="text" placeholder="닉네임" name="nickname" />
            </div>
            <div>
                <input type="text" placeholder="전화번호 (-포함)" required/>
            </div>
            <div>
                <select name="stateCode">
                <c:forEach var="sc" items="${ stateCategory }">
                    <option value="${ sc.stateCode }">${ sc.stateName }</option>
                </c:forEach>
                </select>
                <input type="text" placeholder="상세주소" required />
            </div>
            
            <div>
                <button>회원가입</button>
                <select name="categoryNo">
                    <option value="3">일반</option>
                    <option value="2">판매자</option>
                    <option value="1">관리자</option>
                </select>
        	</div>
       </form>
        
    </div>

	<!--  
	<jsp:include page="../common/footer.jsp" />
	-->



    
</body>
</html>
