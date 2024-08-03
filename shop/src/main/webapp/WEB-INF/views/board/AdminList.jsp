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
<link rel="stylesheet" href="../css/myCss.css?after"> <!-- 수정시 바로 적용을 위해 after추가 -->
</head>
<body>

<%@include file="../include/header.jsp" %>
<div class="container" id="mainContent">
	<h4 class="text-center wordArtEffect text-dark font-weight-bold mb-3">상품권 등록</h4>
	<button type="button" class="btn btn-primary float-right" id='regBtn'>상품 등록</button>
		
		<!-- 상품 리스트 -->
		<div class="justify-content-center">
			<div class="shopList">
		
			</div>
		</div>
</div>
<%@include file="../include/footer.jsp" %>
<%@include file="../include/regModal.jsp" %>

<%--외부 js파일 임포트 --%>
<script src="../js/reg.js"></script>

<script>
$(document).ready(function(){
	//상품 등록 버튼 처리
	$("#regBtn").on("click", function(e){
		
		let modal = $("#myRegModal");
		let modalRegisterBtn = $("#modalRegisterBtn");
		
		$(".uploadResult #cardRow").html("");
		modal.find("input").val("");
		
		modalRegisterBtn.show();
		
		$(".regModal").modal("show");
	});
});
</script>

<script>
$(document).ready(function(){
	let regUL = $(".shopList");
	showList();
	
	function showList(){
		console.log("show list ");
		
		regService.getList(function(list){
		
		let str = "";
		
		for(let i = list.length - 1; i >= 0; i--){
			str += "<div class='col-md-3 mb-4 mt-5' data-rno='"+list[i].rno+"'>";
			str += "<div class='portfolio-item mx-auto'>";
			str += "<div class='portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100'>";
            if (list[i].imageList && list[i].imageList.length > 0) {
                let firstImage = list[i].imageList[0]; // 첫 번째 이미지만 표시
                let fileCallPath = encodeURIComponent(firstImage.uploadpath + "/" + firstImage.uuid + "_" + firstImage.filename);
                str += "<img class='img-fluid fixed-size' src='../image/display?filename=" + fileCallPath + "' alt='...' />";
            } else {
                str += "<img class='img-fluid fixed-size' src='../images/cabin.png' alt='...' />"; // 이미지 없을 때 기본 이미지 표시
            }
        	str += "</div>";
			str += "</div>";
			str += "<strong class='text-dark font-weight-bold'>" + list[i].sname + "</strong>";
			str += "<p>";
			str += "<span class='text-danger font-weight-bold' style='font-size: 24px;'>" + list[i].discount + "%</span> ";
			str += "<span class='text-dark font-weight-bold' style='font-size: 24px;'>" + list[i].moneyshop.toLocaleString() + "원</span> ";
			str += "<span style='text-decoration: line-through; color: #d3d3d3;'> " + list[i].money.toLocaleString() + "원</span>";
			str += "</p>";
			str += "</div>";
		}
		
		regUL.html("<div class='row' id='imageshoplist'>" + str + "</div>");
		
		});
		
	}
	
	let modal = $("#myRegModal");
	
	let modalInputTitle = modal.find("input[name='sname']");
	let modalInputMoney = modal.find("input[name='money']");
	let modalInputDiscount = modal.find("input[name='discount']");
	let modalInputMoneyshop = modal.find("input[name='moneyshop']");	
	
	let modalRegisterBtn = $("#modalRegisterBtn");
	let modalModifyBtn = $("#modalModifyBtn");
	let modalRemoveBtn = $("#modalRemoveBtn");
	
	// 등록 버튼 클릭 시
	modalRegisterBtn.on("click", function(e){
		e.preventDefault();

		console.log("submit clicked");

		let data = {
			sname: modalInputTitle.val(),
			money: modalInputMoney.val(),
			discount: modalInputDiscount.val(),
			moneyshop: modalInputMoneyshop.val(),
			imageList: []
		};

		// 이미지 정보 추가
		$(".uploadResult .card p").each(function(i, obj) {
			let jobj = $(obj);

			let imageDTO = {
				filename: jobj.data("filename"),
				uuid: jobj.data("uuid"),
				uploadpath: jobj.data("path"),
				filetype: jobj.data("type")
			};

			data.imageList.push(imageDTO);
		});

		regService.add(data, function(result) {
			alert(result);

			modal.find("input").val("");
			modal.modal("hide");

			showList();
		});
	});
	
	//조회
	$(".shopList").on("click", ".col-md-3", function(e){
		let rno = $(this).data("rno");
		
		console.log("rno.." + rno);
		
		regService.get(rno, function(sname){
			
			console.log("sname:", sname);  // 추가된 부분
	        console.log("sname.imageList:", sname.imageList);  // 추가된 부분
	        
			modalInputTitle.val(sname.sname);
			modalInputMoney.val(sname.money);
			modalInputDiscount.val(sname.discount);
			modalInputMoneyshop.val(sname.moneyshop);
			modal.data("rno", sname.rno);
			
			// 이미지 리스트 초기화
			$(".uploadResult #cardRow").html("");

			// 이미지 리스트를 모달에 추가
	        if (sname.imageList && sname.imageList.length > 0) {
	            sname.imageList.forEach(function(image) {
	                let fileCallPath = encodeURIComponent(image.uploadpath + "/" + image.uuid + "_" + image.filename);
	                let imgStr = "<div class='card' data-uuid='" + image.uuid + "' data-path='" + image.uploadpath + "' data-filename='" + image.filename + "' data-type='" + image.filetype + "'>";
	                imgStr += "<img src='../image/display?filename=" + fileCallPath + "' style='object-fit:cover; width: 100%; height: 100%;' alt='Image' />";
	                imgStr += "</div>";
	                $(".uploadResult #cardRow").append(imgStr);
	            });
	            
	        }
			
			modalRegisterBtn.hide();
			modalModifyBtn.show();
			modalRemoveBtn.show();
			
			$(".regModal").modal("show");
		});
	});
	
	//수정
	modalModifyBtn.on("click", function(e){
		
		// 이미지 리스트 가져오기
		let imageList = [];
		
		$(".uploadResult .card p").each(function(i, obj) {
			let jobj = $(obj);

			let imageDTO = {
				filename: jobj.data("filename"),
				uuid: jobj.data("uuid"),
				uploadpath: jobj.data("path"),
				filetype: jobj.data("type")
			};

			imageList.push(imageDTO);
		});
		
		let data = {
			rno : modal.data("rno"),
			sname : modalInputTitle.val(),
			money : modalInputMoney.val(),
			discount: modalInputDiscount.val(),
			moneyshop: modalInputMoneyshop.val(),
			imageList : imageList
		};
		
		regService.update(data, function(result){
			
			alert("수정 완료.");
			modal.modal("hide");
			showList();
		});
		
	});
	
	//삭제
	modalRemoveBtn.on("click", function(e){
		let rno = modal.data("rno")
		
		regService.remove(rno, function(result){
			alert(result);
			modal.modal("hide");
			showList();
		});
	});
});
</script>

</body>
</html>