<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        .user-img{width: 50px;}

        .rep{border: 1px solid black;height: 100px; background-color: white;}
        .rep-btn {background-color: red; color: white;}
        .rep-text{width: 70%;
        height: 100px;}

        /* Slideshow container */
        .slideshow-container {
        max-width: 400px;
        position: relative;
        margin: auto;
        }

        /* Hide the images by default */
        .mySlides {
        display: none;
        }
        .mySlides > img{width: 400px; height: 400px;}

        /* Next & previous buttons */
        .prev, .next {
        cursor: pointer;
        position: absolute;
        top: 50%;
        width: auto;
        margin-top: -22px;
        padding: 16px;
        color: white;
        font-weight: bold;
        font-size: 18px;
        transition: 0.6s ease;
        border-radius: 0 3px 3px 0;
        user-select: none;
        }

        /* Position the "next button" to the right */
        .next {
        right: 0;
        border-radius: 3px 0 0 3px;
        }

        /* On hover, add a black background color with a little bit see-through */
        .prev:hover, .next:hover {
        background-color: rgba(0,0,0,0.8);
        }

        /* Caption text */
        .text {
        color: #f2f2f2;
        font-size: 15px;
        padding: 8px 12px;
        position: absolute;
        bottom: 8px;
        width: 100%;
        text-align: center;
        }

        /* Number text (1/3 etc) */
        .numbertext {
        color: #f2f2f2;
        font-size: 12px;
        padding: 8px 12px;
        position: absolute;
        top: 0;
        }

        /* The dots/bullets/indicators */
        .dot {
        cursor: pointer;
        height: 15px;
        width: 15px;
        margin: 0 2px;
        background-color: #bbb;
        border-radius: 50%;
        display: inline-block;
        transition: background-color 0.6s ease;
        }

        .active, .dot:hover {
        background-color: #717171;
        }

        /* Fading animation */
        .fade {
        animation-name: fade;
        animation-duration: 1.5s;
        }
        .mystore{font-size: 25px; text-decoration: none; color: black; margin: 20px;}
        .product-title{font-size: 25px;}
        .product-price{font-size: 30px;}
        .product-quantity{font-size: 20px;}
        .delivery-price{font-size: 20px;}
        .product-date{font-size: 20px;}
        .product-content{font-size: 18px; margin-left: 15px;}

        .btn-1{width: 150px; height: 50px; border-radius: 10px; float: left; font-size: 25px; background-color: rgb(218, 130, 44);}
        .btn-2{width: 150px; height: 50px; border-radius: 10px; float: right; font-size: 25px;}
                
    </style>

</head>
<body>
    
    <jsp:include page="/WEB-INF/views/common/menubar.jsp" />

    <div class="content">
        <br>
            <h2 style="margin : 20px">상품 상세보기</h2>
            <hr>
        <div class="row">
            <div class="col">
                <a href="#" class="mystore">상점명</a>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="slideshow-container">
				

				
				<c:forEach var="img" items="${ imageList }">
                    <div class="mySlides">
                    <div class="numbertext">${ img.imgLevel } / ${ product.imageList.size() }</div>
                    <img src="/pugly/${ img.imgPath }${ img.changeImgName }">
                    </div>
                </c:forEach>
                    
                    
                    <a class="prev" onclick="plusSlides(-1)">❮</a>
                    <a class="next" onclick="plusSlides(1)">❯</a>
                    
                </div>
                <br>
                
                <div style="text-align:center">
                	<c:forEach var="img" items="${ imageList }" varStatus="status">
                	    <span class="dot" onclick="currentSlide(${status.index + 1})"></span>
                	</c:forEach> 

                </div>
            </div>


            <div class="col">
                <div class="product-title">상품명 : ${ product.productName }</div>
                <br>
                <div class="product-price">상품가격 : ${ product.productPrice } 원</div>
                <br>
                <div class="product-quantity">수량 : ${ product.productQuantity } ${ product.unitName }</div>
                <br>
                <div class="delivery-price">배송비 : 
                
                      <c:choose>
				           <c:when test="${ product.deliveryPrice ne '무료' }">
				           	${ product.deliveryPrice }원
				           </c:when>
				           <c:otherwise>
				           	${ product.deliveryPrice }
				           </c:otherwise>
			           </c:choose>
                
                </div>
                <br>
                <div class="product-date">등록일 : ${ product.productDate }</div>
            </div>

        <div class="row">
            <div class="col"></div>
            <div class="col"></div>
            <div class="col"></div>
            <div class="col"></div>
            <div class="col">
                <button class="btn-2">장바구니</button>
            </div>
            <div class="col">
                <button class="btn-1">바로구매</button>
            </div>
        </div>
        <br>

        <h3 style="margin-left: 20px;">상품설명</h3>
        <br>
        <div class="product-content">${ product.productContent }</div>
        <br><br><br>
        
        <h3 style="margin-left: 20px;">상품후기</h3>


        <div style="border: 1px solid black; width: 70%; margin : 5px; margin-left: 20px;" >
            <div>
                <img src="" alt="사용자이미지" class="user-img">
                <span style="font-size: 20px; font-weight: 550;">사용자이름</span>
                <div>
                    <button type="submit" class="rep-btn2">추천하기</button>
                    <button type="submit" class="rep-btn">신고하기</button>
                </div>
            </div>
            <div class="rep">이건 후기글  이거 너무 맛있다 .</div>
        </div>
        <div style="border: 1px solid black; width: 70%; margin : 5px; margin-left: 20px;" >
            <div>
                <img src="" alt="사용자이미지" class="user-img">
                <span style="font-size: 20px; font-weight: 550;">사용자이름</span>
                <div>
                    <button type="submit" class="rep-btn2">추천하기</button>
                    <button type="submit" class="rep-btn">신고하기</button>
                </div>
            </div>
            <div class="rep">이건 후기글  이거 너무 맛있다 .</div>
        </div>


        <div>
            <br>
        </div>
        

        <div>
            <h3 style="margin-left: 20px;">후기작성</h3>
            <form>
                <textarea class="rep-text"></textarea>
                <button type="submit">제출이요</button>
            </form>
        </div>

    	</div>
	</div>
        <script>
            let slideIndex = 1; // 첫 번째 슬라이드 인덱스
            showSlides(slideIndex); // 초기 슬라이드 표시

            // 이전/다음 버튼으로 슬라이드를 변경
            function plusSlides(n) {
            showSlides(slideIndex += n);
            }

            // 점(dot)을 클릭했을 때 슬라이드를 변경
            function currentSlide(n) {
            showSlides(slideIndex = n);
            }

            // 슬라이드를 표시하는 함수
            function showSlides(n) {
            let i;
            let slides = document.getElementsByClassName("mySlides");
            let dots = document.getElementsByClassName("dot");

            // 슬라이드 인덱스가 범위를 벗어나는 경우 처리
            if (n > slides.length) { slideIndex = 1 } // 마지막 다음은 첫 번째로
            if (n < 1) { slideIndex = slides.length } // 첫 번째 이전은 마지막으로

            // 모든 슬라이드를 숨기기
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }

            // 모든 점(dot) 활성화 클래스 제거
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }

            // 현재 슬라이드와 점(dot) 활성화
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
            }
        </script>











        

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
</body>
</html>