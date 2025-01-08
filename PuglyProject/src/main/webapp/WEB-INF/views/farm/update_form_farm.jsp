<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Document</title>
    <style>
        #body{
            width: 1200px;
            margin: auto;
        }
        #body  div{
            border: 0.5px solid gray;
            text-align: center;
        }
        .textarea-regist{
            width: 700px;
            height: 400px;
        }
        
                input[type="file"] {
            display: none;
        }

        .image-gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
            margin-bottom: 20px;
        }

        .image-item {
            position: relative;
            width: 150px;
            height: 150px;
            overflow: hidden;
            border-radius: 10px;
            background-color: #e0e0e0;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }

        .image-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .add-image {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 150px;
            height: 150px;
            background-color: #4CAF50;
            border-radius: 10px;
            color: white;
            font-size: 40px;
            cursor: pointer;
            border: 2px dashed #bbb;
        }

        .hidden-input {
            display: none;
        }

        .message {
            text-align: center;
            font-size: 18px;
            color: #333;
        }
    </style>
</head>
<body>
    <div id="body">
    <jsp:include page="/WEB-INF/views/common/menubar.jsp" />
        <form id="form" action="update.farm" method="post" enctype="multipart/form-data">
        	<input type="hidden" value="${ farm.farmNo }" name="farmNo" />
        	<input type="hidden" value="${ farm.categoryNo }" name="categoryNo" />
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="container">
                        <div class="row">
                            <div class="col">
                                <h3>농장 등록하기</h3>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="image-gallery" id="image-gallery">
                                	<c:forEach items="${ farm.imgList }" var="img">
                                		<c:if test="${ img.status eq 'Y' }">
										<input type="text" style="display:none;" name="imgPath" class="path" value="${ img.imgPath }" />
										<input type="text" style="display:none;" name="originImgName" class="origin" value="${ img.originImgName }" >
										<input type="text" style="display:none;" name="changeImgName" class="change" value="${ img.changeImgName }" >  
										<input type="text" style="display:none;" name="changeImgName" class="imgLevel" value="${ img.imgLevel }" >  
                                		</c:if>
                                	</c:forEach>
										<input type="text" style="display:none;" name="originNames" id="originNames">                              		
                                    <div class="add-image" id="add-image">
                                        <span>+</span>
                                    </div>
                                </div>
                                    <input type="file" id="image-upload" class="hidden-input" name="files" accept="image/*" multiple>
                                    <p class="message" id="message">이미지는 최대 5장까지만 업로드할 수 있습니다.</p>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                제목 : <input name="farmTitle" type="text" value="${ farm.farmTitle }">
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div>내용</div>
                                <textarea class="textarea-regist" style="resize:none;" name="farmContent" required>${ farm.farmContent }</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div>주의사항</div>
                                <textarea class="textarea-regist" style="resize:none;" name="bewareList" required>${ farm.bewareList }</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div id="facility-box">
                                    <div>부대시설</div>
                                    <c:forEach items="${ facility }" var="f"> 
                                    <c:forEach items="${ farm.facility }" var="farmFac">
                                    <c:choose>
										<c:when test="${ f.facilityNo eq farmFac.facilityNo }">
											<label>${ f.facilityName }</label><input name="facilityNo" value="${ f.facilityNo }" type="checkbox" checked>
										</c:when>
										<c:otherwise>
                                    		<label>${ f.facilityName }</label><input name="facilityNo" value="${ f.facilityNo }" type="checkbox">
										</c:otherwise>                               
                                    </c:choose>
                                    </c:forEach>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                주소 ${ farm.addressNo }
                                <div class="container">
			                        <div class="row">
			                            <div class="col">
			                            
			                            <input type="hidden" value="${ farm.addressNo }" name="addressNo">
			                                <c:forEach items="${ state }" var="s">
			                                	<label>${ s.stateName }</label>
			                                	<c:choose>
			                                	<c:when test="${ farm.stateCode eq s.stateCode }">
			                                	<input name="stateCode" value="${ s.stateCode }" type="radio" checked>
			                                	</c:when>
			                                	<c:otherwise>
			                                	<input name="stateCode" value="${ s.stateCode }" type="radio">
			                                	</c:otherwise>
			                                	</c:choose>
			                                </c:forEach>
			                            </div>
			                        </div>
			                    </div>
                                상세 주소 : <input type="text" name="district" value="${ farm.address }">
                            </div>
                        </div>
                    </div>
                    
                    <div class="container">
                        <div class="row">
                            <div class="col-4">가격 <input type="number" name="farmPrice" value="${ farm.farmPrice }"></div>
                            <div class="col-4">
                            	품목
                            	<c:forEach items="${ product }" var="p">
                            		<c:choose>
                            		<c:when test="${ p.productName eq farm.productName }">
                            		${ p.productName }<input type="radio" name="productName" value="${ p.productNo }" checked>
                            		</c:when>
                            		<c:otherwise>
                            		${ p.productName }<input type="radio" name="productName" value="${ p.productNo }">
                            		</c:otherwise>
                            		</c:choose>
                            	</c:forEach>
                            </div>
                            <div class="col-4">
                            	<input type="hidden" name="seller" value="${ sessionScope.loginUser.memberNo }">
                            	<input type="hidden" name="memberNo" value="${ sessionScope.loginUser.memberNo }">
                            	<input type="hidden" name="addressNo" value="${ address.addressNo }">
                                <button class="btn btn-sm btn-outline-danger" type="button">취소하기</button>
                                <button class="btn btn-sm btn-outline-primary">등록하기</button></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>
    <script>
        const imageGallery = document.getElementById('image-gallery');
        const addImage = document.getElementById('add-image');
        const imageUpload = document.getElementById('image-upload');
        const message = document.getElementById('message');
        const maxImages = 5;
        
        const path = document.getElementsByClassName('path');
        const origin = document.getElementsByClassName('origin');
        const change = document.getElementsByClassName('change');
        const imgLevel = document.getElementsByClassName('imgLevel');
        
        const imgList = { 'path' : '', 'origin' : [], 'change' : [], 'imgLevel' : []};
        for(let i = 0; i < origin.length; i++){
        	imgList.origin.push(origin[i].value);
        	imgList.change.push(change[i].value);
        	imgList.imgLevel.push(imgLevel[i].value);
        }
        	imgList.path = ('/pugly/resources/farm-img/');
        	
        //console.log(imgList);
		
        let uploadedImages = [];
        
        // 기존 이미지 출력
        for(let i = 0; i < imgList.origin.length; i++){
        	const imgElement = document.createElement('img');
            imgElement.src = imgList.path+imgList.change[i];
            imgElement.alt = imgList.origin[i];
            imgElement.value = i
            console.log(imgElement);
            const imageItem = document.createElement('div');
            imageItem.classList.add('image-item');
            imageItem.appendChild(imgElement);
            
            imageItem.addEventListener('click', (e) => {
                imageItem.remove();
                console.log(e.target.src.substring(43))
                imgList.origin = imgList.origin.filter(origin => origin !== e.target.alt)
                imgList.change = imgList.change.filter(change => change !== e.target.src.split('/').pop())
                imgList.imgLevel = imgList.imgLevel.filter((imgLevel, index) => index !== e.target.value)
                console.log(imgList.change);
                uploadedImages = uploadedImages.filter(image => image !== file);
                const originNames = document.getElementById('originNames');
                originNames.value = JSON.stringify(imgList);
                updateAddImageButton();  // 삭제 후 +버튼 갱신
            });

            // 이미지를 갤러리에 추가
            imageGallery.insertBefore(imageItem, addImage);
           
        
        };
  
        
		// 이미지 업로드 트리거
		addImage.addEventListener('click', () => {
		    if (uploadedImages.length < maxImages) {
		        imageUpload.click();
		    } else {
		        alert("최대 5장까지만 업로드 가능합니다.");
		    }
		});
		
		// 파일이 선택되었을 때 처리
		imageUpload.addEventListener('change', (event) => {
		    const files = event.target.files;
		
		    if (files.length + uploadedImages.length > maxImages) {
		        alert("최대 5장까지만 업로드 가능합니다.");
		        return;
		    }
		
		    // 이미지 업로드 처리
		    for (let i = 0; i < files.length; i++) {
		        const file = files[i];
		        const reader = new FileReader();
		
		        reader.onload = function(e) {
		            const imgElement = document.createElement('img');
		            imgElement.src = e.target.result;
		            const imageItem = document.createElement('div');
		            imageItem.classList.add('image-item');
		            imageItem.appendChild(imgElement);
		
		            // 이미지 클릭 시 삭제 기능 추가
		            imageItem.addEventListener('click', () => {
					    imageItem.remove();
					    uploadedImages = uploadedImages.filter(image => image.name !== file.name);
					    updateAddImageButton();
					});
		
		            // 업로드된 이미지 배열에 추가
		            uploadedImages.push(file);
		
		            // 이미지를 갤러리에 추가
		            imageGallery.insertBefore(imageItem, addImage);
		        };
		        reader.readAsDataURL(file);
		    }
		    
		    
		    function updateAddImageButton() {
		        if (uploadedImages.length >= maxImages) {
		            addImage.style.display = 'none';
		        } else {
		            addImage.style.display = 'block';
		        }
		    }
		
		    // 이미지 업로드 후 '이미지 추가' 버튼 상태 업데이트
		    updateAddImageButton();
		});
		 const form = document.getElementById('form');
         
         form.addEventListener('submit', (event) => {
             event.preventDefault();
             const formData = new FormData(form);
         	//form.append('originNames', JSON.stringify(imgList));
             // 업로드된 파일 추가
             //uploadedImages.forEach((file, index) => {
               //  formData.append(`file_${index}`, file);
             //});

             $.ajax({
            	url : '/pugly/modify/update.farm',
            	type : 'post',
            	data : formData,
            	processData: false,
            	contentType : false,
            	success : function(r){
            		console.log(r);
            		alert('수정 성공.');
            		location.href = '/pugly/farms'
            	}
       
             })
         })
    </script>
</body>
</html>