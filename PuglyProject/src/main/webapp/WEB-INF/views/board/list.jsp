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
            <h2>게시판</h2>
            <br>
            <!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
            	<a class="btn btn-secondary" style="float:right;" href="insertForm">글쓰기</a>
            <br>
            <br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                        <th>첨부파일</th>
                    </tr>
                </thead>
                <tbody id="boardListBody">
                	<c:forEach items="${boards}" var="board">
	                    <tr onclick="detail('${board.boardNo}')">
	                        <td>${board.boardNo}</td>
	                        <td>${board.boardTitle }</td>
	                        <td>${board.nickName }</td>
	                        <td>${board.count }</td>
	                        <td>${board.createDate}</td>
	                    </tr>
                    </c:forEach>
                    
                </tbody>
            </table>
            <br>
            <script>
            	function detail(num) {
            		location.href=`boards/\${num}`;
            	}	
            
            </script>
            

            <div id="pagingArea">
                <ul class="pagination">
                <c:choose>
                    <c:when test="${pageInfo.currentPage ne 1 }">
                    	<li class="page-item"><a class="page-link" href="boards?page=${pageInfo.currentPage - 1}">이전</a></li>
                   </c:when>
                   <c:otherwise>
                   		<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
                   </c:otherwise>
                </c:choose>
                   
                <c:forEach begin="${ pageInfo.startPage }" end="${pageInfo.endPage }" var="num"> 
                 	<li class="page-item">
                 		<a class="page-link" href="boards?page=${num}">${num}</a>
                 	</li>
                </c:forEach>
                
                <c:choose>
                	<c:when test="${pageInfo.currentPage eq pageInfo.endPage}">    
                    	<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
                    </c:when>
                	<c:otherwise>
                		<li class="page-item"><a class="page-link" href="boards?page=${pageInfo.currentPage +1}">다음</a></li>
                	</c:otherwise>
               	</c:choose>
        
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
	            url: '/pugly/boards/search',
	            type: 'get',
	            data: {
	                condition: condition,
	                keyword: keyword,
	                page: page
	            },
	            success: function(searchResult) {
	            	
	            	const boardList = searchResult.boardList;
	            	const pageInfo = searchResult.pageInfo;
	            	
	            	updateBoardList(boardList, pageInfo, condition, keyword);
	            }
	           
	        });
	    }
	    
	    function updateBoardList(boardList, pageInfo, condition, keyword) {
	        const boardListBody = $('#boardListBody');
	        boardListBody.empty();
	        
	        const resultStr = boardList.map(e =>
	        `<tr onclick="detail('\${e.boardNo}')">
	            <td>\${e.boardNo}</td>
	            <td>\${e.boardTitle}</td>
	            <td>\${e.nickName}</td>
	            <td>\${e.count}</td>
	            <td>\${e.createDate}</td>
	        </tr>`
		    ).join('');
		    boardListBody.html(resultStr);
		    updatePageInfo(pageInfo, condition, keyword);
	    }
	    
	    function updatePageInfo(pageInfo, condition, keyword) {
	    	const pagingArea = $('#pagingArea');
	        
	        let pagingStr = 
	        `<ul class="pagination">`;

	        if (pageInfo.currentPage > 1) {
	            pagingStr += `<li class="page-item"><a class="page-link" href="boards?page=\${pageInfo.currentPage - 1}&condition=\${condition}&keyword=\${keyword}">이전</a></li>`;
	        } else {
	            pagingStr += `<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>`;
	        }
	        
	        for (let i = pageInfo.startPage; i <= pageInfo.endPage; i++) {
	            pagingStr += `<li class="page-item \${i === pageInfo.currentPage ? 'active' : ''}">
	                            <a class="page-link" href="boards?page=\${i}&condition=\${condition}&keyword=\${keyword}">\${i}</a>
	                          </li>`;
	        }

	        if (pageInfo.currentPage < pageInfo.totalPages) {
	            pagingStr += `<li class="page-item"><a class="page-link" href="boards?page=\${pageInfo.currentPage + 1}&condition=\${condition}&keyword=\${keyword}">다음</a></li>`;
	        } else {
	            pagingStr += `<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>`;
	        }

	        pagingStr += `</ul>`;
	        
	        pagingArea.html(pagingStr);
	    	
	    }
	    
	    
    </script>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>