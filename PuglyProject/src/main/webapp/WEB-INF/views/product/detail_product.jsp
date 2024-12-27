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

        .pro-img{width: 250px;}

        .user-img{width: 50px;}

        .rep{border: 1px solid black;height: 100px; background-color: white;}
        .rep-btn {background-color: red; color: white;}
        .rep-text{width: 70%;
        height: 100px;}
                
    </style>

</head>
<body>
    
    <!--<jsp:include page="" /> -->

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
                <img src="resources/tomato2.jpg" alt="상품이미지" class="pro-img">
            </div>
            <div class="col-7">
                <div>상품명이요</div>
                <div>상품가격이요</div>
                <div>상품 단위요</div>
                <div>배송비요</div>
                <div>상품등록일이요</div>
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
        <div>안녕하세요! 오늘은 정말 멋진 날이에요. :) 여러분은 어떻게 지내시나요? 제가 준비한 이야기를 들려드릴게요. 먼저, 세상은 참 신기하죠? @ 모든 곳에서 흥미로운 일이 일어나고 있으니까요. # 아, 그런데 혹시 여러분도 느끼셨나요? $ 우리는 매일 작은 기적들을 경험하고 있답니다. % 하늘을 올려다보면, 햇살이 따스하게 내리쬐는 모습도 참 멋져요. ^ 우리의 삶은 정말 놀랍습니다. & 이 모든 것을 즐기며 살아가는 게 중요해요. * 꼭 기억하세요! ( 지금부터는 또 다른 이야기를 들려드릴게요. ) 옛날 옛적에, - 한 마을에 멋진 영웅이 살고 있었어요. = 그의 이름은 '용감한 심장'이었답니다. + 그는 항상 마을 사람들을 돕기 위해 최선을 다했어요. { 그런데 어느 날, } 마을에 커다란 문제가 생겼습니다. [ 이 문제를 해결하기 위해, ] 그는 용감하게 나섰죠. : 사람들은 모두 그의 용기를 칭찬했어요. ; 그리고 마침내, " 그는 문제를 해결했답니다. ' 이렇게 해서 마을에는 평화가 찾아왔어요. < 정말 멋지죠? > 여러분도 그런 용기를 가지고 살아가면 좋겠어요. , 그리고 함께 나눌 이야기가 많으니, . 우리 모두 즐겁게 대화를 이어가요! ? 지금까지 제 이야기를 들어주셔서 감사합니다. / 다음에도 재미있는 이야기를 들려드릴게요. | 그럼 오늘도 행복한 하루 되세요! \
        </div>
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

<<<<<<< Updated upstream
=======
    <!--<jsp:include page="" /> -->
>>>>>>> Stashed changes
    
</body>
</html>