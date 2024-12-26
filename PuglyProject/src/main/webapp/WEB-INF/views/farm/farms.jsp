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
    <title>Pugly Farm</title>
    <style>
        div{
            border: 0.5px solid gray;
            margin : auto;
            
        }
        #body{
            width: 1200px;
            height: auto;
            overflow: hidden;
        }
        
        #suchbar{
            height: 650px;
            position : fixed;
        }
        .optionbar{
            height: 120px;
        }
        .checkbox-div  input{
            display: inline-block;
            margin-left : 2.5px;
            margin-right : 2.5px;
            width: 15px;
            height: 15px;
        }
        .checkbox-div  label{
            font-size : 9px;
        }
        .checkbox-div > div{
            width: 100%;
            height: 16.25px;
        }
        .checkbox-div{
            margin-bottom: 0px;
            padding: 0;
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
        .score > div{
            height: 100%;
            width: 50%;
            float : left;
        }
        #such-detail{
            margin-left: 140px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div id="body">
        <div class="container">
            <div class="row">
                <div class="col-3 out-frame">
                            <form action="" method="get">
                                <div class="col" id="suchbar">
                                    <div class="container">
                                        <div class="row optionbar">
                                            <div class="checkbox-div">
                                            </div>
                                            <div class="checkbox-div">
                                            </div>
                                        </div>
                                        <div class="row optionbar"></div>
                                        <div class="row optionbar"></div>
                                        <div class="row optionbar"></div>
                                        <div class="row optionbar"></div>
                                    </div>
                                    <button id="such-detail">조회하기</button>
                                </div>
                            </form>
                </div>
                <div class="col-9 out-frame">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4 farms">
                                            <div class="farms-content">
                                                <div class="img"><img src="" alt=""></div>
                                                <div class="farm-explain">
                                                    <div class="title">농장제목</div>
                                                    <div class="score">
                                                        <div class="price"></div>
                                                        <div class="like-attention"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                        <div class="col-4 farms">
                                            <div class="farms-content"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<script>
	window.onload = () =>{
		
		const plusNo = document.getElementById('plusNo');
		let no = plusNo.value;
		
		const btn = document.getElementById('btn');
		
			btn.onclick = () => {
				console.log(plusNo.value)
				$.ajax({
					url : "plus",
					type : "get",
					data : {
						plusNo : plusNo.value
					},
					success : function(r){
						document.getElementById('plusNo').value = r.mi.plusNo;
						if(r.mi.lastNo === r.mi.listCount){
							btn.style.display = 'none';
						}
						//console.log(btn);
						
					}
				
				})
			}
	}
	

	</script>
	
</body>
</html>