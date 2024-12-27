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
            border: 0.5px solid gray;
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
    </style>
</head>
<body>
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
	                                             	<input class="box-size" type="checkbox" name="suchState" value="${ state.stateCode }">
	                                            	</div>
	                                            </c:forEach>
	                                        </div>
	                                    </div>
	                                    <div class="row">
	                                        <div class="optionbar">
	                                            <c:forEach items="${ farmProduct }" var="product">
	                                            	<div class="cover-box">
	                                            		<label class="label-font">${ product.productName }</label>
	                                            		<input type="checkbox" class="box-size" name="suchProduct" value="${ product.productNo }" step="1000">
	                                            	</div>
	                                            </c:forEach>
	                                        </div>
	                                    </div>
	                                    <div class="row">
	                                        <div class="optionbar">
	                                          	<div>최신순<input type="radio" id="newest" name="option" value="newest"></div>
	                                          	<div>평점순<input type="radio" id="rating" name="option" value="rating"></div>
	                                          	<div>가격오름차순<input type="radio" id="upprice" name="option" value="upprice"></div>
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
                                        <div class="col-4 farms">
                                            <div class="farms-content">
                                                <div class="img"><img src="" alt=""></div>
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
                                                        <div class="like">${ farm.attention }</div>
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
        	<button id="btn">더보기</button>
		</div>   
    </div>
    
	<script>
	window.onload = () =>{
		
		const plusNo = document.getElementById('plusNo');
		let no = plusNo.value;
		
		const btn = document.getElementById('btn');
		
			btn.onclick = () => {
				//console.log(plusNo.value)
				$.ajax({
					url : "plus",
					type : "get",
					data : {
						plusNo : plusNo.value
					},
					success : function(r){
						document.getElementById('plusNo').value = r.mi.plusNo;
						const replies = [...r.farm]
						const result = replies.map(e =>
							`<div class="col-4 farms">
                                            <div class="farms-content">
                                                <div class="img"><img src="" alt=""></div>
                                                <div class="farm-explain">
                                                    <div class="title">\${ e.farmTitle }</div>
                                                    <div class="score">
                                                        <div class="price">\${ e.farmPrice }</div>
                                                        <div class="like-attention">\${ e.attention } \${ e.like }</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>`		
						).join('');
						//console.log(result);
						document.getElementById('farm-list').innerHTML += result;
						document.getElementById('body').style.height = 'auto';
						if(r.mi.lastNo === r.mi.listCount){
							btn.style.display = 'none';
						}
						//console.log(btn);
						
					}
				
				})
			}
			const state = document.getElementsByName('suchState');
			state.addEventListener('click', function(){
				console.log(state.value);
			})
	}
	

	</script>
	
</body>
</html>