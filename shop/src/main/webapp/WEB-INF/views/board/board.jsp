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

<!-- list화면 표시 -->
<div class="container mt-4 mb-4" id="mainContent">
	<div id="submain">
		<h4 class="text-center wordArtEffect text-success">고객센터</h4>
		<div>
			<button type="button" class="btn btn-primary float-right mb-3" id="regBtn">게시물 등록</button>
		</div>
		<!-- 테이블 -->
		<div class="table-responsive-md">
			<table id="boardTable" class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일</th>
						<th>수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="board">
						<tr>
							<td class="bno"><c:out value="${board.bno}" /></td>
							<td><c:out value="${board.username}"/></td>
							<td>
								<a class="move" href='get?bno=<c:out value="${board.bno}"/>'>
									<c:out value="${board.title}"/>
								</a>
							</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedate}"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<%@include file="../include/footer.jsp" %>

<script>
$(document).ready(function(){
	
	history.replaceState({}, null, null);
	
	$("#regBtn").on("click", function(){
		self.location = "register";
	});
});
</script>
</body>
</html>