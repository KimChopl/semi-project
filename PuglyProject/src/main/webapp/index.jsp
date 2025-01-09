<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퍼플리 마켓</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        line-height: 1.6;
    }

    #container {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        box-sizing: border-box;
    }

    #body1, #body2, #body3, #body4, #body5 {
        margin-bottom: 20px;
        padding: 10px;
        border: 1px solid #ddd;
        box-sizing: border-box;
    }

    /* Body1 - 검색 영역 */
    #body1 {
        height: 400px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 20px;
    }

    #body1 .top-buttons {
        display: flex;
        gap: 10px;
    }

    #body1 .search-container {
        display: flex;
        gap: 10px;
    }

    #body1 input {
        padding: 10px;
        width: 300px;
        border: 1px solid #ddd;
    }

    #body1 button {
        padding: 10px 20px;
        border: 1px solid #ddd;
        background-color: #fff;
        cursor: pointer;
    }

    /* Body2 - 슬라이드 이미지 */
    #body2 {
        height: 700px;
        background-color: #f4f4f4;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* Body3 - 텍스트 영역 (3칸) */
    #body3 {
        height: 300px;
        display: flex;
        justify-content: space-between;
        text-align: center;
    }

    #body3 > div {
        flex: 1;
        margin: 0 10px;
        padding: 10px;
        border: 1px solid #ddd;
    }

    /* Body4 - 상단 텍스트, 중간 이미지, 하단 버튼 */
    #body4 {
        height: 500px;
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    #body4 img {
        width: 100%;
        max-height: 300px;
        object-fit: cover;
    }

    /* Body5 - 중앙 텍스트와 버튼 */
    #body5 {
        height: 150px;
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    /* 버튼 크기 줄이기 */
    #body4 button, #body5 button {
        padding: 6px 12px; /* 크기 더 축소 */
        font-size: 12px;   /* 글자 크기 더 축소 */
    }

    /* 텍스트 공간 추가 */
    #body1 .selected-text {
        font-size: 16px;
        color: #333;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/menubar.jsp" />

    <div id="container">
        <!-- Body 1: 검색 영역 -->
        <div id="body1">
            <!-- 선택된 항목에 따른 텍스트 -->
            <div class="selected-text" id="selectedText">농장에 대한 다양한 정보가 여기에 표시됩니다.</div>

            <!-- 상단의 버튼들 (수평) -->
            <div class="top-buttons">
                <button onclick="changeText('농장')">농장</button>
                <button onclick="changeText('농산물')">농산물</button>
            </div>

            <!-- 입력창과 검색 버튼 (수평) -->
            <div class="search-container">
                <input type="text" id="searchInput" placeholder="농장 관련 키워드를 입력하세요">
                <button>검색</button>
            </div>
        </div>

        <!-- Body 2: 슬라이드 이미지 -->
        <div id="body2">
            <p>슬라이드 이미지 공간</p>
        </div>

        <!-- Body 3: 텍스트 영역 (3칸) -->
        <div id="body3">
            <div>
                <p>가장 손쉽게<br>간편하게</p>
            </div>
            <div>
                <p>진한 농산물<br>저렴하게</p>
            </div>
            <div>
                <p>믿음으로 만든<br>상품 UP!</p>
            </div>
        </div>

        <!-- Body 4: 상단 텍스트, 중간 이미지, 하단 버튼 -->
        <div id="body4">
            <h3>개성있게 신선하게</h3>
            <img src="https://via.placeholder.com/400x300" alt="상품 이미지">
            <button>제품 둘러보기</button>
        </div>

        <!-- Body 5: 중앙 텍스트와 버튼 -->
        <div id="body5">
            <p>궁금한 사항은?</p>
            <button>문의게시판</button>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- JavaScript: 버튼 클릭 시 텍스트 및 검색창 업데이트 -->
    <script>
        function changeText(category) {
            var text = "";
            var placeholderText = "";

            if (category === "농장") {
                text = "농장에 대한 다양한 정보가 여기에 표시됩니다.";
                placeholderText = "농장 관련 키워드를 입력하세요";
            } else if (category === "농산물") {
                text = "농산물에 대한 다양한 정보가 여기에 표시됩니다.";
                placeholderText = "농산물 관련 키워드를 입력하세요";
            }

            // 텍스트와 입력창의 placeholder 업데이트
            document.getElementById("selectedText").innerText = text;
            document.getElementById("searchInput").placeholder = placeholderText;
        }

        // 기본값으로 '농장' 설정
        window.onload = function() {
            changeText('농장');
        };
    </script>
</body>
</html>