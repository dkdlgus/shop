console.log("reg Module...");

//즉시 실행 함수 만든후 내부 함수 만듬
let regService = (function(){
	function add(data, callback, error){
		console.log("add...");
		$.ajax({
			type: 'post', // 전송 방식
			url: '../reges/new', // 요청 경로
			data: JSON.stringify(data), // 서버로 보내는 데이터 값
			contentType: "application/json; charset=UTF-8", // 서버로 보내는 데이터 타입
			success: function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) { // 실패 시 실행 함수
				if(error) {
					error(er);
				}
			}
		}); // .ajax
	} // add 함수
	
	function remove(rno, callback, error){ // security미적용 삭제
		console.log("---------------");
		$.ajax({
			type : 'delete',
			url : '../reges/' + rno,
			success : function(deleteResult, status, xhr) {
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error) {
					error(er);
				}
			}
		}); //ajax()
	} // remove()
	
	function update(data, callback, error){
		console.log("RNO: " + data.rno);
		
		$.ajax({
			type : 'put',
			url : '../reges/' + data.rno,
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}//update()
	
	function get(rno, callback, error) {
		$.get("../reges/" + rno, function(result) {
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	} //get()
	
	function getList(callback, error){
	
		$.getJSON("../reges/pages",
			function(data){
				if(callback){
					callback(data);
				}
			}
		)
		.fail(function(xhr,status,err){
			if(error){
				error(err);
			}
		});	
	} //getList()
	
	return {
		add : add,
		get : get,
		getList : getList,
		remove : remove,
		update : update
	};
})();

console.log(regService);