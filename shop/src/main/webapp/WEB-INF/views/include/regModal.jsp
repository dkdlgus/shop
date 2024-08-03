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

<div class="regModal modal fade" id="myRegModal" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="trun">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-secondary">
				<h4 class="modal-title multiEffect"><i class="fas fa-reply" aria-hidden="true">&nbsp;Modal</i></h4>
				<button class="close" type="button" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="attach col-md-5">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div>
                        	<label for="upload">&nbsp;&nbsp;&nbsp;상품 이미지:</label>
                        </div>
                        <div class='uploadResult mt-3'>	
							<div id='cardRow'>
							</div>
							<input type="file" class="form-control" id="upload" name="imageFile" multiple />
						</div>
                    </div>
					<div class="col-md-7">
						<div class="form-group">
							<label>상품 이름</label>
							<input class="form-control" name='sname' placeholder="상품 이름을 적어주세요." required />
						</div>
						<div class="form-group">
							<label>상품 금액</label>
							<input class="form-control" name='money' id='money' placeholder="상품 금액을 적어주세요." required />
						</div>
						<div class="form-group">
							<label>할인율</label>
							<input class="form-control" name='discount' id='discount' placeholder="할인율 적어주세요(%)" required />
						</div>
						<div class="form-grop">
							<label>할인적용 금액 : </label>
							<span id='moneyshop_display' class="text-dark font-weight-bold"></span>
							<input type="hidden" name='moneyshop' id='moneyshop' />
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
				<button id='modalModifyBtn' type="button" class="btn btn-primary">수정</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-primary">삭제</button>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	
	let modalObj = $("#myRegModal");
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880; //5MB
	
	let uploadUL = $(".uploadResult #cardRow");
	
	//security csrf설정
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	
	//beforeSend대신 사용(한번만 지정)
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	//파일 업로드 이벤트 처리
	$("input[type='file']").change(function(e){
		
		let formData = new FormData(); //가상의 form엘리먼트 생성
		let inputFile = $("input[name='imageFile']");
		let files = inputFile[0].files;
		console.log(files);
		
		for(let i = 0; i < files.length; i++)  {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}			
			formData.append("imageFile", files[i]); 
			 //선택한 파일들을 input type="file" name="uploadFile" value="files[i]"로 만들어 붙이기
		}
		
		$.ajax({			
			url: '../image/imageAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',					    
		    dataType : 'json', //생략해도 무방		
		    //beforSend: function(xhr){ //ajax시 csfr등록, 메 ajax에 지정
		    //	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    //},
			success : function(result) {
				console.log(result);
				//alert(result);
				uploadUL.empty(); // 기존 이미지 요소 제거
				showUploadResult(result);
				$("#upload").val(""); //파일 입력창 초기화
			},
			error : function() {
				alert("ajax upload failed");
			}
		});
	});
	
	function checkExtension(filename, fileSize) {
		
		if(fileSize >= maxSize) {
			alert("파일 사이즈 초과");
		    return false;
		}
		if(regex.test(filename)) {
			 alert("해당 종류의 파일은 업로드할 수 없습니다.");
		     return false;
		}
		return true;
	}
	
	function showUploadResult(uploadResultArr) {
		if(!uploadResultArr || uploadResultArr.length == 0) {
			return;
		}
		$(uploadResultArr).each(function(i, obj){
			let str ="";
			if(obj.image) {
				let fileCallPath =  encodeURIComponent( obj.uploadpath+ "/"+obj.uuid +"_"+obj.filename);
				str += "<div class='card'>";
				str += "<div class='card-body'>";
				str += "<p class='mx-auto' style='width:90%;' title='"+ obj.filename + "'" ;
				str +=  "data-path='"+obj.uploadpath +"' data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'>";
				str += "<img class='mx-auto d-block' style='object-fit:cover; width: 100%; height: 100%;' src='../image/display?filename="+fileCallPath+"'>";
				str += "</p>";
				str += "</div>";
				str += "</div>";
			}
			uploadUL.append(str);
		});		
	}
	
	$('#myRegModal').on('shown.bs.modal', function(){
		let moneyInput = $('#money');
		let discountInput = $('#discount');
		let moneyshopDisplaySpan = $('#moneyshop_display');
		let moneyshopInput = $('#moneyshop');
		
		function calculateDiscountedPrice(){
			let money = parseFloat(moneyInput.val()) || 0;
			let discount = parseFloat(discountInput.val()) || 0;
			
			let discountedPrice = money - (money * (discount / 100)); // 할인율 적용한 금액 계산
			moneyshopDisplaySpan.text(discountedPrice.toLocaleString()); // .toFixed(2) 는 소수점 .toLocaleString() 는 10,000 (,)표시 만들기
			moneyshopInput.val(discountedPrice); // 히든 입력 필도 실제 적용된 값 전달
		}
		
		moneyInput.on('input', calculateDiscountedPrice);
		discountInput.on('input', calculateDiscountedPrice);
		
		// 모달이 닫힐 때 이벤트 리스너 제거
	    $('#myRegModal').on('hidden.bs.modal', function () {
	        moneyInput.off('input', calculateDiscountedPrice);
	        discountInput.off('input', calculateDiscountedPrice);
	    });
	});	
});
</script>
</body>
</html>