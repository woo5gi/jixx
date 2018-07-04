<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		var email = $('#emailinput').val();
		if (email == "") {
			alert("아이디를입력하세요");
		} else {
			if (email.length <= 10) {
				alert("전체아이디를입력하세요")
			} else {
				sendRequest("<%=request.getContextPath()%>/idCheck.do?email=" + email + "&checkfrom=forgotpass", null, check_res1, "GET");

			}
		}
	}
	function check_res1() {
		if (httpRequest.readyState == 4) {
			if (httpRequest.status = 200) {
				var check_div = document.getElementById("check_div");
				check_div.innerHTML = httpRequest.responseText;
			}
		}
	}
	$(function() {
		$('#verify').click(function() {
			var idCheckResult = $('#check_div').text().trim();
			if (idCheckResult == "") {
				alert("아이디 체크 먼저 하세요")
			} else {
				if (idCheckResult == "존재하지 않는 아이디입니다 회원가입하세요") {
					alert("로그인창으로이동합니다")
					$(location).attr('href', "${pageContext.request.contextPath}/member/signup.do");
				} else {
					$('#insertform').submit();
				}
			}
		})
	})
</script>
<div class="bg">
  <div class="centered">
    <div class="box box-primary">
      <div class="box-header with-border">
        <h3 class="box-title">Find forgotten password</h3>
      </div>
      <form role="form" action="${pageContext.request.contextPath }/emailauth.do" method="post" class="form-horizontal" id="insertform">
        <div class="box-body">
          <div class="form-group">
            <label>Your email address</label>
              <input type="button" value="아이디체크" onclick="check()" class="btn bg-navy btn-flat margin" style="flat:right;">
              <input type="email" name="email" class="form-control"id="emailinput" placeholder="ex) xxxx@xx.xx"> 
              <input type="hidden" name="requestfrom" value="findpass">
          </div>
        </div>

        <div class="box-footer">
        	<div id="check_div"></div>
          <button type="button" class="btn btn-block btn-primary" id="verify">인증번호전송</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
