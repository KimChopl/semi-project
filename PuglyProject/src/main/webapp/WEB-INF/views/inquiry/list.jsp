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
	                    <tr onclick="detail('${inquiry.inquiryNo}', '${inquiry.inquiryGroup}')"
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
            
            <div class="modal" id="passwordModal">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <!-- 모달 헤더 -->
			            <div class="modal-header">
			                <h4 class="modal-title">비밀번호 확인</h4>
			                <button type="button" class="close" data-dismiss="modal">&times;</button>
			            </div>
			
			            <!-- 모달 본문 -->
			            <div class="modal-body">
			                <input type="password" id="inputPassword" class="form-control" placeholder="비밀번호를 입력하세요">
			            </div>
			
			            <!-- 모달 푸터 -->
			            <div class="modal-footer">
			                <button type="button" class="btn btn-primary" id="passwordSubmitBtn">확인</button>
			                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			            </div>
			        </div>
			    </div>
			</div>
            
            <script>
            let selectedInquiryNo = null; 
			let selectedInquiryGroup= null;
			const loginUserCategoryNo = '${sessionScope.loginUser.categoryNo}';
            
            function detail(inquiryNo, inquiryGroup) {
                selectedInquiryNo = inquiryNo;
                selectedInquiryGroup = inquiryGroup;
                if (selectedInquiryGroup === "2" || loginUserCategoryNo === "1") {
                    location.href = `inquiries/\${inquiryNo}`;
                } else {
                    $('#passwordModal').modal('show');
                    console.log(selectedInquiryGroup);
                }
            }

            $('#passwordSubmitBtn').click(function () {
                const inputPassword = $('#inputPassword').val();

                if (!inputPassword) {
                    alert('비밀번호를 입력해주세요.');
                    return;
                }

                $.ajax({
                    url: '/pugly/inquiries/checkPassword',
                    type: 'POST',
                    data: {
                        inquiryNo: selectedInquiryNo,
                        password: inputPassword
                    },
                    success: function (response) {
                        if (response.valid) {
                            location.href = `inquiries/\${selectedInquiryNo}`;
                        } else {
                            alert('비밀번호가 올바르지 않습니다.');
                            $('#inputPassword').val('');
                        }
                    }
                });
            });
            
            $('#passwordModal').on('hidden.bs.modal', function () {
                $('#inputPassword').val('');
            });
            
            </script>
            

            <div id="pagingArea">
                <ul class="pagination">
                <c:choose>
                    <c:when test="${pageInfo.currentPage ne 1 }">
                    	<li class="page-item"><a class="page-link" href="inquiries?page=${pageInfo.currentPage - 1}">이전</a></li>
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
                <c:choose>
                	<c:when test="${pageInfo.currentPage eq pageInfo.endPage}">    
                    	<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
                    </c:when>
                	<c:otherwise>
                		<li class="page-item"><a class="page-link" href="inquiries?page=${pageInfo.currentPage +1}">다음</a></li>
                	</c:otherwise>
               	</c:choose>
                </ul>
            </div>

            <br clear="both"><br>

             <form id="searchForm" action="" method="get" style="text-align:center">
                <div class="select">
                    <select class="custom-select" name="condition" id="condition">
                        <option value="writer">작성자</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword">
                </div>
                <button type="button" class="searchBtn btn btn-secondary" onclick="searchInquiry(1)">검색</button>
            </form>
            <br><br>
        </div>
        <br><br>

    </div>
    
    <script>
    
	    function searchInquiry(num){
	        const condition = $('option:selected').val();
	        const keyword = $('input[name="keyword"]').val();
	        const currentPage = num;
	        
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
	                page: currentPage
	            },
	            success: function(searchResult) {
	            	 
	            	const inquiryList = searchResult.inquiryList;
	            	const pageInfo = searchResult.pageInfo;
	            	
	            	updateInquiryList(inquiryList);
	            	updatePageInfo(pageInfo);
	            }
	           
	        });
	    }
	    
	    function updateInquiryList(inquiryList) {
	    	const inquiryListBody = $('#inquiryListBody');
	       	inquiryListBody.empty();
	        
	       	const resultStr = inquiryList.map(e => {
	       	    const style = `\${e.inquiryGroup === 2 ? 'background-color: lightgray;' : ''}`;
	       	 	const title = `\${e.inquiryGroup === 2 ? e.inquiryTitle : '🔒고객 문의'}`;
	       	    const answerStatus = `\${e.answerStatus === 'Y' ? '✔️' : ''}`;
	       	 	console.log('Style:', style);

	       	    return `
	       	        <tr onclick="detail('\${e.inquiryNo}')" style="\${style}">
	       	            <td>\${e.inquiryNo}</td>
	       	            <td>\${title}</td>
	       	            <td>\${e.nickname}</td>
	       	            <td>\${e.count}</td>
	       	            <td>\${e.createDate}</td>
	       	            <td>\${answerStatus}</td>
	       	        </tr>
	       	    `;
	       	}).join('');
	        
	        inquiryListBody.html(resultStr);
	    }
	    
	    function updatePageInfo(pageInfo) {
	    	const pagingArea = $('#pagingArea');
	        
	        let pagingStr = 
	        `<ul class="pagination">`;

	        if (pageInfo.currentPage > 1) {
	            pagingStr += `<li class="page-item"><a class="page-link" onclick="searchInquiry(\${pageInfo.currentPage - 1})">이전</a></li>`;
	        } else {
	            pagingStr += `<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>`;
	        }
	        
	        for (let i = pageInfo.startPage; i <= pageInfo.endPage; i++) {
	            pagingStr += `<li class="page-item">
	                            <a class="page-link" onclick="searchInquiry(\${i})">\${i}</a>
	                          </li>`;
	        }

	        if (pageInfo.currentPage != pageInfo.endPage) {
	            pagingStr += `<li class="page-item"><a class="page-link" onclick="searchInquiry(\${pageInfo.currentPage + 1})">다음</a></li>`;
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