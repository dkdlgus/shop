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
#container {
    max-width: 600px;
    padding: 30px;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}
.main_title {
    text-align: center;
    margin-bottom: 20px;
}
.form-group label {
    font-weight: bold;
}
.form_footer {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}
.btn {
    width: 48%;
}
</style>
<body>

<%@include file="../include/header.jsp" %>

<div class="container" id="mainContent">
	<div class="form">
		<h5 class="main_title">회원가입</h5>
		<p class="sub">
			<span style="color: red">*</span> 필수입력사항
		</p>
		<form action="../member/customJoin" method="post" id="frm1" name="frm1">
			<!-- 회원 가입시 csrf토큰 값 히든으로 보내주기 -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="form-group">
				<div class="row" id="font_size">
					<label for="uId" class="col-md-4 col-form-label" id="fst" style="padding-top:29px;">아이디<span style="color: red">*</span></label>
					<div class="col-md-5" id="sst" style="padding-top:19px;">
						<input type="text" class="form-control" name="userid" placeholder="아이디 입력" id="uId" required/>
					</div>
					<div class="col-md-3" id="sst" style="padding-top:19px;">
						<button type="button" id="id_chk" class="btn btn-outline">중복체크</button>
						<input type="hidden" name="reid">
					</div>
				</div>
				<span id="userIDError" style="color: red;"></span>
			</div>
			<div class="form-group">
				<div class="row mb-3" id="font_size">
					<label for="uPw" class="col-md-4 col-form-label" id="fst">비밀번호<span style="color: red">*</span></label>
					<div class="col-md-5" id="sst">
						<input type="password" class="form-control" name="userpw" id="uPw" placeholder="비밀번호 입력" required />
						<span class="final_pw_ck" style="display:none;"></span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="row" id="font-size">
					<label for="uPwChk" class="col-md-4 col-form-label" id="fst">비밀번호확인<span style="color: red">*</span></label>
					<div class="col-md-5" id="sst">
						<input type="password" class="form-control" name="userpwChk" id="uPwChk" placeholder="비밀번호확인 입력" required />
					</div>
				</div>
				<span class="final_pwck_ck" style="display:none;"></span>
				<span class="pwck_input_re_1" style="display:none;">비밀번호가 일치합니다.</span>
				<span class="pwck_input_re_2" style="display:none;">비밀번호가 일치하지 않습니다.</span>
			</div>
			<div class="form-group">
				<div class="row mb-3" id="font_size">
					<label for="uName" class="col-md-4 col-form-label" id="fst">닉네임<span style="color: red">*</span></label>
					<div class="col-md-5" id="sst">
						<input type="text" class="form-control" name="username" id="uName" placeholder="닉네임을 입력해주세요." required/>
					</div>
				</div>
			</div>
			
			<div class="boder_btom"></div>
			<div id="formSubmit" class="form_footer">
				<button type="submit" class="btn btn-success">회원가입</button>
				<button type="button" class="btn btn-danger" id="homeBtn">홈으로</button>
			</div>
		</form>
	</div>
</div>

<%@include file="../include/footer.jsp" %>

<script>
let pwCheck = false; //비번
let pwckCheck = false; //비번확인
let pwckcorCheck = false; //비번확인 일치 확인

$(function(){
	let pw = $('#uPw').val();
	let pwck = $('#uPwChk').val();
	
	$('#uPwChk').on("input", function(e){
        e.preventDefault();
        let pw = $('#uPw').val();
        let pwck = $('#uPwChk').val();

        if (pw === "" || pwck === "") {
            $('.final_pwck_ck').css('display','none');
            $('.pwck_input_re_1').css('display','none');
            $('.pwck_input_re_2').css('display','none');
            pwckcorCheck = false;
        } else {
            if (pw === pwck) {
                $('.pwck_input_re_1').css('display','block');
                $('.pwck_input_re_2').css('display','none');
                pwckcorCheck = true;
            } else {
                $('.pwck_input_re_1').css('display','none');
                $('.pwck_input_re_2').css('display','block');
                pwckcorCheck = false;
            }
        }
    });
	
	$("#id_chk").click(function(e){
		e.preventDefault();
		
		//입력한 아이디 값 가져오기
		let userID = document.frm1.userid.value;
		
		//정규 표현식을 사용하여 특수문자 체크
		let regex = /^[a-zA-Z0-9]+$/;
		
		if(!userID.trim()){
			alert('아이디를 입력하여 주십시오.');
			document.frm1.userid.focus();
			return false;
		}
		else if(!regex.test(userID)){
			alert('특수문자를 사용할 수 없는 아이디입니다.');
			document.frm1.userid.focus();
			document.frm1.userid.value = "";
			//아이디 중복 체크 후 해당 span 초기화
			$("#userIDError").text(""); //내용을 비웁니다.
			$("#userIDError").css("color", ""); //글자 색 초기화
			$("#userIDError").css("margin", ""); //여백 초기화
			return false;
		}
		
		//아이디 중복 체크 로직 추가
		$.ajax({
			url: "../member/idChk?userid=" + userID,
			type: "GET",
			success: function(result){
				if(result === "success"){
					document.frm1.reid.value = userID;
					alert("사용 가능한 아이디 입니다.");
				}
				else{
					document.frm1.userid.focus();
					document.frm1.userid.value = "";
					alert("중복된 아이디입니다. 다른 아이디를 등록하세요.");
					
					//아이디 중복 체크 후 해당 span초기화
					$("#userIDError").text(""); //내용을 비웁니다.
					$("#userIDError").css("color", ""); //글자 색 초기화
					$("#userIDError").css("margin", ""); //여백 초기화
				}
			}
		});
	});
	
	$("#uPwChk").blur(function(){
		if(document.frm1.userpw.value != document.frm1.userpwChk.value){
			alert("암호가 일치하지 않습니다.");
			document.frm1.userpw.value = "";
			document.frm1.userpwChk.value = "";
			frm1.userpw.focus();
			return false;
		}
	});
	
	$("#frm1").submit(function(){
		if(document.frm1.reid.value != document.frm1.userid.value){
			alert("체크한 아이디를 다시 수정하셨습니다.");
			return false;
		}
		
		return true;
	});
	
	$("#homeBtn").on("click", function(){
		self.location = "/shop";
	});
});
</script>

<script>
//클라이언트 측 유효성 검사
document.getElementById("uId").addEventListener("input", function(){
	var userID = this.value;
	
	//특수문자를 포함하지 않는 사용자 아이디를 위한 정규 표현식.
	var regex = /^[a-zA-Z0-9]+$/;
	
	if(!regex.test(userID)){
		document.getElementById("userIDError").textContent = "특수문자를 사용할 수 없습니다.";
		document.getElementById("userIDError").style.color = "red";
		document.getElementById("userIDError").style.margin = "0 155px";
	}
	else{
		document.getElementById("userIDError").textContent = "";
	}
});
</script>
</body>
</html>