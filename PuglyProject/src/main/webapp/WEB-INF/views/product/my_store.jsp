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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
    
  
    #content {
    background-color:rgb(247, 245, 245);
    width:65%;
    margin:auto;
    }

    .main-img{width: 300px; height: 300px; margin: 1px;}

    
    .stor-title{font-size: 20px; font-weight: 1000;}

    .btn-1, .btn-2, .btn-3, .btn-4{
    		width: 250px;
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
    .pro-img{width: 196px; height: 220px; display: inline-block;
        border-bottom: 1px solid black; }

    .pro-1{border: 1px solid black;
        width: 198px;
        height: 470px;
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

    .mystore{
        float: right;
        color: black;
    }
    .mystore-save{
        float: right;
        background-color: rgb(218, 130, 44);
        color: white;
    }

    .store-img{
        width: 200px;
        height: 200px;
    }
    .main-h2{
        margin-left: 5px;
        margin-top: 10px;
    }


    #pagingArea {width:fit-content; margin:auto;}
    </style>
</head>
<body>  

	<jsp:include page="/WEB-INF/views/common/menubar.jsp" />

    <div class="container" id="content">
        <div class="row">
            <div class="col">
            <c:choose>
            	<c:when test="${ (sessionScope.loginUser.memberNo eq sessionScope.myStore.userNo) and (not empty sessionScope.myStore.storeNo) }">
                	<h2 class="main-h2">내상점</h2>
                </c:when>
                <c:otherwise>
                	<h2 class="main-h2">상점정보</h2>
                </c:otherwise>
             </c:choose>   
             
             <!-- 
             <p>storeNo : ${ sessionScope.myStore.storeNo }</p>
             <p>myStore 유저번호 : ${ sessionScope.myStore.userNo }</p>
             <p>loginUser 정보 : ${ sessionScope.loginUser.memberNo }</p>
              -->
             
             
                <br>
            </div>
            
            <div class="col"></div>
            <div class="col"></div>
            <div class="col"></div>
        </div>
        <hr>
        <div class="row">
            <div class="col-4">
                <div class="row">
                    <form>
                        <label class="stor-title">${ myStore.storeTitle }</label>
                    </form>
                </div>
                <div>
                    <img src="${ image.changeImgName }" alt="${ image.originImgName }" class="main-img">
                </div>
                <div class="row">
                	<c:choose>
						<c:when test="${ sessionScope.loginUser.memberNo eq sessionScope.myStore.userNo }">                	


                            <form action="/pugly/insert_form" method="get" style="margin: 0;">
			                    <button type="button" class="btn-3" data-bs-toggle="modal" data-bs-target="#mystoreUpdate">상 점 수 정</button>
		                        <button class="btn-4" type="submit">상 품 등 록</button>
                            </form>
                            
	                    </c:when>
                    	<c:otherwise>
		                    <button class="btn-1">문의하기</button>
		                    <button class="btn-2">신고하기</button>
                    	</c:otherwise>
                    </c:choose>
                    
                </div>
            </div>
            <div class="col">
                <div class="row">
                    <div class="col">
                        <br><br><br>
                        <label style="font-size: 20px;">소개글</label>
                        <div style="border: 1px solid black; height: 305px; width: 500px; background-color: white; margin-top: 5px;" >
                            ${ myStore.storeContent }
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
		           <div>
		               <img src="${ product.image.changeImgName }" alt="상품이미지" class="pro-img">
		           </div>
			       <div class="pro-2">
			           <div style="font-size: 20px; height: 60px;">${ product.productName }</div>
			           <div style="font-size: 20px; font-weight: 550;">가격 : <span>${ product.productPrice }</span></div>
			           <div style="font-size: 18px;">상품후기 :<span>★★★★☆</span></div>
			           <div style="font-weight: 550;">배송비 : <span>${ product.deliveryPrice }</span></div>
			           <div>등록일 : <span>${ product.productDate }</span></div>
			           
			           <div style="display: inline-block;">
			           
			           	<form action="/update.product" method="get" style="display:inline-block;">
			           		<input type="hidden" name="productNo" value="${ product.productNo }">
			           		<input type="hidden" name="changeImgName" value="${ product.image.changeImgName }">
			           		<button type="submit" class="btn btn-success">수정</button>
			           	</form>
			           
			            <form action="/pugly/delete.product" method="post" style="display: inline-block;">
                        <input type="hidden" name="productNo" value="${ product.productNo }">
                        <input type="hidden" name="changeImgName" value="${ product.image.changeImgName }">
                        <button type="submit" class="btn btn-danger">삭제</button>
                    	</form>
			           
			           </div>
			       </div>
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
                	<li class="page-item"><a class="page-link" href="${ myStore.storeNo }?page=${ pageInfo.currentPage - 1 }">이전</a></li>
                </c:when>
                <c:otherwise>
                	<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
				</c:otherwise>
            </c:choose>
            
            <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="num">
            	<li class="page-item"><a class="page-link" href="${ myStore.storeNo }?page=${ num }">${ num }</a></li>
            </c:forEach>
            
            <c:choose>
            	<c:when test="${ pageInfo.currentPage != pageInfo.endPage }">
                <li class="page-item"><a class="page-link" href="${ myStore.storeNo }?page=${ pageInfo.currentPage + 1 }">다음</a></li>
                </c:when>
                <c:otherwise>
                	<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
                </c:otherwise>
            </c:choose>
            
            
                </ul>
            </div>
        </div>


    <!-- Modal -->
<div class="modal fade" id="mystoreUpdate" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="staticBackdropLabel">상점 업데이트</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
          <form action="/pugly/update.store" method="post" enctype="multipart/form-data">
          <input type="hidden" name="storeNo" value="${ myStore.storeNo }" />
        <div class="modal-body">
            <div class="row">
                <div class="col">
                    <div class="img-fom">
                        <label>상점 이미지</label><br>
                        <img src="${ image.changeImgName }" class="store-img" id="title-img">
                    </div>
                    클릭하여 사진을 설정하세요.
                </div>
                <div class="col">
                    <label>상점명</label>
                    <input type="text" name="storeTitle" placeholder="${ myStore.storeTitle }">
                    <label>상점 소개글</label>
                    <textarea style="resize: none; width: 200px; height: 150px;" name="storeContent" placeholder="${ myStore.storeContent } "></textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            <button type="submit" class="btn btn-primary">수정하기</button>
            </div>
              <div id="file-area">
    			<input type="file" name="upfile" id="file1" required onchange="loadImg(this, 1);">
 			  </div>
          </form>
        </div>
      </div>
    </div>

  <script>
    function loadImg(inputFile, num){
    
        console.log(inputFile.files);
        
        if(inputFile.files.length === 1){
            const reader = new FileReader();
            reader.readAsDataURL(inputFile.files[0]);
            reader.onload = function(e){
            
                const url = e.target.result;
    
                switch(num){
                case 1 : $('#title-img').attr('src', url); break;
                }
            }
        } else {
            const crapImg = 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1veWFv.img?w=800&h=435&q=60&m=2&f=jpg';
            switch(num){
            case 1 : $('#title-img').attr('src',crapImg); break;
            }
        }
    };
    $(function(){
        $('#file-area').hide();
        $('#title-img').click(function(){
            $('#file1').click();
        });
    })
    
</script>  






    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
</body>
</html>