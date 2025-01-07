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

        #boardList {text-align:center;}
        #boardList>tbody>tr:hover {cursor:pointer;}

        #pagingArea {width:fit-content; margin:auto;}
        
        #searchForm {
            width:80%;
            margin:auto;
        }
        #searchForm>* {
            float:left;
            margin:5px;
        }
        .select {width:20%;}
        .text {width:53%;}
        .searchBtn {width:20%;}
        
        
    </style>
</head>
<body>
    
    <jsp:include page="../common/menubar.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h2>문의게시판</h2>
            <br>
            <c:if test="${not empty sessionScope.loginUser }">
            	<a class="btn btn-secondary" style="float:right;" href="insertInquiryForm">글쓰기</a>
            </c:if>
            <br>
            <br>
            <table id="inquiryList" class="table table-hover" style="text-align: center">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                        <th>답변상태</th>
                    </tr>
                </thead>
                <tbody id="inquiryListBody" >
                
                	<c:forEach items="${inquiries}" var="inquiry">
	                    <tr onclick="detail('${inquiry.inquiryNo}')"
	                    	style="<c:if test='${inquiry.inquiryGroup eq 2}'>background-color: lightgray;</c:if>"
	                    >
	                        <td>${inquiry.inquiryNo}</td>
	                        <c:choose>
		                        <c:when test="${inquiry.inquiryGroup eq 2}">
		                        	<td>${inquiry.inquiryTitle}</td>
		                        </c:when>
		                        <c:otherwise>
		                        	<td>🔒고객 문의</td>
		                        </c:otherwise>
	                        </c:choose>
	                        <td>${inquiry.nickname }</td>
	                        <td>${inquiry.count }</td>
	                        <td>${inquiry.createDate}</td>
	                        <td> 
	                        	<c:if test="${inquiry.answerStatus eq 'Y'}"> 
	                        		✔️
	                        	</c:if>	
	                        </td>
	                    </tr>
                    </c:forEach>
                    
                </tbody>
            </table>
            <br>
            
            <script>
            	function detail(num) {
            		location.href=`inquiries/\${num}`;
            	}	
            
            </script>
            

            <div id="pagingArea">
                <ul class="pagination">
                <c:choose>
                    <c:when test="${pageInfo.currentPage ne 1 }">
                    	<li class="page-item"><a class="page-link" href="inquiries?page=${pageInfo.currentPage}">이전</a></li>
                   </c:when>
                   <c:otherwise>
                   		<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
                   </c:otherwise>
                </c:choose>
                   
                   <c:forEach begin="${ pageInfo.startPage }" end="${pageInfo.endPage }" var="num"> 
                    
                    	<li class="page-item">
                    		<a class="page-link" href="inquiries?page=${num}">${num}</a>
                    	</li>
                    </c:forEach>
                    
                    <li class="page-item"><a class="page-link" href="#">다음</a></li>
                </ul>
            </div>

            <br clear="both"><br>

             <form id="searchForm" action="" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="condition" id="condition">
                        <option value="writer">작성자</option>
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword">
                </div>
                <button type="button" class="searchBtn btn btn-secondary" onclick="searchBoard()">검색</button>
            </form>
            <br><br>
        </div>
        <br><br>

    </div>
    
    <script>
	    function searchBoard(){
            const condition = $('option:selected').val();
            const keyword = $('input[name="keyword"]').val();
            const page = 1;
	        
	        if (!keyword) {
	            alert('검색어를 입력해주세요.');
	            return;
	        }
	        $.ajax({
	            url: '/pugly/inquiries/search',
	            type: 'get',
	            data: {
	                condition: condition,
	                keyword: keyword,
	                page: page
	            },
	            success: function(searchResult) {
	            	const boardList = searchResult.inquiryList;
	            	
	            	updateInquiryList(inquiryList);
	            }
	           
	        });
	    }
	    
	    function updateInquiryList(inquiryList) {
	        const inquiryListBody = $('#inquiryListBody');
	        inquiryListBody.empty();
	        
	        const resultStr = inquiryList.map(e =>
	        `<tr onclick="detail('\${e.inquiryNo}')">
	            <td>\${e.inquiryNo}</td>
	            <td>\${e.inquiryTitle}</td>
	            <td>\${e.nickname}</td>
	            <td>\${e.count}</td>
	            <td>\${e.createDate}</td>
	        </tr>`
		    ).join('');
	        
	        inquiryListBody.html(resultStr);
	    }

    </script>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>