<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>내상점</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
    
  
    #content {
    background-color:rgb(247, 245, 245);
    width:65%;
    margin:auto;
    }

    .main-img{width: 250px; margin: 1px;}

    textarea{width: 500px; height: 300px;}
    
    .stor-title{font-size: 20px; font-weight: 1000;}

    .btn-1, .btn-2, .btn-3, .btn-4{width: 250px;
            margin-top: 10px;
            margin-left: 20px;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
        }
    .btn-2 {
        background-color: rgb(191, 26, 26);
        color: white;
    }
    .btn-3{
        background-color: green;
        color: white;
    }
    .btn-4{
        background-color: rgb(218, 130, 44);
        color: white;
    }
    .pro-img{width: 220px; height: 220px; display: inline-block;
        border-bottom: 1px solid black; }

    .pro-1{border: 1px solid black;
        width: 222px;
        height: 450px;
        display: inline-block;
        margin: 10px;
        background-color: white;
    }
    .pro-2 > div{margin: 5px;}

    .cat-list {float: right;
        margin-top: 20px;
        margin-right: 10px;
    }

    
    .cat-select{ 
        margin-top: 20px;
        margin-left: 10px;
    }
    .stor-title{
        font-size: 25px;
    }

    #pagingArea {width:fit-content; margin:auto;}
    </style>
</head>
<body>  <!-- 합 12 관격 정할수 있음 (col-1, col-9,) -->

	<jsp:include page="/WEB-INF/views/common/menubar.jsp" />

    <div class="container" id="content">
        <div class="row">
            <div class="col">
                <h2>내상점</h2>
                <h2>상점정보</h2>
                <br>
            </div>
            <hr>
            <div class="col"></div>
            <div class="col"></div>
            <div class="col"></div>
        </div>
        <div class="row">
            <div class="col-3">
                <div class="row">
                    <form>
                        <label class="stor-title">일이삼사오육칠팔구십</label>
                        <button type="submit" style="margin-bottom: 5px;">상점명수정</button>   <!-- 로그인 유저만 보이게 -->
                    </form>
                </div>
                <button>
                    <img src="resources/내상점이미지.png" alt="내상점이미지" class="main-img">
                </button>
                <div class="row">
                    <button class="btn-1">문의하기</button>
                    <button class="btn-2">신고하기</button>
                    <button class="btn-3">수정하기</button>
                    <button class="btn-4">상품등록</button>
                </div>
            </div>
            <div class="col">
                <div class="row">
                    <div class="col">
                        <br><br><br>
                        <label style="font-size: 20px;">상점 소개글</label>
                        <button type="ubmit">소개글수정</button>
                        <div style="border: 1px solid black; height: 305px; width: 500px; background-color: white; margin-top: 5px;" >
                            여기는 소개글 들어간다.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <br>

        <hr>
    <div class="여기만 페이징처리">   
        <div class="row">
            <div class="col">
                <h3>등록된 상품</h3>
            </div>
            <div class="col"></div>
            <div class="col"></div>
            <div class="col"></div>
            </div>
        </div>

        <br>

        <div class="row">
            <div class="col">
                <form class="cat-select">카테고리 >
                    <select>
                        <option>전체</option>
                        <option>유기농과일</option>
                        <option>유기농채소</option>
                        <option>못난이과일</option>
                        <option>못난이채소</option>
                    </select>
                </form>
            </div>
            <div class="col"></div>
            <div class="col"></div>
            <div class="col">
                <div class="cat-list">
                <a href="#">최신순</a> |
                <a href="#">인기순</a> |
                <a href="#">저가순</a> |
                <a href="#">고가순</a>
                </div>
            </div>
        </div>
        <br>

        <c:forEach items="${ products }" var="product">
		    <div class="pro-1" onclick="datail('${product.productNo }')">
		        <form>
		           <div>
		               <img src="${ product.image.changeImgName }" alt="상품이미지" class="pro-img">
		           </div>
			       <div class="pro-2">
			           <div style="font-size: 20px; height: 60px;">${ product.productName }</div>
			           <div style="font-size: 20px; font-weight: 550;">가격 : <span>${ product.productPrice }</span></div>
			           <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
			           <div style="font-weight: 550;">배송비 : <span>${ product.deliveryPrice }</span></div>
			           <div>등록일 : <span>${ product.productDate }</span></div>
			       </div>
		         </form>
		     </div>
		</c:forEach>

        <script>
        	function datail(num){
				location.href = `products/\${num}`;        		
        	}
        </script>
       

        <br><br><br>

        <div id="pagingArea">
            <ul class="pagination">
            
            <c:choose>
            	<c:when test="${ pageInfo.currentPage ne 1 }" >
                	<li class="page-item"><a class="page-link" href="products?page=${ pageInfo.currentPage - 1 }">이전</a></li>
                </c:when>
                <c:otherwise>
                	<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
				</c:otherwise>
            </c:choose>
            
            <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="num">
            	<li class="page-item"><a class="page-link" href="products?page=${ num }">${ num }</a></li>
            </c:forEach>
            
            <c:choose>
            	<c:when test="${ pageInfo.currentPage != pageInfo.endPage }">
                <li class="page-item"><a class="page-link" href="products?page=${ pageInfo.currentPage + 1 }">다음</a></li>
                </c:when>
                <c:otherwise>
                	<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
                </c:otherwise>
            </c:choose>
            
            
            </ul>
        </div>
    </div>

    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
</body>
</html>