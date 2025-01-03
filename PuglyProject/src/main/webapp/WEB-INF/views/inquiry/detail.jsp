<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style> 
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        table * {margin:5px;}
        table {width:100%;}
    </style>
</head>
<body>
        
    <jsp:include page="../common/menubar.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>게시글 상세보기</h2>
            <br>

            <a class="btn btn-secondary" style="float:right;" href="/pugly/inquiries">목록으로</a>
            <br><br>

            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${inquiry.inquiryTitle}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${inquiry.nickName}</td>
                    <th>작성일</th>
                    <td>${inquiry.createDate}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4"><p style="height:150px;">${inquiry.inquiryContent}</p></td>
                </tr>
            </table>
            <br>

            <div align="center">
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
                
	                <a class="btn btn-danger"  onclick="postSubmit()">삭제하기</a>
            	
            </div>
            
            <script>
            	function postSubmit(){
					
            		$('#postForm').attr('action', '/pugly/inquiris/delete').submit();
            	}
            </script>
            
            <form action="" method="post" id="postForm">
            	<input type="hidden" name="boardNo" value="${inquiry.inquiryNo}" />
            	<!-- <input type="hidden" name="memberNo" value="${loginUser.memberNo}" /> -->
            </form>
            
            <!-- 
            	case 1 : 수정하기 누르면
            		     수정할 수 있는 입력 양식이 있어야함
            		     입력양식에는 원본 게시글 정보들이 들어 있어야함
            		     
            	case 2 : 삭제하기 누르면
            		 	 Board테이블에 가서 STATUS 컬럼 'N'으로 바꾸고
            		 	 혹시 첨부파일도 있었다면 같이 지워줌
            
            -->
            
            
            <br><br>

            <!-- 댓글 기능은 나중에 ajax 배우고 나서 구현할 예정! 우선은 화면구현만 해놓음 -->
            <table id="replyArea" class="table" align="center">
                <thead>
                
                	<c:choose>
                		<c:when test="${empty sessionScope.loginUser}">
		                    <tr>
		                        <th colspan="2">
		                            <textarea class="form-control" readonly cols="55" rows="2" style="resize:none; width:100%;">로그인 후 이용가능합니다.</textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn btn-secondary">등록하기</button></th> 
		                    </tr>
		                </c:when>
		                <c:otherwise>    
		                    <tr>
		                        <th colspan="2">
		                            <textarea class="form-control" name="" id="content" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn btn-secondary" onclick="addReply();">등록하기</button></th> 
		                    </tr>
		           		</c:otherwise>
                   </c:choose> 
                    <tr>
                        <td colspan="3">댓글(<span id="rcount">0</span>)</td>
                    </tr>
                </thead>
                <tbody>
                	
                </tbody>
            </table>
        </div>
        <br><br>

    </div>
    
    <script>
    	
    	function addReply(){
    		
    		if($('#content').val().trim() != ''){
				
    			$.ajax({
    				url : '/pugly/inquiryAnswer',
    				type : 'post',
    				data : {
    					refIno : ${inquiry.inquiryNo},
    					inquiryAnswer : $('#content').val(),
    					nickName : '${sessionScope.loginUser.nickName}'
    				},
    				success : function(result){
    					
    					//console.log(result);
    					
    					if(result.data === 1) {
    						$('#content').val('');
    					}
    					selectReply();
    				}
    			});
    		}
    	}
    	
    	$(function(){
    		selectReply();
    	})
    	
    	function selectReply(){
    		$.ajax({
    			url : '/pugly/inquiryAnswer',
    			type : 'get',
    			data : {
    				inquiryNo : ${inquiry.inquiryNo}
    			},
    			success : function(result){
    				//console.log(result);
    				
    				const replies =[...result.data];
    				console.log(replies);
    				
    				const resultStr = replies.map(e =>
								    					`<tr>
								    					<td>\${e.nickName}</td>
								    					<td>\${e.inquiryAnswer}</td>
								    					<td>\${e.createDate}</td>
								    					</tr>`
				    								).join('');
    			$('#replyArea tbody').html(resultStr);
    			$('#rcount').text(result.data.length);
    			}
    		});
    	}
    
    </script>
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>