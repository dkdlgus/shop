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
<!-- Swiper CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@latest/swiper-bundle.min.css">
<style>
/* 슬라이더 스타일 */
.swiper-container {
    width: 100%; /* 전체 너비 */
    height: 500px; /* 높이를 500px로 설정 */
    position: relative; /* 슬라이더 내부 위치 조정용 */
    overflow: hidden; /* 슬라이드 바깥 영역 숨기기 */
}
.swiper-slide {
    display: flex;
    justify-content: center;
    align-items: center;
    background: #fff;
}
.swiper-slide img {
    width: auto; /* 이미지 너비를 자동으로 설정 */
    height: 100%; /* 슬라이드의 높이에 맞게 설정 */
    object-fit: cover; /* 이미지 비율 유지 */
}
/* 페이지네이션과 네비게이션 버튼 스타일 */
.swiper-pagination {
    bottom: 10px !important; /* 페이지네이션 위치 조정 !important는 덮어쓰기 */
}
.swiper-button-next, .swiper-button-prev {
    color: #000; /* 화살표 색상 */
    align-items: center; /* 수직 정렬 */
    justify-content: center; /* 수평 정렬 */
    z-index: 10; /* 버튼이 슬라이드 내용 위에 오도록 설정 */
}
</style>
</head>
<body>
<%@include file="../include/header.jsp"%>
<!-- Swiper -->
<div class="swiper-container">
    <div class="swiper-wrapper">
        <div class="swiper-slide"><img src="../images/sssss1.PNG" alt="Slide 1"></div>
        <div class="swiper-slide"><img src="../images/sssss2.PNG" alt="Slide 2"></div>
        <div class="swiper-slide"><img src="../images/sssss3.PNG" alt="Slide 3"></div>
    </div>
    <!-- 슬라이더 페이지 -->
    <div class="swiper-pagination"></div>
    <!-- 슬라이더 네비게이션 -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
</div>
<div class="container" id="mainContent">
    <div class="d-flex justify-content-between align-items-center my-4">
    	<div class="d-flex align-items-center">
        	<i class="fas fa-star" style="font-size: 2rem;"></i>
        	<h2 class="heading font-weight-bold text-secondary mb-0 ml-2">인기 BEST</h2>
    	</div>
    	<div class="text-right">
        	<h2 class="d-inline text-right">전체보기</h2>
        	<button type="button" id="shopBtn" class="btn btn-primary d-inline mb-3" style="font-size: 1.5rem; border: none; background: none;">➕</button>
    	</div>
	</div>
    <div class="row justify-content">
        <c:forEach items="${list}" var="list">
            <div class="col-md-3 mb-5">
                <div class="card h-100 text-center">
                    <div class="card-body">
                        <div class="image mb-3" data-rno="${list.rno}">
                            <!-- 이미지가 여기에 삽입됩니다 -->
                        </div>
                        <h5 class="card-title font-weight-bold text-dark" data-name="${list.sname}" data-price="${list.moneyshop}">${list.sname}</h5>
                        <p class="card-text">
                            <span class="text-danger font-weight-bold" style="font-size: 24px;">${list.discount}%</span>
                            <span class="text-dark font-weight-bold" style="font-size: 24px;">
                                <fmt:formatNumber value="${list.moneyshop}" type="number" />원
                            </span>
                            <span style="text-decoration: line-through; color: #d3d3d3;">
                                <fmt:formatNumber value="${list.money}" type="number" />원
                            </span>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<%@include file="../include/footer.jsp" %>
