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
    <title>Document</title>

    <style>
        #body{
            width: 1200px;
            margin : auto;
        }
        div{
            border : 0.3px solid gray;
        }
        .book-box{
            height: 120px;
        }
        #acceptance{
            width: 100%;
            height: 500px;
        }
        #cover-btn{
            height: 50px;
            text-align: center;
        }
        #cancel-content{
            width: 100%;
            height: 300px;
        }
        .book-content:hover {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div id="body">
    	<jsp:include page="/WEB-INF/views/common/menubar.jsp" />
        <div class="container">
            <div class="row">
                <div class="col">
                    ${ sessionScope.loginUser.nickName }님 예약 현황
                </div>
            </div>
            <div class="row">
                <div class="col">
                <c:forEach items="${ books }" var="b">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="book-box">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-3">
                                                <div class="book-user">
                                                    예약자 닉네임 / 아이디 / 이름
                                                </div>
                                            </div>
                                            <div class="col-9">
                                                <div class="container">
                                                    <div class="row">
                                                        <div class="col-4">${ b.playDate }</div>
                                                        <div class="col-4">${ b.adultNo }</div>
                                                        <div class="col-4">${ b.kidNo }</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-3">
                                                <div class="farm-title">
                                                    ${ b.farmTitle }
                                                </div>
                                            </div>
                                            <div class="col-9">
                                                <div class="book-content">
                                                    ${ b.bookSub }
                                                    <button value="${ b.bookContent }" class="btn btn-sm btn btn-outline-dark book-content" data-bs-toggle="modal" data-bs-target="#booker-content">더보기</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="btn">
                                    	<c:if test="${ bookCancel ne null }">
                                        <button data-bs-toggle="modal" data-bs-target="#cancel" class="btn btn-danger">취소하기</button>
                                    	</c:if>
                                        <c:if test="${ sessionScope.loginUser.categoryNo eq 2 }">
                                        <button type="button" data-bs-toggle="modal" data-bs-target="#acceptance-btn" class="btn btn-primary">확정하기</button>
                                        </c:if>
                                        <c:if test="${ bookPlay eq null }">
                                        <button>리뷰하기</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
<div class="modal" tabindex="-1" id="acceptance-btn">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">예약 확정</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <div id="acceptance">
                <div class="container">
                    <div class="row">
                        <div class="col">
                                예약 관련 정보
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
          <button type="button" class="btn btn-primary">확정하기</button>
        </div>
      </div>
    </div>
  </div>
 
  <div class="modal" tabindex="-1" id="cancel">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">예약 취소</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div id="cancel-answer">
            <label>취소 사유</label>
            <div id="content">
                <textarea style="resize:none;" id="cancel-content"></textarea>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
          <button type="button" class="btn btn-primary">취소확정</button>
        </div>
      </div>
    </div>
  </div>
  <div class="modal" tabindex="-1" id="booker-content">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">예약자 편지</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p id="book-content">
          	
          </p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <script>
  	const moreContent = document.getElementsByClassName('book-content');
  	for(let i = 0; i < moreContent.length; i += 2)
	  	moreContent[i].addEventListener('click', function(e) {
	  		const bookContent = document.getElementById('book-content');
	  		bookContent.innerText = e.target.value;
  	})
  </script>
</body>
</html>