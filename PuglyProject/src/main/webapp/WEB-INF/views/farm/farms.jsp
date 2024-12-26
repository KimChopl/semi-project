<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<input type="hidden" id="plusNo" name="pulsNo" value="${ mi.plusNo }" >
	<button id="btn">더보기</button>
	
	<script>
	window.onload = () =>{
		
		const plusNo = document.getElementById('plusNo');
		let no = plusNo.value;
		
		const btn = document.getElementById('btn');
		
			btn.onclick = () => {
				console.log(plusNo.value)
				$.ajax({
					url : "plus",
					type : "get",
					data : {
						plusNo : plusNo.value
					},
					success : function(r){
						document.getElementById('plusNo').value = r.mi.plusNo;
						if(r.mi.lastNo === r.mi.listCount){
							btn.style.display = 'none';
						}
						//console.log(btn);
						
					}
				
				})
			}
	}
	
	</script>
	
</body>
</html>