<%@include file="../include/homeModal.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/swiper@latest/swiper-bundle.min.js"></script>
<script>
var swiper = new Swiper('.swiper-container', {
    loop: true, // 무한 슬라이드
    pagination: {
        el: '.swiper-pagination',
        clickable: true,
        //renderBullet: function(index, className){
       	 //각 페이지네비게이션 버튼에 텍스트 추가.
       	 //var texts = ["첫번째 페이지", "두번째 페이지", "세번째 페이지"];
       	 //return '<span class="' + className + '">' + texts[index] + '</span>';
        //}
    },
    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },
});
</script>
<script>
(function(){
    let rnoElements = document.querySelectorAll(".image");

    rnoElements.forEach(function(element){
        let rno = element.getAttribute("data-rno");
        
        $.getJSON("getImageList", { rno: rno }, function(arr){

            let str = "";
            let hasImage = false;
            
            $(arr).each(function(i, obj){

                if(obj.filetype === true && !hasImage){
                    let fileCallPath = encodeURIComponent(obj.uploadpath + "/" + obj.uuid + "_" + obj.filename);
 
                    str += "<img class='img-fluid fixed-size' src='../image/display?filename=" + fileCallPath + "' alt='...' />";
                    
                    hasImage = true;
                }
            });
            if(!hasImage) {
                str += "<img class='img-fluid fixed-size' src='../images/cabin.png' alt='...' />"; // 이미지 없을 때 기본 이미지 표시
            }
            $(element).html(str); // 요소 내부에 이미지 삽입
        });
        
        element.addEventListener('click', function() {
            $.getJSON("getHomeModal", { rno: rno }, function(data) {
            	if (data.imageList && data.imageList.length > 0) {
                    let image = data.imageList[0];
                    let fileCallPath = encodeURIComponent(image.uploadpath + "/" + image.uuid + "_" + image.filename);
                    $("#modalImage").attr("src", "../image/display?filename=" + fileCallPath);
                } else {
                    $("#modalImage").attr("src", "../images/cabin.png");
                }
                $("#modalName").text(data.sname);
                $("#modalDescription").text(data.description || "상품 설명이 없습니다.");
                $("#modalPrice").text(data.money.toLocaleString() + '원');
                $("#modalDiscount").text(data.discount.toLocaleString() + '%');
                $("#modalDiscountedPrice").text(data.moneyshop.toLocaleString() + '원');
                $("#productModal").modal("show");
                $("#modalRno").val(rno); // rno 값을 hidden input에 설정
            });
        });
        
    });
})();
</script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
let user = {
    username: "${username}",
    email: "${email}",
    tell: "${tell}"        
};

let modal = $("#productModal");

// 결제 API 호출
IMP.init("imp00365056"); // 식별코드를 사용하여 초기화

let button = document.querySelector("#pBtn");

let onClickPay = async () => {
    
	button.disabled = true; // 버튼 중복클릭 방지. 비활성화
	
	console.log("Payment request initiated.");
	
	// 모달에서 상품 정보 가져오기
    let productName = document.getElementById('modalName').innerText;
    let productPriceStr = document.getElementById('modalDiscountedPrice').innerText;
    let productPrice = parseFloat(productPriceStr.replace(/[^0-9.-]/g, '')); // 가격에서 숫자만 추출하고 변환
    let rno = document.getElementById('modalRno').value;
    
    // 고유한 merchant_uid 생성
    let uniqueMerchantUid = "ORD" + new Date().getTime() + Math.floor(Math.random() * 1000);
    
    try {
    	
    	console.log("Sending order information to server.");
    	
        let orderResponse = await fetch('../home/order', { // 주문 정보를 저장할 엔드포인트
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                rno: rno,
                merchantuid: uniqueMerchantUid,
                name: productName,
                amount: productPrice,
                buyer_name: user.username,
                buyer_email: user.email,
                buyer_tel: user.tell
            })
        });
        
        if (!orderResponse.ok) {
            throw new Error('주문 정보 저장 실패');
        }
		
        console.log("Order information saved successfully.");
        
        // 결제 API 호출
        IMP.request_pay({
            pg: "kakaopay.TC0ONETIME",
            pay_method: "card",
            amount: productPrice,
            name: productName,
            merchant_uid: uniqueMerchantUid,
            buyer_email: user.email,
            buyer_name: user.username,
            buyer_tel: user.tell,
        }, async function(response) {
        	button.disabled = false; // 결제 완료 후 버튼 활성화
            if (response.success) {
            	console.log("Payment success response:", response);
                alert("결제가 완료되었습니다.");
				modal.modal("hide");
            } else {
                alert("결제 실패: " + response.error_msg);
            }
        });

    } catch (error) {
        console.error('Error saving order:', error);
        alert('주문 정보 저장 중 오류가 발생했습니다.');
    }
    
    button.disabled = false; // 버튼 다시 활성화
};

button.addEventListener("click", onClickPay);
</script>
</body>
</html>