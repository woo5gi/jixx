<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/header.jsp" flush="false" />
<script type="text/javascript">
	function getXMLHttpRequest() {
		if (window.ActiveXObject) {
			try {
				return new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					return new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e1) {
					return null;
				}
			}
		} else if (window.XMLHttpRequest) {
			return new XMLHttpRequest();
		} else {
			return null;
		}
	}
	var httpRequest = null;

	function sendRequest(url, params, callback, method) {
		httpRequest = getXMLHttpRequest();
		var httpMethod = method ? method : 'GET';
		if (httpMethod != 'GET' && httpMethod != 'POST') {
			httpMethod = 'GET';
		}
		var httpParams = (params == null || params == '') ? null : params;
		var httpUrl = url;
		if (httpMethod == 'GET' && httpParams != null) {
			httpUrl = httpUrl + "?" + httpParams;
		}
		httpRequest.open(httpMethod, httpUrl, true);
		httpRequest.setRequestHeader(
			'Content-Type', 'application/x-www-form-urlencoded');
		httpRequest.onreadystatechange = callback;
		httpRequest.send(httpMethod == 'POST' ? httpParams : null);
	}

	function check() {
		var email = $('input#emailinput').val();	
		if (email == "") {
			alert("아이디를입력하세요");
		} else {
			if(email.length<=10){
				alert("전체아이디를입력하세요")
			}else{
			sendRequest("<%=request.getContextPath()%>/idCheck.do?email=" + f.email.value+"&checkfrom=invitesignup", null, check_res, "GET");
			}
			
		}
	}

	function check_res() {
		if (httpRequest.readyState == 4) {
			if (httpRequest.status = 200) {
				var check_div = document.getElementById("check_div");
				check_div.innerHTML = httpRequest.responseText;
			}else{
				alert("시스템오류")
			}
			return;
		}
	}
	$(function() {
		$('#join').click(function() {
			var idCheckResult = $('#check_div').text().trim();
			if (idCheckResult == "") {
				alert("id중복확인 해주세요")
			} else {
				if (idCheckResult == "사용불가능한 아이디") {
					alert("다른 id를 입력하세요");
				} else {
					var email =$('#emailinput').val();
					var pwd =$('#pwd').val();
					var name =$('#name').val();				
					var nickname =$('#nickname').val();
					if (email !="" && pwd!= "" && name != "" && nickname !="") {
						$('#insertform').submit();
					} else {
						alert("칸을 모두채우세요")						
					}
					return;
				}
			}			
		});
	});
</script>
<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="${pageContext.request.contextPath}">Spring<b>JIXX</b></a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">Sign in to start your session</p>
			<c:set var="rep_name" value="${rep_name}" />
			<c:set var="rep_id" value="${rep_id}" />
			<form action="<%=request.getContextPath()%>/inviteinsert.do" method="post" name="f" id="insertform">
				<div class="form-group has-feedback">
				<label>저장소 이름</label>
					<input type="text" class="form-control" readonly name="rep_name" required="required"
						value="${rep_name}"> <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
					<input type="hidden" name="rep_id" value="${rep_id}"> 
				</div>
				<div class="form-group has-feedback">
					<input type="email" class="form-control" placeholder="Email" name="email" required="required"
						id="emailinput"> <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
				</div>
				<div>
					<input type="button" value="중복체크" onclick="check()" class="btn btn-primary btn-block btn-flat">
				</div>
				<div id="check_div"></div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control" placeholder="Password" name="pwd" id="pwd"
						required="required"> <span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="text" class="form-control" placeholder="name" name="name" required="required" id="name">
					<span style="width: 34px;" class=" glyphicon-envelope form-control-feedback fa fa-fw fa-user"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="text" class="form-control" placeholder="nickname" name="nickname" required="required" id="nickname">
					<span style="width: 34px;" class=" glyphicon-envelope form-control-feedback fa fa-fw fa-user"></span>
				</div>
				<div class="row">
					<div class="col-xs-8">
						<div class="checkbox icheck"></div>
					</div>
					<!-- /.col -->
					<div class="col-xs-4">
						<button style="display: inline;" type="button" class="btn btn-primary btn-block btn-flat" id="join">JOIN</button>
						<input type="button" id="cancel" value="취소" class="btn btn-primary btn-block btn-flat"
							onclick="location.href='${pageContext.request.contextPath }/member/loginForm.do'" />
					</div>
					<!-- /.col -->
				</div>
			</form>


			<!-- /.social-auth-links -->


		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
	<script>
		$(function() {
			$('input').iCheck({
				checkboxClass : 'icheckbox_square-blue',
				radioClass : 'iradio_square-blue',
				increaseArea : '20%' /* optional */
			});
		});
	</script>



</body>
</html>
