<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퍼플리 마켓</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
	    padding: 0;
	    width: 100%;
	    height: 100%;
        line-height: 1.6;
        
    }

    #container {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        box-sizing: border-box;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    #body1 {
	    height: 400px;
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	    gap: 20px;
	    text-align: center;
	    background-image: url('<c:url value="/resources/pugly/potato1.jpg" />');
	    background-size: cover;
	    background-position: center;
	    position: relative;
	    margin-bottom: 80px;
	}
	
	#body1::before {
	    content: "";
	    position: absolute;
	    top: 0;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    backdrop-filter: blur(5px); 
	    z-index: 1;
	}
	
	#body1 > * {
	    z-index: 2;
	}

    #body1 .top-buttons {
        display: flex;
        gap: 10px;
    }

    #body1 .category-button {
        padding: 10px 20px;
        border: 1px solid #ddd;
        background-color: #ff6f61;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    #body1 .category-button:hover {
        background-color: #ff4d4d;
    }

    #body1 .search-container {
        display: flex;
        gap: 10px;
    }

    #body1 input {
        padding: 10px;
        width: 300px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    #body1 .search-button {
        padding: 10px 20px;
        border: none;
        background-color: #6cbf84;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    #body1 .search-button:hover {
        background-color: #5aa970;
    }
    .pics {     
            width: 600px;
            float: left;
            position: relative;
            left: 50%;
            object-fit: cover;
        }

	.carousel-inner {
	            width: auto;
	            height: 500px;
	        }
	
	.carousel-item {
	            width: auto;
	            height: 100%;
	        }
	
	.d-block {
	            display: block;
	            width: auto;
	            height: 100%;
	        }
    
    #body3 {
        display: flex;
        justify-content: space-between;
        text-align: center;
        gap: 20px;
        margin-top: 100px;
        margin-bottom: 100px;
    }

    #body3 > div {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }

    #body3 img {
        width: 100px;
        height: auto;
        border-radius: 10px;
    }

    #body3 p {
        margin: 5px 0;
    }

     #body4 {
        height: auto; /* 높이를 자동으로 조정 */
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 10px; /* 각 요소 간의 간격 조정 */
        margin-bottom: 50px;
    }

    #body4 img {
        width: 100%;
        max-height: 300px;
        object-fit: cover;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    
    #body4 .carousel-inner {
	            width: auto;
	            height: 300px;
	        }
	
	#body4 .carousel-item {
	            width: auto;
	            height: 100%;
	        }
    
    #body4 .action-button {
        padding: 10px 20px;
        border: none;
        background-color: #ff6f61;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s ease;
        font-size: 16px;
        margin-top: 40px;
    }
    
    #body5 {
        height: 150px;
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 10px;
        color: white;
        background-color:rgb(65 75 90);
    }

    .action-button {
        width: auto; /* 자동 너비 */
        max-width: 200px; /* 최대 너비 제한 */
        padding: 10px 20px;
        border: none;
        background-color: #ff6f61;
        color: #fff;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s ease;
        font-size: 14px; /* 글씨 크기 */
    }

    .action-button:hover {
        background-color: #ff4d4d;
    }

</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/menubar.jsp" />

        <!-- Body 1: 검색 영역 -->
        <div id="body1">
            <div class="selected-text" id="selectedText" style="color:white; size : 20px;">농사! 여러분도 할 수 있어요!</div>
            <div class="top-buttons">
                <button class="category-button" onclick="changeText('농장')">농장</button>
                <button class="category-button" onclick="changeText('농산물')">농산물</button>
            </div>
            <div class="search-container">
                <input type="text" id="searchInput" placeholder="일일체험, 농장체험 등 농장과 관련된건 여기!">
                <button class="search-button">검색</button>
            </div>
        </div>

        <div id="body2" class="carousel slide" data-bs-ride="true">
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img src="<c:url value='/resources/pugly/slideImg3.png' />" class="d-block w-100" alt="...">
              </div>
              <div class="carousel-item">
                <img src="<c:url value='/resources/pugly/slideImg1.png' />" class="d-block w-100" alt="...">
              </div>
              <div class="carousel-item">
                <img src="<c:url value='/resources/pugly/slideImg2.png' />" class="d-block w-100" alt="...">
              </div>
              <div class="carousel-item">
                <img src="<c:url value='/resources/pugly/slideImg4.png' />" class="d-block w-100" alt="...">
              </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#body2" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#body2" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Next</span>
            </button>
          </div>

        <div id="body3">
	        <div>
	            <img src="<c:url value='/resources/pugly/img1.png' />" alt="아이콘 이미지" style="max-width: 100%; height: auto; border-radius: 10px;">
	            <p style="margin-top: 10px; font-weight: bold; font-size: 25px;">가장 손쉽게</p>
	            <p style="font-size: 15px;">간편하게 채소를 접해봐요</p>
	        </div>
	        <div>
	            <img src="<c:url value='/resources/pugly/img2.png' />" alt="아이콘 이미지" style="max-width: 100%; height: auto; border-radius: 10px;">
	            <p style="margin-top: 10px; font-weight: bold; font-size: 25px;">친환경 채소를 저렴하게!/p>
	            <p style="font-size: 15px;">합리적인 가격으로 만나요!</p>
	        </div>
	        <div>
	            <img src="<c:url value='/resources/pugly/img3.png' />" alt="아이콘 이미지" style="max-width: 100%; height: auto; border-radius: 10px;">
	            <p style="margin-top: 10px; font-weight: bold; font-size: 25px;">환경에 한 발 나은 선택</p>
	            <p style="font-size: 15px;">환경에 더 가까운 생산과 소비를 지지해요</p>
	        </div>
	    </div>

        <div id="body4">
            <h3 style="font-weight: bold; font-size: 40px;">개성있지만 싱싱해요!</h3>
            <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
			  <div class="carousel-inner">
			    <div class="carousel-item active">
			      <img src="<c:url value='/resources/pugly/ugly1.png' />" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item">
			      <img src="<c:url value='/resources/pugly/ugly2.png' />" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item">
			      <img src="<c:url value='/resources/pugly/ugly3.png' />" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item">
			      <img src="<c:url value='/resources/pugly/ugly4.png' />" class="d-block w-100" alt="...">
			    </div>
			  </div>
			  <br>
			  <a href="/pugly/products" class="action-button">제품 둘러보기</a>
			</div>
        </div>

        <!-- Body 5: 중앙 텍스트와 버튼 -->
        <div id="body5">
            <p>문의사항이 있다면?😁</p>
            <a href="/pugly/inquiries" class="action-button">문의게시판</a>
        </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        function changeText(category) {
            var text = "";
            var placeholderText = "";

            if (category === "농장") {
                text = "농사! 여러분도 할 수 있어요!";
                placeholderText = "일일체험, 농장체험 검색은 여기!";
            } else if (category === "농산물") {
                text = "못생겨도 맛은 名品!";
                placeholderText = "어글리 농산물 검색은 여기!";
            }

            document.getElementById("selectedText").innerText = text;
            document.getElementById("searchInput").placeholder = placeholderText;
        }

        window.onload = function() {
            changeText('농장');
        };
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
