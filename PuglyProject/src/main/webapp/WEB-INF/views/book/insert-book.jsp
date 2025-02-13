<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>${ farm.farmTitle }예약하기</title>
    <style>
        #body{
            margin: auto;
            width: 1200px;
        }
        div{
            text-align: center;
        }
        #text-booker{
            width: 95%;
            height: 450px;
        }
    </style>
</head>
<body>
<div id="body">
<jsp:include page="/WEB-INF/views/common/menubar.jsp" />
		<form action="/pugly/book/booking" method="post">
		<input type="hidden" name="farmNo" value="${farm.farmNo }">
	    <div class="container">
	        <div class="row">
	            <div class="col">
	                <div class="container">
	                    <div class="row">
	                        <div class="col">
	                            ${farm.farmTitle}
	                        </div>
	                    </div>
	                </div>
	                <div class="container">
	                    <div class="row">
	                        <div class="col">
	                            <div class="container">
	                                <div class="row">
	                                    <div class="col-4">
	                                    	<c:if test="${ empty bookDate }" > 
	                                    	<label>예약일 : <input type="date" name="playDate" required></label>
	                                    	</c:if>
	                                    	<c:if test="${ not empty bookDate }">
	                                        <label>예약일 : <input type="date" value="${ bookDate }" name="playDate" required></label> 
	                                        </c:if>
	                                    </div>
	                                    <div class="col-4">
	                                    	<c:if test="${ empty adult }"> 
	                                    	<label>성인 : <input type="number" value="0" name="adultNo" required> 명</label> 
	                                    	</c:if>
	                                    	<c:if test="${ not empty adult }"> 
	                                        <label>성인 : <input type="number" value="${ adult }" name="adultNo" required> 명</label> 
	                                        </c:if>
	                                    </div>
	                                    <div class="col-4">
	                                    <c:if test="${ empty kid }"> 
	                                    	<label>어린이 : <input type="number" value="0" name="kidNo" required> 명</label> 
	                                    </c:if>
	                                     <c:if test="${ not empty kid }"> 
	                                        <label>어린이 : <input type="number" value="${ kid }" name="kidNo" required> 명</label> 
	                                        </c:if>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="container">
	                                
	                                <div class="row">
	                                    <div class="col-4">
	                                        <label>전화번호 : <input type="text" name="phone" value="${ sessionScope.loginUser.phone }" required></label> 
	                                    </div>
	                                    <div class="col-8">
	                                        에붸붸붸뷉 뭐넣지
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="container">
	                    <div class="row">
	                        <div class="col">
	                        농장 주의 사항
	                            <p>${ farm.bewareList }</p>
	                        </div>
	                    </div>
	                </div>
	                <div class="container">
	                    <div class="row">
	                        <div class="col">
	                        농장주에게 전할 말
	                            <textarea style="resize:none;" id="text-booker" name="bookContent"></textarea>
	                        </div>
	                    </div>
	                </div>
	                <div class="container">
	                    <div class="row">
	                        <div class="col">
	                        농장 체험 유의 사항
	                            <p>관리자가 쓰는 곳(방칭 등등)</p>
	                        </div>
	                    </div>
	                </div>
	                <div class="container">
	                    <div class="row">
	                        <div class="col">
	                        	<input type="hidden" value="${ farm.farmNo }" name="farmNo">
	                            <button id="book">예약 하기</button> <button type="button" id="cancel">취소하기</button>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
		</form>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>
<script>

    window.onload = () =>{
        const textFormat = `어쩌구 저쩌구 여기에 양식 작성해주시면 됩니다.`;
        const textArea = document.getElementById('text-booker');
        textArea.value = textFormat;
        textArea.addEventListener('click', function(){
        	textArea.value = "";
        }, {once: true})
    }

</script>
<script>
	const cancel = document.getElementById('cancel');
	cancel.onclick = () => {
		location.href = "/pugly/farms";
	}
</script>
</body>
</html>