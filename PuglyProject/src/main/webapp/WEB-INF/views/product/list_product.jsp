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
                    margin-right: 20px;
                    margin-top: 50px;
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
        <hr>
        <br>
        
        <c:forEach items="${ products }" var="product">
		    <div class="pro-1" onclick="datail('${product.productNo }')">
		        <form>
		           <div>
		               <img src="${ product.newProductImg }" alt="상품이미지" class="pro-img">
		           </div>
			       <div class="pro-2">
			       		<p>product No : ${ product.productNo }</p>
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
                <li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">4</a></li>
                <li class="page-item"><a class="page-link" href="#">5</a></li>
                <li class="page-item"><a class="page-link" href="#">6</a></li>
                <li class="page-item"><a class="page-link" href="#">7</a></li>
                <li class="page-item"><a class="page-link" href="#">8</a></li>
                <li class="page-item"><a class="page-link" href="#">9</a></li>
                <li class="page-item"><a class="page-link" href="#">10</a></li>
                <li class="page-item"><a class="page-link" href="#">다음</a></li>
            </ul>
        </div>
    </div>

    <br><br>

    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
</body>
</html>