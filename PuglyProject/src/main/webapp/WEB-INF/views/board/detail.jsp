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

            <a class="btn btn-secondary" style="float:right;" href="/pugly/boards">목록으로</a>
            <br><br>

            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${board.boardTitle}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${board.nickname}</td>
                    <th>작성일</th>
                    <td>${board.createDate}</td>
                </tr>
                <tr>
				    <th>내용</th>
				    <td colspan="3"></td>
				</tr>
				<tr>
				    <td colspan="4">
				        <p style="height:auto; line-height: 1.6;">
				            <c:choose>
				                <c:when test="${not empty board.image}">
				                    <br/>
				                    <div style="text-align: center; margin-bottom: 20px;">
				                        <img src="/pugly/${board.image.changeImgName}" alt="${board.image.originImgName}" style="max-width: 100%; max-height: 300px;" />
				                    </div>
				                </c:when>
				            </c:choose>
				            ${board.boardContent}
				        </p>
				    </td>
				</tr>
            </table>
            <br>

            <div align="center">
                <c:if test="${sessionScope.loginUser.nickname eq board.nickname or sessionScope.loginUser.categoryNo eq 1 and not empty sessionScope.loginUser}">
	                <a class="btn btn-primary" onclick="postSubmit(1)">수정하기</a>
	                <a class="btn btn-danger"  onclick="postSubmit(2)">삭제하기</a>
            	</c:if>
            </div>
            
            <script>
            	function postSubmit(num){
					
            		if(num == 1){
            			$('#postForm').attr('action', '/pugly/boards/update-form').submit();
            		} else {
            			$('#postForm').attr('action', '/pugly/boards/delete').submit();
            		}
            	}
            </script>
            
            <form action="" method="post" id="postForm">
            	<input type="hidden" name="boardNo" value="${board.boardNo}" />
				<input type="hidden" name="changeImgName" value="${board.image.changeImgName}" />            	
            </form>
            
            <br><br>

            <table id="replyArea" class="table" align="center">
                <thead>
                
                	<c:choose>
                		<c:when test="${empty sessionScope.loginUser }">
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
    				url : '/pugly/reply',
    				type : 'post',
    				data : {
    					refBno : ${board.boardNo},
    					replyContent : $('#content').val(),
    					nickname : '${sessionScope.loginUser.nickname}'
    				},
    				success : function(result){
    					
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
    			url : '/pugly/reply',
    			type : 'get',
    			data : {
    				boardNo : ${board.boardNo}
    			},
    			success : function(result){
    				const replies =[...result.data];
    				console.log(replies);
    				
    				const resultStr = replies.map(e =>
								    					`<tr>
								    					<td>\${e.nickname}</td>
								    					<td>\${e.replyContent}</td>
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