<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <title>Pugly Farm</title>
    
 
<style>
       div{
            margin : auto;
            
        }
        #body{
            width: 1200px;
            height: 1600px;
            overflow: hidden;
        }
        #suchbar{
            position : fixed;
        }
        
        .optionbar{
            height: 120px;
        }
        
        .farms{
            height: 350px;
        }
        .farms-content{
            height: 300px;
            margin-top : 25px;
        }
        .img{
            height: 215px;
            margin-top : 11px;
        }
        .farms-content > div{
            width: 90%;
        }
        .farm-explain > div{
            height: 30px;
            text-align: center;
        }
        .price{
            height: 100%;
            width: 50%;
            float : left;
        }
        #checkbox-div{
            height: 240px;
            width: 230px;
        }
        .label-font{
        	font-size : 12px;
        }
        .box-size{
        	width : 12px;
        	height : 12px;
        }
        .cover-box{
        	display : inline-block
        }
        #btn-more-div{
        	width : 100%;
        	height : 70px
        }
        .like, .attention{
        	height : 100%;
        	width : 25%;
        	float : left;
        }
        .img > img{
        width : 100%;
        height : 100%;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/menubar.jsp" />
    <div id="body">
        <div class="container">
            <div class="row">
                <div class="col-3 out-frame">
	                <div id="suchbar">
	                	<div class="container" >
	                    	<div class="row">
	                        	<div class="col">
	                                <div class="container" >
	                                    <div class="row">
	                                        <div id="checkbox-div">
	                                            <c:forEach items="${ state }" var="state">
	                                            	<div class="cover-box">
	                                             	<label class="label-font">${ state.stateName } </label>
	                                             	<input class="box-size states" type="checkbox" name="suchState" value="${state.stateCode}">
	                                            	</div>
	                                            </c:forEach>
	                                        </div>
	                                    </div>
	                                    <div class="row">
	                                        <div class="optionbar">
	                                            <c:forEach items="${ farmProduct }" var="product">
	                                            	<div class="cover-box">
	                                            		<label class="label-font">${ product.productName }</label>
	                                            		<input type="checkbox" class="box-size product" name="suchProduct" value="${ product.productNo }" step="1000">
	                                            	</div>
	                                            </c:forEach>
	                                        </div>
	                                    </div>
	                                    <div class="row">
	                                        <div class="optionbar">
	                                          	<div>최신순<input class="option" type="radio" id="newest" name="option" value="date"></div>
	                                          	<div>평점순<input class="option" type="radio" id="rating" name="option" value="rating"></div>
	                                          	<div>가격오름차순<input class="option" type="radio" id="upPrice" name="option" value="price"></div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </div>
                <div class="col-9 out-frame">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                            <input type="hidden" id="plusNo" name="plusNo" value="${ farm.mi.plusNo }">
                                <div class="container">
                                    <div class="row" id="farm-list">
                                    <c:forEach items="${ farm.farm }" var="farm">
                                        <div class="col-4 farms" onclick="farms(${farm.farmNo})">
                                            <div class="farms-content">
                                                <div class="img">
                                                <c:forEach items="${ farm.imgList }" var="img">
	                                                <c:choose>
	        		                                    <c:when test="${ img.status eq 'Y' && img.imgLevel eq 1}">
	                		                                <img src="/pugly/${img.imgPath }${ img.changeImgName }" alt="${img.originImgName }">
			                                            </c:when>
			                                            <c:when test="${ img.status eq 'N' }">
			                                            </c:when>
			                                            <c:otherwise>
			                                            	<img src="" alt="이미지 없음">
			                                            </c:otherwise>
	                                                </c:choose>
                                                </c:forEach>
                                                </div>
                                                <div class="farm-explain">
                                                    <div class="title">${ farm.farmTitle }</div>
                                                    <div class="score">
                                                    <c:choose>
                                                    <c:when test="${ farm.farmPrice eq 0 }">
                                                    	<div class="price">무료 체험</div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="price">${ farm.farmPrice }</div>
                                                    </c:otherwise>
                                                    </c:choose>
                                                        <div class="like">${ farm.rating }</div>
                                                        <div class="attention"> ${ farm.like }</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<div id="btn-more-div">
        	<button class="more-btn btn btn-sm btn-info" onclick="suchFarms()">더보기</button>
        	<input type="hidden" id="user-category" value="${ sessionScope.loginUser.categoryNo }">
        	<c:if test="${ seessionScope.loginUser.memberNo eq farm.memberNo }">
        	<button class="btn btn-sm" id="regist-farm">체험 등록하기</button>
        	</c:if>
        	<c:if test="${ seessionScope.loginUser.memberNo ne farm.memberNo }">
       		<button class="btn btn-sm" id="regist-farm" style="display:none;">체험 등록하기</button>
        	</c:if>
		</div>   
    </div>
    
    <script>
    	const registFarm = document.getElementById('regist-farm');
    	const category = document.getElementById('user-category');
    	if( category.value === '2'){
    		registFarm.style.display = 'inline-block';
    	}
    	registFarm.onclick = () => {
    		location.href = "/pugly/farm/regist";
    	}
    </script>
    
	<script>
		let such = {
				'state' : [],
				'product' : [],
				'option' : '',
				'plusNo' : 6
		}
		const state = document.getElementsByClassName('states');
		for(let i of state){
			i.addEventListener('click', function(){
				if(i.checked){
					such.state.push(i.value)
				} else {
					such.state = such.state.filter(value => value !== this.value);
				}
			})
		}
		
		const product = document.getElementsByClassName('product');
		for(let i of product){
			i.addEventListener('click', function(){
				if(i.checked){
					such.product.push(i.value)
				} else {
					such.product = such.product.filter(value => value !== this.value);
				}
				console.log(such.product)
			})
		}
		
		const option = document.getElementsByClassName('option');
		for(let i of option){
			i.addEventListener('click', function(){
				such.option = i.value;
				console.log(such.option)
			})
		}
		
		let jsonData = JSON.stringify(such);
		
		function suchFarms() {
			$.ajax({
				url : 'plus',
				type : 'post',
				contentType : 'application/json',
				data : jsonData,
				success : function(r){
				such.plusNo += r.plusNo
				jsonData = JSON.stringify(such)
				const relipes = [...r.farm];
				const img = relipes.map(e => {
					`<div class="col-4 farms" onclick="farms(\${e.farmNo})">
                    	<div class="farms-content">	
                    		<div class="img">`
								if(e.imgList && e.status === 'Y'){
									`<img src="/pugly/\${e.imgPath }\${ e.changeImgName }" alt="\${e.originImgName }">`
								} else{
									`<img src="" alt="이미지 없음">`
								}
                    		`</div>
			                    <div class="farm-explain">
			                    <div class="title">\${ e.farmTitle }</div>
			                    <div class="score">`
			                    	if(e.farmPrice === 0){
			                    		`<div class="price">무료 체험</div>`
			                    	} else {
				                        `<div class="price">\${ e.farmPrice }</div>`
			                    	}
			                        `<div class="like">\${ e.rating }</div>
			                        <div class="attention">\${ e.like }</div>
			                    </div>
			                </div>
			            </div>
			        </div>`
					
				}).join();
				console.log(img);
				}
			})
		}
		
	</script>
	
	<script>
		function farms(num){
			location.href = `/pugly/farms/\${num}`
		}
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>