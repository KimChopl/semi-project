<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
    	div{
            box-sizing: border-box;
            /*border:1px solid red;*/
    	}
    
        #wrap{
            margin: auto;
            width: 450px;
            height: 600px;
            background-color: rgb(243, 243, 243);
            border-radius: 5px;
            text-align: center;
           	margin-top:10px;
        }

        input{
            width: 280px;
            height: 35px;
            border-radius: 5px;
            border: 1px solid;
            padding: 10px;
        }

        .div{
            width: 400px;
            height: 50px;
            padding: auto;
            margin: auto;
            margin-top:10px;
        }

        select{
            width: 110px;
            height: 30px;
            margin-left: 10px;
        }

        button{
            width: 100px;
            height: 30px;
            color: white;
            border-radius: 3px;
            background-color: rgb(0, 141, 7);
            border: none;
        }

        button:hover{
            background-color: green;
            border: 3px double rgb(0, 141, 7);
        }
        
        .p{
        	color: green;
        	font-size: 14px;
        	font-weight: bolder;
        	margin-top:0;
        	padding-top:0;
        }

		.file{
			border:none;
		}
    </style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    
    <jsp:include page="../common/menubar.jsp" />
    
    <div id="wrap">
        <form action="insert.member" method="post">
            <div class="div">
                <input type="text" placeholder="이름" name="memberName" required/>
            </div>
           
            <div class="div">
                <input type="text" placeholder="아이디" name="memberId" required/>
            </div>
            
            <div class="div">
                <input type="password" placeholder="비밀번호" name="memberPwd" required/>
            </div>
                
			<div class="custom-file">
			  <input type="file" class="custom-file-input" id="customFile">
			  <label class="custom-file-label" for="customFile">Choose file</label>
			</div>
		
			<script>
				// Add the following code if you want the name of the file appear on select
				$(".custom-file-input").on("change", function() {
				  var fileName = $(this).val().split("\\").pop();
				  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
				});
			</script>
            
            <div class="div">
                <input type="text" placeholder="닉네임" name="nickName" />
            </div>
            	<p class="p">
            		※닉네임을 작성하지 않을 시 아이디가 닉네임으로 지정됩니다.
            	</p>
            <div class="div">
                <input type="text" placeholder="전화번호(-포함)" required name="phone"/>
            </div>
                <input type="hidden" name="addressType" value="1"/>
            <div class="div">
                <select name="stateCode">
                <c:forEach var="s" items="${ stateCategory }">
                    <option value="${ s.stateCode }">${ s.stateName }</option>
                </c:forEach>
                </select>
                <input type="text" placeholder="상세주소" required name="district" />
            </div>
            <div class="div">
                <button>회원가입</button>
                <select name="categoryNo">
                    <option value="3">일반</option>
                    <option value="2">판매자</option>
                    <option value="1">관리자</option>
                </select>
        	</div>
            </form>
    </div>

	<jsp:include page="../common/footer.jsp" />


    
</body>
</html>
