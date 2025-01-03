<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Document</title>
    <style>
        #body{
            width: 1200px;
            margin: auto;
        }
        #body  div{
            border: 0.5px solid gray;
            text-align: center;
        }
        .textarea-regist{
            width: 700px;
            height: 400px;
        }
    </style>
</head>
<body>
    <div id="body">
    <jsp:include page="/WEB-INF/views/common/menubar.jsp" />
        <form action="regist.farm" method="post" enctype="multipart/form-data">

            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="container">
                        <div class="row">
                            <div class="col">
                                <h3>농장 등록하기</h3>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div>사진</div>
                                <input id="main" type="file" name="multi">
                                <input class="sub" type="file" name="multi">
                                <input class="sub" type="file" name="multi">
                                <input class="sub" type="file" name="multi">
                                <input class="sub" type="file" name="multi">
                                <input class="sub" type="file" name="multi">
                                <input class="sub" type="file" name="multi">
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                제목 : <input name="farmTitle" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div>내용</div>
                                <textarea class="textarea-regist" style="resize:none;" name="farmContent" required></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div>주의사항</div>
                                <textarea class="textarea-regist" style="resize:none;" name="bewareList" required></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div id="facility-box">
                                    <div>부대시설</div>
                                    <c:forEach items="${ facility }" var="f"> 
                                    <label>${ f.facilityName }</label><input name="facilityNo" value="${ f.facilityNo }" type="checkbox">
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                주소
                                <div class="container">
			                        <div class="row">
			                            <div class="col">
			                                <c:forEach items="${ state }" var="s">
			                                	<label>${ s.stateName }</label>
			                                	<c:choose>
			                                	<c:when test="${ address.stateCode eq s.stateCode }">
			                                	<input name="stateCode" value="${ s.stateCode }" type="radio" checked>
			                                	</c:when>
			                                	<c:otherwise>
			                                	<input name="stateCode" value="${ s.stateCode }" type="radio">
			                                	</c:otherwise>
			                                	</c:choose>
			                                </c:forEach>
			                            </div>
			                        </div>
			                    </div>
                                상세 주소 : <input type="text" name="district" value="${ address.district }">
                            </div>
                        </div>
                    </div>
                    
                    <div class="container">
                        <div class="row">
                            <div class="col-4">가격 <input type="number" name="farmPrice"></div>
                            <div class="col-4">
                            	품목
                            	<c:forEach items="${ product }" var="p">
                            		${ p.productName }<input type="radio" name="productName" value="${ p.productNo }">
                            	</c:forEach>
                            </div>
                            <div class="col-4">
                            	<input type="hidden" name="seller" value="${ sessionScope.loginUser.memberNo }">
                            	<input type="hidden" name="memberNo" value="${ sessionScope.loginUser.memberNo }">
                            	<input type="hidden" name="addressNo" value="${ address.addressNo }">
                            	<input type="hidden" name="categoryName" value="3">
                                <button class="btn btn-sm btn-outline-danger" type="button">취소하기</button>
                                <button class="btn btn-sm btn-outline-primary">등록하기</button></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>
</body>
</html>