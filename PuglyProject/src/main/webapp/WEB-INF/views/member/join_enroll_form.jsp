<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
    	div{
            box-sizing: border-box;
            /*border:1px solid red;*/
    	}
    
        #wrap{
            margin: auto;
            width: 500px;
            height: 500px;
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
            font-family: 'SUITE-Regular';
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
            font-family: 'SUITE-Regular';
        }

        button{
            width: 100px;
            height: 30px;
            color: white;
            border-radius: 3px;
            background-color: rgb(0, 141, 7);
            border: none;
            font-family: 'SUITE-Regular';
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
        	font-family: 'SUITE-Regular';
        }

		.file{
			border:none;
		}
		
		@font-face {
            font-family: 'SUITE-Regular';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
            font-weight: 400;
            font-style: normal;
        }
    </style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    
    <jsp:include page="../common/menubar.jsp" />
    
   <form action="insert.member" method="post" enctype="multipart/form-data">
    <div id="wrap">
		<div class="custom-file">
			  <input type="file" class="custom-file-input" id="customFile" name="upfile">
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
                <input type="text" placeholder="이름" name="memberName" required/>
            </div>
           
            <div class="div">
                <input type="text" placeholder="아이디" name="memberId" required/>
            </div>
            <div class="div">
                <input type="password" placeholder="비밀번호" name="memberPwd" required/>
            </div>
            <div class="div">
                <input type="text" placeholder="닉네임" name="nickname" />
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
                <c:forEach var="mc" items="${ memberCategory }">
                <c:if test="${ mc.categoryName ne '정지' }">
                    <option value="${ mc.categoryNo }"<c:if test="${ mc.categoryName eq '관리자' }"> disabled=disabled </c:if>>${ mc.categoryName }</option>
                </c:if>
                </c:forEach>
                </select>
    		</div>
        </div>
      </form>

	<jsp:include page="../common/footer.jsp" />


    
</body>
</html>
