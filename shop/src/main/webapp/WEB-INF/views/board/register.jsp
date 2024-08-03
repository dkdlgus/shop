<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Insert title here</title>
<meta charset="UTF-8">

<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/> 
</head>
<body>
<%@include file="../include/header.jsp" %>
<div class="container mt-4 mb-4" id="registerContent">
	<div id="submain">
		<h4 class="text-center wordArtEffect text-success">게시물 등록</h4>
		<form action="register" method="post" id="freg" name="freg" role="form">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="form-group">
				<label for="title">제목 :</label>
				<input type="text" class="form-control" id="title" placeholder="Enter Title" name="title" required />
			</div>
			<div class="form-group">
				<label for="content">내용 : </label>
				<textarea class="form-control" id="content" placeholder="Enter Content" name="content" rows="10" required>
				</textarea>
			</div>
			<div class="form-group">
				<label for="username">작성자 : </label>
				<input type="text" class="for-control" id="username" name="username"
					value='<sec:authentication property="principal.username" />' readonly/>
			</div>
			
			<button type="submit" class="btn btn-success">작성</button>
			<button type="button" id="homeBtn" class="btn btn-danger">목록</button>
		</form>
	</div>
</div>
<%@include file="../include/footer.jsp" %>
</body>
</html>