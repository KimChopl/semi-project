<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>내상점</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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

    .btn-1, .btn-2{width: 250px;
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
    .pro-img{width: 218px; display: inline-block;}

    .pro-1{border: 1px solid black;
        width: 220px;
        height: 500px;
        display: inline-block;
        margin: 5px;
    }
    .pro-2 > div{margin: 15px;}

    #pagingArea {width:fit-content; margin:auto;}
    </style>
</head>
<body>  <!-- 합 12 관격 정할수 있음 (col-1, col-9,) -->
    <div class="container" id="content">
        <hr>
        <div class="row">
            <div class="col">
                <h2>내상점</h2>
                <h2>상점 정보</h2>
                <br>
            </div>
            <div class="col"></div>
            <div class="col"></div>
            <div class="col"></div>
        </div>
        <div class="row">
            <div class="col-3">
                <div class="row">
                    <form>
                        <label class="stor-title">감자입니다</label>
                        <button type="submit" style="margin-bottom: 5px;">상점명수정</button>   <!-- 로그인 유저만 보이게 -->
                    </form>
                </div>
                <button>
                    <img src="resources/img/tomato2.jpg" alt="내상점이미지" class="main-img">
                </button>
                <div class="row">
                    <button class="btn-1">문의하기</button>
                    <button class="btn-2">신고하기</button>
                </div>
            </div>
            <div class="col">
                <div class="row">
                </div>
                <div class="row">
                    <div class="col">
                        <label>상점 소개글</label>
                        <button type="ubmit">소개글수정</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div style="border: 1px solid black; height: 305px; width: 500px; background-color: white; margin-top: 5px;" >
                            여기는 소개글 들어간다.
                        </div>
                    </div>
                </div>
            </div>
            <div class="col"></div>
        </div>
        <div class="row"></div>
        <div></div>
            <hr>
    <div class="여기만 페이징처리">   
        <div class="row">
            <div class="col">
                <h3>등록된 상품</h3>
            </div>
            <div class="col"></div>
            <div class="col"></div>
            <div class="col">
                <div style="float: right; margin-top: 10px;">
                <a href="#">최신순</a> |
                <a href="#">인기순</a> |
                <a href="#">저가순</a> |
                <a href="#">고가순</a> 
                </div>
            </div>
        </div>
    

        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구십일이삼사오육칠팔구십</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>
        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구십일이삼사오육칠팔구십</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>
        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구십일이삼사오육칠팔구십</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>
        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구십일이삼사오육칠팔구십</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>
        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구십일이삼사오육칠팔구십</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>

        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>
        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>
        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>
        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>
        <div class="pro-1">
            <form>
                <div>
                    <img src="resources/img/tomato2.jpg" alt="상품이미지" class="pro-img">
                </div>
            <div class="pro-2">
                <div style="font-size: 20px;">일이삼사오육칠팔구</div>
                <div style="font-size: 20px; font-weight: 550;">가격 : <span>13,000</span></div>
                <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
                <div style="font-weight: 550;">배송비 : <span>무료</span></div>
                <div>등록일 : <span>2024-12-25</span></div>
            </div>
            </form>
        </div>

        <br><br><br>

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


    </div>
</body>
</html>