<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주소수정</title>
    <style>
    
        div{
            box-sizing: border-box;
        }
        
        #body{
            width: 600px;
            height: 520px;
            margin: auto;
            text-align: center;
        }

        .wrap{
            width: 500px;
            height: 120px;
            margin: auto;
            background-color: rgb(247, 247, 247);
            border-radius: 8px;
            margin-bottom: 10px;
            border-style: outset;
        }

        .select{
            width: 100px;
            height: 30px;
            text-align: center;
            position: relative;
            right:190px;
            top: 5px;
            font-size: 15px;
        }

        .input{
            width: 370px;
            height: 40px;
            position: relative;
            left:55px;
			bottom:70px;            
        }

        .btn1{
            width: 180px;
            height: 35px;
            position: relative;
            font-size: 14px;
            bottom: 50px;
        }
        
        .btn2{
	        width: 300px;
	        height: 40px;
            font-size: 14px;
            position: relative;
            bottom: 55px;
        }
		
		.p{
			font-weight: bolder;
			margin-top: 8px;
			margin-bottom: 5px;
			margin-left: 10px;
			padding: 0;
		}

    </style>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />
    
    <div id="body">
    	
    	<br>
    	<c:forEach items="${ addresses }" var="a">
	        <div class="wrap">
	            <form method="post" class="address-change">
	                <input type="hidden" name="addressNo" value="${ a.addressNo }" />
	                <input type="hidden" name="memberNo" value="${ sessionScope.loginUser.memberNo }" />
	                <select name="addressType" class="select">
	                	<option <c:if test ="${ a.addressType eq 1 }"> selected="selected"</c:if> value="1">메인배송지</option>
	                	<option <c:if test ="${ a.addressType eq 2 }"> selected="selected"</c:if> value="2">서브배송지</option>
	                </select>
	                <br>
	                <select name="stateCode" class="select">
	                <c:forEach items="${ stateCategory }" var="s">
	                    <option value="${ s.stateCode }" <c:if test ="${ a.stateCode eq s.stateCode }"> selected="selected"</c:if>>${ s.stateName }</option>
	                </c:forEach>
	                </select>
	                <br>
	                <br>
	                <input type="text" required class="input" value="${ a.district }" name="district"/>
	                <br>
	                <button class="btn1" onclick="updateAddress(1)">주소수정</button>
	                <button class="btn1" onclick="updateAddress(2)">주소삭제</button>
	            </form>
	        </div>
        </c:forEach>
        
        <c:if test="${addresses.size() lt 3}">
        <p class="p">새 주소 추가</p>
        <div class="wrap">
	            <form action="insert.address" method="post">
	                <input type="hidden" name="memberNo" value="${ sessionScope.loginUser.memberNo }" />
	                <select name="addressType" class="select">
	                	<option value="2">서브배송지</option>
	                	<option value="1">메인배송지</option>
	                </select>
	                <br>
	                <select name="stateCode" class="select">
	                <c:forEach items="${ stateCategory }" var="s">
	                    <option value="${ s.stateCode }">${ s.stateName }</option>
	                </c:forEach>
	                </select>
	                <br>
	                <br>
	                <input type="text" required class="input" name="district" placeholder="상세주소를 입력해주세요"/>
    				<button class="btn2">주소 추가</button>
	            </form>
	        </div>
        </c:if>
    </div>
    
    <script>
    	function updateAddress(num) {
    		let address = "";
    		
    		if(num == 1){
    			address += "update";
    		}
    		if(num == 2){
    			address += "delete";
    		}
			$('.address-change').attr("action", address+".address");
		}
    </script>


	<jsp:include page="../common/footer.jsp" />








</body>
</html>