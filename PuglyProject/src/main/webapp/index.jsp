<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/menubar.jsp" />
	
	<div style="height : 500px;">
		<h1>Hi! I'm welcome file</h1>
		
		<h2>각자 앞단 넣어서 테스트 해보아요</h2>
		<a href="">병민</a>
		<a href="">상은</a>
		<a href="farms">재성</a>
		<a href="testmain">한솔</a>
	 </div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>