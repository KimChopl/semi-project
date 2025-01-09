<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Document</title>

    <style>
        #body{
            width: 1200px;
            margin : auto;
        }
        div{
            border : 0.3px solid gray;
        }
        .book-box{
            height: 120px;
        }
        #acceptance{
            width: 100%;
            height: 500px;
        }
        #cover-btn{
            height: 50px;
            text-align: center;
        }
        #cancel-content{
            width: 100%;
            height: 300px;
        }
        .book-content:hover {
            cursor: pointer;
        }
        .btn-cover{
        	display: flex;
    		justify-content: flex-start;
        }
        .delete-btn{
        	margin-left: auto;
        }
    </style>
</head>
<body>
    <div id="body">
    	<jsp:include page="/WEB-INF/views/common/menubar.jsp" />
        <div class="container">
            <div class="row">
                <div class="col">
                    ${ sessionScope.loginUser.nickname }님 예약 현황
                </div>
            </div>
            <div class="row">
                <div class="col" id="boook">
                <c:forEach items="${ books }" var="b">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="book-box">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-3">
                                                <div class="book-user">
                                                    <label id="name-${b.bookNo}">${ b.nickname }</label>
                                                </div>
                                            </div>
                                            <div class="col-9">
                                                <div class="container">
                                                    <div class="row">
                                                        <div class="col-4">${ b.playDate }</div>
                                                        <div class="col-4">${ b.adultNo }</div>
                                                        <div class="col-4">${ b.kidNo }</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-3">
                                                <div class="farm-title">
                                                    <label id="title-${ b.bookNo}">${ b.farmTitle }</label>
                                                </div>
                                            </div>
                                            <div class="col-9">
                                                <div class="book-content">
                                                	${ b.bookSub }
                                                    <button value="${ b.bookContent }" class="btn btn-sm btn btn-outline-dark book-content" data-bs-toggle="modal" data-bs-target="#booker-content">더보기</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="btn-cover">
                                   
                                    <input type="hidden" id="book-no" value="${ b.bookNo }" >
                                    	<c:if test="${ empty b.cancel  && empty b.play}">
                                        <button value="${ b.bookNo }" data-bs-toggle="modal" data-bs-target="#cancel" class="btn btn-danger cancel-btn">취소하기</button>
                                        <c:if test="${ sessionScope.loginUser.categoryNo eq 2 && empty b.decide && empty b.play}">
                                        <button value="${ b.bookNo }" type="button" data-bs-toggle="modal" data-bs-target="#acceptance-btn" class="btn btn-primary decide-btn">확정하기</button>
                                        </c:if>
                                        <c:if test="${ sessionScope.loginUser.categoryNo eq 2 && not empty b.decide && empty b.play }">
                                        <button value="${ b.bookNo }" type="button" data-bs-toggle="modal" class="btn btn-primary play-btn">체험 진행 확인</button>
                                        </c:if>
                                        <c:if test="${ not empty b.play && sessionScope.loginUser.categoryNo eq 3}">
                                        <button value="${ b.farmNo }" type="button" class="btn btn-sm btn-success review-btn">리뷰하기</button>
                                    	</c:if>
                                        </c:if>
                                        <c:if test="${ not empty b.cancel  || not empty b.play}">
											<button type="button" class="btn btn-sm btn-danger delete-btn" onclick="deleteBook(${b.bookNo})">삭제하기</button>                                        
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </div>
            </div>
			        <div class="row">
			            <div class="col">
			            	<input type="hidden" value="${ sessionScope.loginUser.categoryNo }" id="category-no">
			            	<input  type="hidden" value="${ mi.listCount }" id="bookCount">
			            	<input  type="hidden" value="${ mi.lastNo }" id="lastNo">
			                <button class="btn btn-sm btn-info" id="more-btn" style="display:none;">더보기</button>
			            </div>
			        </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
