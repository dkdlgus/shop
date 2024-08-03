<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
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
<!--BS 4 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!--iamport -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!--icon -->
<!--fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="../css/myCss.css?after"> <!-- 수정시 바로 적용을 위해 after추가 -->
</head>
<body>

<nav class="navbar navbar-expand-lg bg-light-brown text-uppercase sticky-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand" href="../home/home">상점</a>
        <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive">
            메뉴
            <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav">
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#portfolio">상품권</a></li>
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                	<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="../board/AdminList">게시판</a></li>
                </sec:authorize>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="../board/board">고객센터</a></li>
            </ul>
            <ul class="navbar-nav ml-auto">
            	<!-- 로그인 안한 경우 -->
            	<sec:authorize access="isAnonymous()">
                	<li class="nav-item mx-0 mx-lg-1">
                		<a class="nav-link py-3 px-0 px-lg-3 rounded" href="../member/customLogin">로그인</a>
                	</li>
                	<li class="nav-item mx-0 mx-lg-1">
                		<a class="nav-link py-3 px-0 px-lg-3 rounded" href="../member/customJoin">회원가입</a>
                	</li>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                	<li class="nav-item mx-0 mx-lg-1">
                		<a class="nav-link py-3 px-0 px-lg-3 rounded" href="../member/customLogout">로그아웃</a>
                	</li>
                </sec:authorize>
            </ul>
        </div>
    </div>
</nav>

</body>
</html>