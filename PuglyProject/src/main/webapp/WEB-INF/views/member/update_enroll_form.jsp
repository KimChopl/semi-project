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
            height: 415px;
            text-align: center;
            border-radius: 20px;
            background-color: rgb(245, 245, 245);
        }

        #image{
            border-radius: 100px;
            width: 100px;
            height: 100px;
            margin-left: 15px;
            margin-top: 15px;
            border: 1px solid black;
            background-color: white;
        }

        #file{
            position: relative;
            left: 100px;
            bottom: 80px;
        }

        input{
            width: 250px;
            height: 30px;
            margin: 10px;
            border-radius: 5px;
            text-align: center;
        }
        select{
            width: 100px;
            height: 25px;
        }

        button{
            width: 150px;
            height: 30px;
            margin-top: 5px;
            border-radius: 5px;
            
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

        
        

    </style>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

	<jsp:include page="../common/menubar.jsp" />

    <div id="wrap">
        <div id="image"></div>
        <form action="update.memberInfo" method="post">
            <input type="hidden" value="${ sessionScope.loginUser.memberNo }" name="memberNo"/>
            <input type="file" id="file" name="img"/>
            <input type="text" value="${ sessionScope.loginUser.nickName }" name="nickName"/>
           	<input type="text" placeholder="새로운 이름을 입력해주세요" value="${ sessionScope.loginUser.memberName }" name="memberName" />
            <input type="password" placeholder="변경 전 비밀번호를 입력해주세요" name="password" required />
            <br>
            <input type="password" placeholder="새 비밀번호" name="memberPwd" required />
            <br>
            <input type="text" value="${ sessionScope.loginUser.phone }" name="phone"/>
            <br>
            <br>
            <button id="update-member">수정하기</button>
        </form>
        <br>
        
    
    <!-- Button to Open the Modal -->
	<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">
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
                	if($('#member-pwd').val() != $('#check-pwd').val() && $('#check-delete').val() != "탈퇴하겠습니다"){
                		$('#member-pwd').focus().val('');
                		$('#check-pwd').focus().val('');
                		$('#check-delete').focus().val('');
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
	<!--  
	-->



</body>
</html>