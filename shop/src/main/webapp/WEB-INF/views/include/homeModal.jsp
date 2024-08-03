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
<style>
.modal-header {
    border-bottom: 1px solid #dee2e6;
}
.modal-body {
    padding: 2rem;
}
.product-image img {
    max-height: 300px;
    object-fit: cover;
}
.text-secondary {
    color: #6c757d !important;
}
.text-muted {
    color: #adb5bd !important;
}
.font-weight-bold {
    font-weight: 700 !important;
}
</style>
</head>
<body>
<!-- 상품 정보 모달 -->
<div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="productModalLabel">상품 정보</h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6 text-center">
                        <img id="modalImage" src="" alt="상품 이미지" class="img-fluid rounded shadow">
                    </div>
                    <div class="col-md-6">
                        <h4 id="modalName" class="text-center mt-3 font-weight-bold"></h4>
                        <p id="modalDescription" class="text-center text-muted"></p>
                        <div class="text-center">
                        	<span id="modalDiscount" class="text-danger font-weight-bold d-inline" style="font-size: 30px;"></span>
    						<span id="modalDiscountedPrice" class="d-inline" style="font-size: 28px; color: black; font-weight: 900; margin-right: 10px;"></span>
    						<span id="modalPrice" class="font-weight-bold d-inline" style="font-size: 20px; text-decoration: line-through; color: #d3d3d3; margin-right: 10px;"></span>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
            	<button type="button" id="pBtn" class="btn btn-primary">구매</button>
            </div>
        </div>
    </div>
</div>
<script>


</script>
</body>
</html>