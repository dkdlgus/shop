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

<h1>주문 결제</h1>

<div id="paymentDetails">
    <p><strong>상품명:</strong> <span id="paymentProductName"></span></p>
    <p><strong>가격:</strong> <span id="paymentPrice"></span></p>
    <p><strong>할인:</strong> <span id="paymentDiscount"></span></p>
    <p><strong>할인된 가격:</strong> <span id="paymentDiscountedPrice"></span></p>
</div>

<form action="/pay/processPayment" method="post">
	<input type="hidden" name="id" value="${payment.id}">
	<button type="submit" id="payButton">결제하기</button>
</form>

<%@include file="../include/footer.jsp" %>
<script>
$(document).ready(function() {
    // URL에서 상품 ID를 가져옵니다.
    var urlParams = new URLSearchParams(window.location.search);
    var productId = urlParams.get('id');

    if (productId) {
        $.getJSON("/home/getHomeModal", { rno: productId }, function(data) {
            $("#paymentProductName").text(data.sname);
            $("#paymentPrice").text(data.money.toLocaleString() + '원');
            $("#paymentDiscount").text(data.discount.toLocaleString() + '%');
            $("#paymentDiscountedPrice").text(data.moneyshop.toLocaleString() + '원');
        });
    }

    $("#payButton").on('click', function() {
        // 결제 API 호출 로직 (예: Iamport)
        window.location.href = "/your-payment-gateway-url";
    });
});
</script>
</body>
</html>