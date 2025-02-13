<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <meta charset="UTF-8">
    <title>상품등록하자</title>
    <style>
       /* div{border: 1px solid red;}  */
        .content {
            background-color:rgb(247, 245, 245);
            width:65%;
            margin:auto;
        }
        .main-img{
            width: 200px;
            height: 200px;
        }
        .img{
            width: 150px;
            height: 150px;
            display: inline;
        }
        .img-btn{
            border: none;
            background: none;
        }
        .save-btn > button{
            float:right;
            width: 150px;
            height: 70px;
            margin: 1%;
            font-size: 20px;
            font-weight: 700;
            border-radius: 10px;

        }
        #confirmation{
            background-color: rgb(218, 130, 44);   
            color: wheat;         
        }
        .title{
            font-size: 20px;
            font-weight: 600;
            padding-left: 1%;
        }
        .text-title{
            width: 250px;
            height: 30px;
            margin-left: 3%;
        }
        .text-name{
            width: 500px;
            height: 30px;
        }
        .img-fom{
            display: inline-block;
            margin-inline-start: 70px;
        }

    </style>
</head>
<body>


	<jsp:include page="/WEB-INF/views/common/menubar.jsp" />

    <div class="content">
    
            <h2>상품 등록</h2>
            <hr>
            <div class="상품 이미지 보여주는 칸">
                
                            <div>
                <span>상품이미지</span>
                <span>(</span>
                <span>0</span>
                <span>/ 5 )</span>
            </div>
            <br>
        <form action="insert.pro" method="post" enctype="multipart/form-data">
            <div>                
            <div class="img-fom">
                <label>대표이미지</label><br>
                <img src="resources/img/mainImg.png" class="main-img" id="title-img">
            </div>
            <div class="img-fom">
                <label>상세이미지-1</label><br>
                <img src="resources/img/img.png" class="img" id="sub-img1">
            </div>
            <div class="img-fom">
                <label>상세이미지-2</label><br>
                <img src="resources/img/img.png" class="img" id="sub-img2">
            </div>
            <div class="img-fom">
                <label>상세이미지-3</label><br>
                <img src="resources/img/img.png" class="img" id="sub-img3">
            </div>
            <div class="img-fom">
                <label>상세이미지-4</label><br>
                <img src="resources/img/img.png" class="img" id="sub-img4">
            </div>
                <br><br>
            
	        <div id="file-area">
                <input type="file" name="upfile" id="file1" required onchange="loadImg(this, 1);">
                <input type="file" name="upfile" id="file2" onchange="loadImg(this, 2);">
                <input type="file" name="upfile" id="file3" onchange="loadImg(this, 3);">
                <input type="file" name="upfile" id="file4" onchange="loadImg(this, 4);">
                <input type="file" name="upfile" id="file5" onchange="loadImg(this, 5);">
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
            				case 2 : $('#sub-img1').attr('src', url); break;
            				case 3 : $('#sub-img2').attr('src', url); break;
            				case 4 : $('#sub-img3').attr('src', url); break;
            				case 5 : $('#sub-img4').attr('src', url); break;
            				}
            			}
            		} else {
            			const crapImg = 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1veWFv.img?w=800&h=435&q=60&m=2&f=jpg';
            			switch(num){
            			case 1 : $('#title-img').attr('src',crapImg); break;
            			case 2 : $('#sub-img1').attr('src',crapImg); break;
            			case 3 : $('#sub-img2').attr('src',crapImg); break;
            			case 4 : $('#sub-img3').attr('src',crapImg); break;
            			case 5 : $('#sub-img4').attr('src',crapImg); break;
            			}
            		}
            	};
            	$(function(){
            		$('#file-area').hide();
            		$('#title-img').click(function(){
            			$('#file1').click();
            		});
            		$('#sub-img1').click(function(){
            			$('#file2').click();
            		});
            		$('#sub-img2').click(function(){
            			$('#file3').click();
            		});
            		$('#sub-img3').click(function(){
            			$('#file4').click();
            		});
            		$('#sub-img4').click(function(){
            			$('#file5').click();
            		});
            	})
            	
            </script>   
            
            
         </div>
         <hr>
         <br>
                <span class="title"> 상품명 </span> <input type="text" class="text-name" maxlength="20" placeholder="최대 20글자" name="productName" id="productName"> <br><br>
                <span class="title">상품가격</span> <input type="number" class="text-title" name="productPrice" id="productPrice"> <br><br>
                <span class="title">상품수량</span> <input type="number" class="text-title" name="productQuantity" id="productQuantity">
                <select style="width: 80px; height: 30px; font-size: 20px" name="unitName" id="unitName">
                    <option value="kg">kg</option>
                    <option value="개">개</option>
                    <option value="box">box</option>
                </select>
                <br><br>
                <span class="title">상품설명</span><br> <textarea style="width: 99%; font-size: 18px;" rows="30" name="productContent" id="productContent"></textarea> <br><br>
                <span class="title">상품 카테고리</span> 
                <select style="width: 150px; height: 40px; margin-left: 10px; font-size: 15px;" name="productType" id="productType">
                    <option value="유기농과일">유기농 과일</option>
                    <option value="유기농야채">유기농 야채</option>
                    <option value="못난이과일">못난이 과일</option>
                    <option value="못난이야채">못난이 야채</option>
                </select>
                <br><br>
                
                
                <span class="title">배송정보</span> 
                
                <input type="radio" name="delivery" id="deliver-btn1">
                <label>무료배송</label>
                
                <input type="radio" name="delivery" id="deliver-btn2">
                <label>배송비</label>
                
                <br>
                
                <div style="display: none;" id="delivery-text">
                <input type="number" class="text-title" id="deliver-no" placeholder="가격을 입력해주세요"> 
                <label>배송비 입력</label>
                </div>
                
                <input type="hidden" id="tq" value="무료">
                
        		
        <script>
        
        // 배송비 선택했을때
        $('#deliver-btn2').change(function(){
        	$('#delivery-text').show();
        	$('#deliver-no').attr('name', 'deliveryPrice');
        	$('#deliver').val('원');
        	$('#tq').removeAttr('name');
        	$('#tq').removeAttr('value');
        });
        
        
        // 무료햇을때
        $('#deliver-btn1').change(function(){
        	$('#delivery-text').hide();
        	$('#tq').attr('name', 'deliveryPrice');
        	$('#tq').val('무료');
        	$('#deliver-no').removeAttr('name');
        	$('#deliver-no').removeAttr('value');
        });
        
        </script>
                
                
                
                
                
                
                <br><br>
                <hr>
                <br>
                
                
                <div class="save-btn">
                    <button type="submit" id="confirmation">등록하기</button>
                    <button>임시저장</button>
                </div>
                <br>
            </form>
         <br><br><br>
    </div>
    </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>