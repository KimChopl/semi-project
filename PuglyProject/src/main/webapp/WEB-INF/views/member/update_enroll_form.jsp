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
            /*border: 1px solid red;*/
            box-sizing: border-box;
        }
        
        #wrap{
            margin: auto;
            width: 400px;
            height: 460px;
            text-align: center;
            border-radius: 20px;
            background-color: rgb(245, 245, 245);
        }


        #file{
            position: relative;
            left: 100px;
            bottom: 80px;
        }

        .input{
            width: 250px;
            height: 40px;
            margin: 5px;
            border-radius: 5px;
            text-align: center;
            font-family: 'SUITE-Regular';
        }
        select{
            width: 100px;
            height: 25px;
            font-family: 'SUITE-Regular';
        }

        

        #update-member{
            background-color: rgb(68, 68, 255);
            border: 1px solid rgb(68, 68, 255);
            color: white;
        }

        #update-member:hover{
            background-color: rgb(30, 30, 253);
            border:2px double rgb(68, 68, 255)
        }
	
		@font-face {
            font-family: 'SUITE-Regular';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
            font-weight: 400;
            font-style: normal;
        }
        
        

    </style>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />

    <div id="wrap">
        <form action="update.memberInfo" method="post" enctype="multipart/form-data">
        	
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" id="customFile" name="upfile">
		    <label class="custom-file-label" for="customFile">Choose file</label>
		  </div>

			<br>
			<br>
			<script>
			// Add the following code if you want the name of the file appear on select
			$(".custom-file-input").on("change", function() {
			  var fileName = $(this).val().split("\\").pop();
			  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
			});
			</script>
            <input type="hidden" value="${ sessionScope.loginUser.memberNo }" name="memberNo" class="input"/>
            
            <input type="text" value="${ sessionScope.loginUser.nickname }" name="nickname" class="input"/>
           	<input type="text" placeholder="새로운 이름을 입력해주세요" value="${ sessionScope.loginUser.memberName }" name="memberName" class="input" />
            <input type="password" placeholder="변경 전 비밀번호를 입력해주세요" name="password" required class="input"/>
            <br>
            <input type="password" placeholder="새 비밀번호" name="memberPwd" required class="input"/>
            <br>
            <input type="text" value="${ sessionScope.loginUser.phone }" name="phone" class="input"/>
            <br>
            <br>
            <button class="btn btn-primary btn-block">수정하기</button>
        </form>
        <br>
        
    
    <!-- Button to Open the Modal -->
	<button type="button" class="btn btn-danger btn-block" data-toggle="modal" data-target="#myModal">
        회원탈퇴
	</button>
	
	<!-- The Modal -->
	<div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">회원탈퇴</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- Modal body -->
                    <form action="delete.member" method="post">
		                <div class="modal-body">
		                <input type="hidden" name="memberNo" value="${ sessionScope.loginUser.memberNo }">
		                        비밀번호 <br> <input type="text" name="memberPwd" id="member-pwd" /><br>
		                        비밀번호 확인 <br> <input type="password" id="check-pwd" /><br>
		                        탈퇴확인을 위하여 텍스트를 작성해주세요 <br> 
		                        <input type="text" placeholder="탈퇴하겠습니다 라고 작성해주세요." id="check-delete"/>
		                    </div>
		                    
		                    <!-- Modal footer -->
		                    <div class="modal-footer">
		                        <button type="submit" class="btn btn-success" onclick="return validate();">회원탈퇴</button>
		                </div>
                    </form>
                <script>
                function validate() {
                	if($('#member-pwd').val() != $('#check-pwd').val() || $('#check-delete').val() != "탈퇴하겠습니다"){
                		$('#member-pwd').val('');
                		$('#check-pwd').val('');
                		$('#check-delete').val('');
                		return false;
                	}
                	return true;
				}
                			
                
                
                </script>
                
            </div>
        </div>
	</div>
</div>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>