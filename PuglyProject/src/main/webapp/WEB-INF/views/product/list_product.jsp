<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품리스트</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        .content {
            background-color:rgb(247, 245, 245);
            width:65%;
            margin:auto;
        }
        .cat-list {float: right;
                    margin-top: 20px;
                    margin-right: 10px;
        }
        .cat-select{ 
            margin-top: 20px;
            margin-left: 10px;
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
        .user-a > a{
            border: 1px solid black;
            font-size: 20px;
            border-radius: 10px;
            text-decoration: none;
            margin-right: 20px;
            width: 100px;
            text-align: center;
            
        }
        .product-save{
            float: right;
            background-color: rgb(218, 130, 44);
            color: white;
        }
        .mystore{
            float: right;
            color: black;

        }
        #pagingArea {width:fit-content; margin:auto;}



    </style>
</head>
    
    <jsp:include page="/WEB-INF/views/common/menubar.jsp" />
    
    <div class="content">
        <br>
        <div class="row">
            
            <div class="col">
                <h2 style="margin-left: 20px;">상품 리스트</h2>
            </div>
            <div class="user-a">
                <a href="insert_form" class="product-save">상품등록</a>
                <a href="mystore" class="mystore">내상점</a>
            </div>
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
            <div class="col">
                <div class="cat-list">
                <a href="#">최신순</a> |
                <a href="#">인기순</a> |
                <a href="#">저가순</a> |
                <a href="#">고가순</a>
                </div>
            </div>
        </div>
        <hr>
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
		

        <br><br>
        
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

    <br><br>

    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
</body>
</html>