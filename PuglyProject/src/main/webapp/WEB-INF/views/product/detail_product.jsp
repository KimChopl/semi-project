<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품상세보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        div{ margin: 5px;
 
        }

        .content {
            background-color:rgb(247, 245, 245);
            width:65%;
            margin:auto;
        }

        .pro-img{width: 250px; height: 250px;}

        .user-img{width: 50px;}

        .rep{border: 1px solid black;height: 100px; background-color: white;}
        .rep-btn {background-color: red; color: white;}
        .rep-text{width: 70%;
        height: 100px;}
                
    </style>

</head>
<body>
    
    <jsp:include page="/WEB-INF/views/common/menubar.jsp" />

    <div class="content">
        <br>
            <h2>상품 상세보기</h2>
            <hr>
        <div class="row">
            <div class="col">
                <h3>상점명나오는곳</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-3">
                <img src="${ product.newProductImg }" alt="상품이미지" class="pro-img">
            </div>
            <div class="col-7">
                <div>${ product.productName }</div>
                <div>${ product.productPrice }</div>
                <div>${ product.productQuantity } ${ product.unitName }</div>
                <div>${ product.deliveryPrice }</div>
                <div>${ product.productDate }</div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                버튼요소 들어갈꺼야
            </div>
            <div class="col"></div>
            <div class="col"></div>
            <div class="col"></div>
            <div class="col">
                <button>장바구니</button>
                <button>바로구매</button>
            </div>
        </div>

        <hr>

        <h3>상품설명</h3>
        <br>
        <div>${ product.productContent }</div>
        <br>
        <hr>
        <h3>상품후기</h3>

        <div style="border: 1px solid black; width: 70%;">
            <div style="display: inline-block;">
                <img src="resources/tomato.jpg" alt="사용자이미지" class="user-img">
                <span style="font-size: 20px; font-weight: 550;">사용자이름</span>
                <div>
                    <button type="submit" class="rep-btn2">추천하기</button>
                    <button type="submit" class="rep-btn">신고하기</button>
                </div>
            </div>
            <div class="rep">이건 후기글  이거 너무 맛있다 .</div>
        </div>

        <hr>

        <div>
            <h3>후기작성</h3>
            <form>
                <textarea class="rep-text"></textarea>
                <button type="submit">제출이요</button>
            </form>
        </div>














        
    </div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
</body>
</html>