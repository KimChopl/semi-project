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
    <title>${ farm.farmTitle }</title>
    <style>
        body{
            width: 1200px;
            margin: auto;
        }
        div{
            height: auto;
        }
        
        #img-box{
            width: 900px;
            height: 600px;
            margin: auto;
        }
        #title-line{
            width: 100%;
            height: 60px;
            text-align: center;
        }
        #check-day, #person-count, #person-count > div, #book-btn-cover{
            width: 100%;
            text-align: right;
        }
        .person{
            display: inline-block;
            width: 80px;
            height: 28px;
            
        }
        .label-box{
            margin-right: 20px;
        }
        .col > div{
            width: 100%;
        }
        .review-img-box{
            width: 100%;
            height: 200px;
        }
        .review-img-box > img{
        	width : 100%;
        	height : 200px;
        }
        a{
            text-decoration: none;
            color : black;
            height: 100%;
            margin: 0;
        }
        p{
            margin: 0;
            height: 35px;
        }
        #subbar a{
            text-align: center;
        }
        #farms{
            width: 100%;
            height: 600px;
        }
        #farms  img{
            width: 100%;
            height: 598px;
        }
        .text-box{
        	width : 100%;
        	height : 400px;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/menubar.jsp" />
    <div id="body">
        <div class="contaniner">
            <div class="row">
                <div class="col">
                    <div id="title-line">
                        <h3>${ farm.farmTitle }</h3>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div id="img-box">
		                 <div id="farms" class="carousel slide">
                            <div class="carousel-indicators">
                            <c:forEach items="${ farm.imgList }" var="img" varStatus="crrent">
                            	<c:if test="${ img.status eq 'Y' }">
                            	<c:if test="${ img.imgLevel eq 1}">
	                             	 <button type="button" data-bs-target="#farms" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                            	</c:if>
                            	<c:if test="${ img.imgLevel ne 1 }"> 
                              		<button type="button" data-bs-target="#farms" data-bs-slide-to="${ crrent.index }" aria-label="Slide ${ crrent.count }"></button>
                            	</c:if>
                            	</c:if>
                            </c:forEach>
                            </div>
                            <div class="carousel-inner">
                            <c:forEach items="${ farm.imgList }" var="img" varStatus="crrent">
                            <c:if test="${ img.status eq 'Y' }">
                            	<c:choose>
                            		<c:when test="${ img.imgLevel eq 1 }">
                              <div class="carousel-item active">
                                <img src="/pugly/${ img.imgPath }${img.changeImgName}" class="d-block w-100" alt="${ img.originImgName }">
                              </div>
                            		</c:when>
                            		<c:when test="${ img.imgLevel eq 2 }">
                              <div class="carousel-item">
                                <img src="/pugly/${ img.imgPath }${img.changeImgName}" class="d-block w-100" alt="${ img.originImgName }">
                              </div>
                            		</c:when>
                            	</c:choose>
                            </c:if>
                            </c:forEach>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#farms" data-bs-slide="prev">
                              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#farms" data-bs-slide="next">
                              <span class="carousel-control-next-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">Next</span>
                            </button>
                          </div>   
                    </div>
                </div>
            </div>
            <div class="row" id="subbar">
                <div class="col-4">
                    <a href="#content-box"><p>내용</p></a>
                </div>
                <div class="col-4">
                    <a href="#review"><p>리뷰</p></a>
                </div>
                <div class="col-4">
                    <a href="#beware-box"><p>주의사항</p></a>
                </div>
            </div>
            <form action="/pugly/book" method="post" name="book">
            <div class="row">
                <div class="col-6">
                    <div id="check-day">
                        <label class="label-box">예약일 <input type="date" id="book-date" name="bookDate"></label>
                    </div>
                </div>
                <div class="col-3">
                    <div id="person-count">
                        <div id="adult">
                            <label class="label-box">성인 : <input type="number" class="person" id="adult-num" name="adult"> 명</label>
                        </div>
                        <div id="kid">
                            <label class="label-box">어린이 : <input type="number" class="person" id="kid-num" name="kid"> 명</label>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <div id="book-btn-cover">
                    	<input type="hidden" id="farmNo" value="${ farmNo }" name="farmNo"/>
                    	<c:if test="${ not empty sessionScope.loginUser && farm.seller ne sessionScope.loginUser.nickname}">
                        <button id="book">예약 하기</button>
                    	</c:if>
                    	<c:if test="${farm.seller eq sessionScope.loginUser.nickname }">
                    	<button type="button" id="modify">수정 하기</button>
                    	</c:if>
                    </div>
                </div>
            </div>
            </form>
            <div class="row">
                <div class="col">
                    <div id="facility-box">
	
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div id="content-box">
                        <textarea class="text-box" disabled>${ farm.farmContent }</textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div id="beware-box">
                        <textarea class="text-box" disabled>${ farm.bewareList }</textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div id="review">
                    <c:forEach items="${ review }" var="r">
                   
                    <c:choose>
                    <c:when test="${ not empty r }">
                        <div class="container">
                            <div class="row">
                                <div class="col-4">
                                    <div class="review-img-box">
                                        <img src="/pugly/${ r.imgList[0].imgPath }${ r.imgList[0].changeImgName}" alt="${ r.imgList[0].originImgName}">
                                    </div>
                                </div>
                                <div class="col-8">
                                    <div class="container">
                                        <div class="row">
                                        <div class="col-10">
	                                        <p>${ r.reviewTitle }</p>
                                        </div>
                                        <div class="col-2">
                                        	<p>${ r.rating }</p>
                                        </div>
                                        </div>
                                        <div class="row"><p>${ r.reviewContent }</p></div>
                                        <div class="row"><p>${ r.reviewer }</p></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    </c:choose>
                    </c:forEach>
                    </div>
                    <div class="container">
                        <div class="row col">
                            <div id="more"><button id="more-btn">더보기</button></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type=hidden id="plus" value="${ plusNo }" />
	<script>
	window.onload = () => {
		const moreBtn = document.getElementById('more-btn');
		const plusNo = document.getElementById('plus');
		const farmNo = document.getElementById('farmNo');
		moreBtn.onclick = () => {
			console.log(farmNo.value);
			console.log(plusNo.value);
			$.ajax({
				url : "/pugly/review",
				type : "get",
				data : {
					
					plusNo : plusNo.value,
					farmNo : farmNo.value
					
				},
				success : function(r){
					console.log(r);
					plusNo.value = r.mi.plusNo;
					const re = [...r.review];
					const result = re.map(e =>
						`<div class="container">
		                    <div class="row">
		                        <div class="col-4">
		                            <div id="review-img-box">
		                                <img src="" alt="\${ e.imgList[0].originImgName}">
		                            </div>
		                        </div>
		                        <div class="col-8">
		                            <div class="container">
		                                <div class="row">
		                                <div class="col-10">
		                                    <p>\${ e.reviewTitle }</p>
		                                </div>
		                                <div class="col-2">
		                                	<p>\${ e.rating }</p>
		                                </div>
		                                </div>
		                                <div class="row"><p>\${ e.reviewContent }</p></div>
		                                <div class="row"><p>\${ e.reviewer }</p></div>
		                            </div>
		                        </div>
		                    </div>
		                </div>`
					).join('');
					document.getElementById('review').innerHTML += result;
					if(r.mi.lastNo === r.mi.listCount){
						moreBtn.style.display = 'none';
					}
				}
			
			})
		}
	}
	</script>
	<script>
		const modifyBtn = document.getElementById('modify');
		const farm = document.getElementById('farmNo');
		const farmNo = farm.value;
		modifyBtn.addEventListener('click', () => {
			location.href = `/pugly/modify/farm?farmNo=\${farmNo}`
		})
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>