<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 예약 목록</title>

<style>
    	div{
            box-sizing: border-box;
        }

        #body{
            width: 650px;
            height: 500px;
            margin: auto;
        }

        .text-center{
			margin: auto;
			width: 220px;
			text-align: center;
		}
        
        .text-center > ul > li{
	        margin:0 auto;
			text-align: center;
		}
        

        #wrap{
            width: 600px;
            height: 180px;
            margin: auto;
            margin-top: 10px;
            border-radius: 5px;
            background-color: rgb(250, 250, 250);
            text-align: center;
            border: outset;
        }

        #book-date{
            width: 110px;
            height: 50px;
            position: relative;
            top: 35px;
            left: 350px;
        }
		

        #play-date{
            width: 110px;
            height: 50px;
            position: relative;
            top: 40px;
            left: 350px;
        }
        
		#decide{
			width: 50px;
            height: 50px;
            position: relative;
            bottom: 195px;
            left: 405px;		
		}
		
        #pay{
            width: 50px;
            height: 50px;
            position: relative;
            bottom: 345px;
            left: 350px;
        }
        
        #play{
            width: 50px;
            height: 50px;
            position: relative;
            bottom: 295px;
            left: 475px;
        }

        #cancel{
        	width: 50px;
            height: 50px;
            position: relative;
            bottom: 245px;
            left: 530px;
        }

        
        #farm-name{
            width: 150px;
            height: 25px;
            position: relative;
            left: 190px;
            top:25px;
            text-align: left;
        }
        
        #total-play-people{
            width: 90px;
            height: 25px;
            position: relative;
            bottom: 55px;
            left: 470px;
        }

        #adult{
            width: 80px;
            height: 25px;
            position: relative;
            bottom: 50px;
            left: 475px;
        }

        #kid{
            width: 80px;
            height: 25px;
            position: relative;
            bottom: 45px;
            left: 475px;
        }
        
        #img{
        	width: 150px;
            height: 150px;
            position: relative;
            bottom: 390px;
            left: 10px;
        }
        
        .img{
        	width: 100%;
        	height: 100%;
        }


        .button{
            width: 600px;
            height: 30px;
            background-color: rgb(87, 87, 255);
            color: white;
            position: relative;
            margin-top: 5px;
            left: 25px;
            font-family: 'SUITE-Regular';
        }

        .span{
            width: 90%;
            height: 80%;
            margin: 0;
            padding: 0;
            background-color: rgb(250, 250, 250);
            border: none;
            font-family: 'SUITE-Regular'; 
        }
        @font-face {
            font-family: 'SUITE-Regular';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
            font-weight: 400;
            font-style: normal;
        }

</style>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<jsp:include page="../common/menubar.jsp" />

    <div id="body">
    <c:forEach items="${ list }" var="b">
        <div id="wrap">
            <div id="farm-name">
                <span class="span">${ b.farmTitle }</span>
            </div>
            <div id="book-date">
                <span class="span">예약 등록일<br>${ b.bookDate }</span>
            </div>
            <div id="play-date">
                <span class="span">체험일<br>${ b.playDate }</span>
            </div>
            <div id="total-play-people">
                <span class="span">예약 인원</span>
            </div>
            <div id="adult">
                <span class="span">성인 : ${ b.adultNo }</span>
            </div>
            <div id="kid">
                <span class="span">아이 : ${ b.kidNo }</span>
            </div>
            <div id="decide">
	            <span class="span">승인<br> 
		            <c:choose>
						<c:when test="${ not empty b.decide }">
							완료
						</c:when>
						<c:otherwise>
							대기
						</c:otherwise>
					</c:choose>
	            </span>
            </div>
            <div id="cancel">
	            <span class="span">
					<c:if test="${ not empty b.cancel }">
						취소완료
					</c:if>
	            </span>
            </div>
            <div id="play">
                <span class="span">
					<c:if test="${ not empty b.play }">
						체험완료
					</c:if>
				</span>
            </div>
            <div id="pay">
                <span class="span">결제<br> 
	                <c:choose>
		                <c:when test="${ not empty b.pay }">완료</c:when>
		                <c:otherwise>
		                	대기
		                </c:otherwise>
	                </c:choose>
                </span>
            </div>
            <div id="img">
            		<img src="${ b.image.imgPath }${ b.image.changeImgName }" class="img">
            </div>
        </div>
    </c:forEach>
    <div class="text-center">
	        <ul class="pagination">
		            <li class="page-item" id="pro"><a class="page-link" href="select.myBook?memberNo=${ sessionScope.loginUser.memberNo }">이전</a></li>
		        <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="i">
		        
		            <li class="page-item"><a class="page-link" href="select.myBook?memberNo=${ sessionScope.loginUser.memberNo }&currentPage=${i}">${ i }</a></li>
		        
		        </c:forEach>
		            <li class="page-item" id="next"><a class="page-link" href="select.myBook?memberNo=${ sessionScope.loginUser.memberNo }&currentPage=${pageInfo.endPage + 1 }">다음</a></li>
	        </ul>
        </div>
</div>

<script>
    	let endPage = "${pageInfo.endPage}";
    	let maxPage = "${pageInfo.maxPage}";
    	let pageLimit = "${pageInfo.pageLimit}";
    	let currentPage = "${pageInfo.currentPage}";
    	
    	if(maxPage <= pageLimit){
    		$("#next").attr("class", "page-item disabled")
    	}
    	
    	if(endPage == maxPage){
    		$("#next").attr("class", "page-item disabled")
    	}
    	
    	if(currentPage <= pageLimit){
    		$("#pro").attr("class", "page-item disabled")
    	}
    	
    </script>

<jsp:include page="../common/footer.jsp" />

</body>
</html>