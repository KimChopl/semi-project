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

        #find-id-btn{
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
        <c:if test="${ empty memberId }">
	        <form action="find_id.member" method="post">
	
	            <input type="text" class="input" placeholder="이름을 입력해주세요" name="memberName">
	            
	            <input type="text" class="input" placeholder="전화번호를 입력해주세요(-포함)" name="phone">
	            <br>
	            <br>
	            <select name="categoryNo" id="form">
	            <c:forEach items="${ memberCategory }" var="mc">
	            <c:if test="${ mc.categoryName ne '정지' }">
	                <option value="${ mc.categoryNo }">${ mc.categoryName }</option>
	            </c:if>
	            </c:forEach>
	            </select>
	            <br>
	            <button id="find-id-btn">아이디 찾기</button>
	        </form>
        </c:if>
        <c:forEach items="${ memberId }" var="mi">
        	<input type="text" class="input" value="${ mi }"  readonly/>
        </c:forEach>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>