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
                    <td>${inquiry.nickname}</td>
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
            	 <c:if test="${sessionScope.loginUser.nickname eq inquiry.nickname or sessionScope.loginUser.categoryNo eq 1}">
	                <a class="btn btn-danger"  onclick="postSubmit()">삭제하기</a>
            	</c:if>
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
            
            <br><br>

            <table id="replyArea" class="table" >
                <thead>
                	
                	<c:choose>
					    <c:when test="${inquiry.inquiryGroup eq 2}">
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
					                        <textarea class="form-control" name="content" id="content" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
					                    </th>
					                    <th style="vertical-align:middle"><button class="btn btn-secondary" onclick="addReply();">등록하기</button></th> 
					                </tr>
					            </c:otherwise>
					        </c:choose>
					    </c:when>
					
					    <c:otherwise>
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
					                <c:choose>
					                    <c:when test="${sessionScope.loginUser.nickname eq inquiry.nickname or sessionScope.loginUser.categoryNo eq 1}">
					                        <tr>
					                            <th colspan="2">
					                                <textarea class="form-control" name="content" id="content" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
					                            </th>
					                            <th style="vertical-align:middle"><button class="btn btn-secondary" onclick="addReply();">등록하기</button></th> 
					                        </tr>
					                    </c:when>
					                    <c:otherwise>    
					                        <tr>
					                            <th colspan="2">
					                                <textarea class="form-control" readonly cols="55" rows="2" style="resize:none; width:100%;">작성자와 관리자만 입력가능합니다.</textarea>
					                            </th>
					                            <th style="vertical-align:middle"><button class="btn btn-secondary">등록하기</button></th> 
					                        </tr>
					                    </c:otherwise>
					                </c:choose>
					            </c:otherwise>
					        </c:choose>
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
    			url : '/pugly/inquiryAnswer',
    			type : 'get',
    			data : {
    				inquiryNo : ${inquiry.inquiryNo}
    			},
    			success : function(result){
    				const replies =[...result.data];
    				console.log(replies);
    				
    				const resultStr = replies.map(e =>
								    					`<tr>
								    					<td>\${e.nickname}</td>
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