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
<style>
#loginContent {
    max-width: 400px;
    padding: 30px;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}
#login-card {
    padding: 20px;
}
#formLabel {
    text-align: right;
    font-weight: bold;
}
.form-check-label {
    margin-left: 20px;
}
.btn {
    width: 100%;
    margin-top: 10px;
}
.error-message {
    color: red;
    margin-top: 10px;
}

</style>
<body>

<%@include file="../include/header.jsp" %>

<div class="container" id="loginContent">
	<div id="login-card">
		<!-- 
		<div class="login-card-logo">
			<img src="../images/cake.png" alt="logo">
		</div>
		 -->
		 <h4><c:out value="${logout}"/></h4>
		 <form id="loginForm" method='post' action="../login">
		 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	<div class="form-group">
		 		<div class="row">
		 			<div class="col-md-4">
		 				<label for="uId" id="formLabel">아이디</label>
		 			</div>
		 			<div class="col-md-8">
		 				<input type="text" class="form-control" name="username" placeholder="아이디 입력" id="uId" required />
		 				<span style="color:red;"><c:out value="${error}"/></span>
		 			</div>
		 		</div>
		 	</div>
		 	<div class="form-group">
		 		<div class="row">
		 			<div class="col-md-4">
		 				<label for="uPw" id="formLabel">비밀번호</label>
		 			</div>
		 			<div class="col-md-8">
		 				<input type="password" class="form-control" name="password" placeholder="비밀번호 입력" id="uPw" required />
		 			</div>
		 		</div>
		 	</div>
		 	<div class="form-group form-check">
		 		<input type="checkbox" class="form-check-input" id="rememberMe" name="remember-me" checked />
		 		<label class="form-check-label" for="rememberMe" aria-describedby="rememberMeHelp">아이디 저장</label>
		 	</div>
		 	
		 	<button type="button" class="btn btn-success" id="loginFormBtn">로그인</button>
		 	<button type="button" class="btn btn-danger" id="goBackHome">홈으로</button>
		 </form>
	</div>
</div>

<%@include file="../include/footer.jsp" %>
<script>
$(function(){
	$("#loginFormBtn").on("click", function(e){
		e.preventDefault();
		$("#loginForm").submit();
	});
	
	$("#goBackHome").on("click", function(){
		self.location = "/shop";
	});
});
</script>
</body>
</html>