<div class="modal" tabindex="-1" id="acceptance-btn">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">예약 확정</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <div id="acceptance">
                <div class="container">
                    <div class="row">
                        <div class="col" id="decide-content">
                        
                               
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
          <button type="button" class="btn btn-primary" id="decide">확정하기</button>
        </div>
      </div>
    </div>
  </div>
 
  <div class="modal" tabindex="-1" id="cancel">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">예약 취소</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div id="cancel-answer">
            <label>취소 사유</label>
            <div>
                <textarea name="content" style="resize:none;" id="cancel-content"></textarea>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
          <button type="button" class="btn btn-primary" id="cancel-btn">취소확정</button>
        </div>
      </div>
    </div>
  </div>
  <div class="modal" tabindex="-1" id="booker-content">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">예약자 편지</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p id="book-content">
          	
          </p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <script>
  	const moreBtn = document.getElementById('more-btn')
  	const listCount = document.getElementById('bookCount').value
  	
  	
	function createDiv(r){
         const books = [...r.books]
	    const bookDiv = books.map(e => {
	    	const categoryNo = document.getElementById('category-no').value
             const el1 = document.createElement('div')
             el1.classList.add('container')
             const el2 = document.createElement('div')
             el2.classList.add('row')
             el1.appendChild(el2)
             const el3 = document.createElement('div')
             el3.classList.add('col')
             el2.appendChild(el3)
             const el4 = document.createElement('div')
             el4.classList.add('book-box') // this
             el3.appendChild(el4)
             const el5 = document.createElement('div')
             el5.classList.add('container')
             el4.appendChild(el5)
             const el6 = document.createElement('div')
             el6.classList.add('row') 
             el5.appendChild(el6)
             const el7 = document.createElement('div')
             el7.classList.add('col-3')
             el6.appendChild(el7)
             const el8 = document.createElement('div')
             el8.classList.add('book-user')
             el7.appendChild(el8)
             const el9 = document.createElement('label')
             el9.id = `name-\${e.bookNo}`
             el9.innerText = `\${e.nickname}`
             el8.appendChild(el9) // end
             const el10 = document.createElement('div')
             el10.classList.add('col-9')
             el6.appendChild(el10)
             const el11 = document.createElement('div')
             el11.classList.add('container')
             el10.appendChild(el11)
             const el12 = document.createElement('div')
             el12.classList.add('row') // end
             el11.appendChild(el12)
             const el13 = document.createElement('div')
             el13.classList.add('col-4')
             el13.innerText = `\${e.playDate}`
             el12.appendChild(el13)
             const el14 = document.createElement('div')
             el14.classList.add('col-4')
             el14.innerText = `\${e.adultNo}`
             el12.appendChild(el14)
             const el15 = document.createElement('div')
             el15.classList.add('col-4')
             el15.innerText = `\${e.kidNo}`
             el12.appendChild(el15)
             const el16 = document.createElement('div')
             el16.classList.add('container')
             el4.appendChild(el16)
             const el17 = document.createElement('div')
             el17.classList.add('row')
             el16.appendChild(el17)
             const el18 = document.createElement('div')
             el18.classList.add('col-3')
             el17.appendChild(el18)
             const el19 = document.createElement('div')
             el19.classList.add('farm-title')
             el18.appendChild(el19)
             const el20 = document.createElement('label')
             el20.id = `title-\${e.bookNo}`
             el20.innerText = `\${e.farmTitle}`
             el19.appendChild(el20)
             const el21 = document.createElement('div')
             el21.classList.add('col-9')
             el17.appendChild(el21)
             const el22 = document.createElement('div')
             el22.classList.add('bookContent')
             el22.innerText = `\${e.bookSub}`
             el21.appendChild(el22)
             const el23 = document.createElement('button')
             el23.classList.add('btn', 'btn-sm', 'btn-outline-dark', 'book-content')
             el23.value = `\${e.bookContent}`
             el23.setAttribute('data-bs-toggle', 'modal')
             el23.setAttribute('data-bs-target', '#booker-content')
             el23.innerText = '더보기'
             el22.appendChild(el23)
             const el24 = document.createElement('div')
             el24.classList.add('btn-cover')
             el4.appendChild(el24)
             const el25 = document.createElement('input')
             el25.value = `\${e.bookNo}`
             el25.type = 'hidden'
             el25.id = 'book-no'
             el24.appendChild(el25)
             
             const el26 = document.createElement('button')
             
             const el27 = document.createElement('button')
             
             const el28 = document.createElement('button')
             
             const el29 = document.createElement('button')
             
             const el30 = document.createElement('button')
             if(e.cancel != e.bookNo && e.play != e.bookNo){
                 el26.value = `\${e.bookNo}`
                 el26.classList.add('btn', 'btn-danger', 'cancel-btn')
                 el26.setAttribute('data-bs-toggle', 'modal')
                 el26.setAttribute('data-bs-target', '#acceptance-btn')
                 el26.type = 'button'
                 el26.innerText = '취소하기'
                 el24.appendChild(el26)
                 console.log(`\${e.decide} : \${e.bookNo} : \${e.play} : \${categoryNo}`)
                 if(categoryNo === '2' && !e.decied && !e.play ){
                     el27.value = `\${e.bookNo}`
                     el27.type = 'button'
                     el27.classList.add('btn', 'btn-primary', 'decide-btn')
                     el27.setAttribute('data-bs-toggle', 'modal')
                     el27.setAttribute('data-bs-target', '#acceptance-btn')
                     el27.innerText = '확정하기'
                     el24.appendChild(el27)
                 }
                 if(categoryNo === '3' && e.decide === e.booNo && !e.play){
                     el28.value = `\${e.bookNo}`
                     el28.type = 'button'
                     el28.classList.add('btn', 'btn-promary', 'play-btn')
                     el28.innerText = '체험 완료'
                     el24.appendChild(el28)
                 }
                 if(categoryNo === '3' && e.play === e.booNo){
                     el29.value = `\${e.bookNo}`
                     el29.type = 'button'
                     el29.classList.add('btn', 'btn-success', 'review-btn')
                     el29.innerText = '리뷰하기'
                     el24.appendChild(el29)
                 }
             } else{
                 el30.type = 'button'
                 el30.classList.add('btn', 'btn-danger', 'btn-sm', 'delete-btn')
                 el30.setAttribute('onclick', `deleteBook(\${e.bookNo})`)
                 el30.innerHTML = '삭제하기'
                 el24.appendChild(el30)
             }
             return el1.outerHTML;
         })
         const result = bookDiv.join('')
         return result
	}
  	
  	function suchBook(){
  		const lastNo = document.getElementById('lastNo')
  		$.ajax({
  			url : 'more/book',
  			type : 'post',
  			data : {
  				plusNo : lastNo.value
  			},
  			success : function(r){
  				lastNo.value = r.mi.lastNo;
  				const insertDiv = document.getElementById('boook')
  				console.log(r)
  				insertDiv.innerHTML += createDiv(r)
  				if(r.mi.lastNo === r.mi.listCount){
  					moreBtn.style.display = 'none'
  				}
  			}
  		
  		})
  	}
  	
  	if(listCount > 5){
  		moreBtn.style.display = 'inline-block'
  	}
  	moreBtn.addEventListener('click', function(){
  		suchBook()
  	})
  </script>
  <script>
  	function deleteBook(n){
  		const askDelete = confirm('삭제 하시겠습니까?');
  		if(askDelete){
	  		location.href = `book/deleteBook?bookNo=\${n}`
  		}
  		location.reload();
  	}
  </script>
  <script>
  	const review = document.getElementsByClassName('review-btn');
  	const book = document.getElementById('book-no');
  	const bookNo = book.value;
  	for(let i of review){
  		const farmNo = i.value;
  		console.log(farmNo);
  		i.addEventListener('click', () => {
  			location.href = `review/post/\${farmNo}/\${bookNo}`;
  		})
  	}
  </script>
  <script>
   const play = document.getElementsByClassName('play-btn');
   for(let i of play){
	   const value = i.value;
	   i.addEventListener('click', () => {
		  const playResult =  confirm('확정하시겠습니까?');
		  if(playResult){
			 console.log(value);
			 location.href = `play/done/\${value}`;
		  }
      })
   }
  </script>
  <script>
  	const moreContent = document.getElementsByClassName('book-content');
  	for(let i = 0; i < moreContent.length; i += 2){
	  	moreContent[i].addEventListener('click', function(e) {
	  		const bookContent = document.getElementById('book-content');
	  		bookContent.innerText = e.target.value;
  		})
  	}
  </script>
  <script>
		
	  	const decide = document.getElementsByClassName('decide-btn');
	  	for(let i = 0; i < decide.length; i ++){
	  		decide[i].addEventListener('click', function(e) {
	  			$.ajax({
	  				url : "book.content",
	  				type : "get",
	  				data : {
	  					bookNo : e.target.value
	  				},
	  				success : function(r){
	  					const result = `<div class="container">
						                        <div class="row">
						                        <div class="col">
						                            농장 제목 : \${r.farmTitle}
						                        </div>
						                    </div>
						                    <div class="row">
						                        <div class="col-4">
						                            예약일 : \${r.playDate}
						                        </div>
						                        <div class="col-4">
						                            성인 : \${r.adultNo}
						                        </div>
						                        <div class="col-4">
						                            어린이 : \${r.kidNo}
						                        </div>
						                    </div>
						                    <div class="row">
						                        <div class="col-4">
						                            예약자 : \${r.nickname}
						                        </div>
						                        <div class="col-8">
						                            전화번호 : \${r.phone}
						                        </div>
						                    </div>
						                    <div class="row">
						                        <div class="col">
						                            \${r.bookContent}
						                        </div>
						                    </div>
						                </div>
						                <input type="hidden" value="\${r.bookNo}" id="d">`;
						const inner = document.getElementById('decide-content');
						inner.innerHTML = result;
						const decidePlay = document.getElementById('d');
						const bookNo = decidePlay.value;
						const decideBtn = document.getElementById('decide');
						decideBtn.onclick = () => {
							location.href=`decide/play/\${bookNo}`;
						}
					  	
					 }
	  			})
	  			
	  		})
	  	}
  </script>
	<script>
		const cancelBtn = document.getElementsByClassName('cancel-btn');
		const decideCancel = document.getElementById('cancel-btn');
		for(let i = 0; i < cancelBtn.length; i++){
			cancelBtn[i].onclick = () => {
				const cancelBookNo = cancelBtn[i].value
				decideCancel.addEventListener('click', () => {
					console.log(cancelBookNo)
					const cancelContent = document.getElementById('cancel-content');
					const cancelText = cancelContent.value
					$.ajax({
						url : 'book/cancel',
						type : 'post',
						data : {
							content : cancelText,
							bookNo : cancelBookNo
						},
						success : function(){
							alert('취소 성공');
							location.reload();
						},
						error : function(){
							alert('취소 실패 다시 시도해주세요.');
						}
					})
				})
					
				
			}
		}
	</script>
</body>
</html>