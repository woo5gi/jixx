<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../template/header.jsp" flush="false" />
<script type="text/javascript">
	function isSame() {
		var pwd = $('#pwd').val();
		var pwd2 = $('#pwdcheck').val();
		var same = document.getElementById("same");
		if (pwd.length < 6 || pwd.length > 16) {
			window.alert("비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.");
			document.getElementById('same').innerHTML = '비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.';
		} else {
			if (pwd != "" && pwd2 != "") {
				if (pwd==pwd2) {
					same.innerHTML = "비밀번호가 일치합니다";
					same.style.color = 'blue';
				} else {
					same.innerHTML = "비밀번호가 일치하지 않습니다";
					same.style.color = "red";
				}
			}
		}
	}
	$(function(){
		$('#setpw').click(function(){
			var pwsame = $('#same').text().trim();
			if(pwsame=='비밀번호가 일치합니다'){
				$('#setpwform').submit();				
			}else{
				alert("비밀번호가 일치하지 않습니다");
			}
			return;
		})
	})
</script>
<%-- 
		<!-- Full Width Column -->
		<div class="content-wrapper" style="min-height: 863px;">
			<div class="container">
				<!-- Content Header (Page header) -->
				<section class="content-header"></section>


				<!-- Main content -->
				<section class="content">
					<div class="col-lg-16">
						<div class="card">
							<div class="card-body card-block">

								<h3>Set your New password</h3>
								<br> <label class="control-label mb-1"></label>
								<form action="<%=request.getContextPath()%>/setnewpass.do"
									method="post" class="" id="setpwform">
									<c:set var="email" value="${email}"/>
									<input type="hidden" name="email" value="${email}">									
									<div class="form-group">
										<div class="input-group">
											<div class="input-group-addon">Password</div>
											<input type="password" id="pwd" name="pwd"
												class="form-control" onchange="isSame()">
										</div>
										<div class="input-group">
											<div class="input-group-addon">Password Check</div>
											<input type="password" id="pwdcheck" name="password2"
												class="form-control" onchange="isSame()">
										</div>
										<span id="same"></span>
									</div>
								</form>
								<button type="button" class="btn btn-primary btn-sm" id="setpw">New
									Password Setting Done</button>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div> --%>
		
 <div class="bg">
  <div class="centered">
    <div class="box box-primary">
      <div class="box-header with-border">
        <h3 class="box-title">Set your New password</h3>
      </div>

      <form role="form" action="<%=request.getContextPath()%>/setnewpass.do"
									method="post" class="" id="setpwform">
        <div class="box-body">
          <div class="form-group">
            <label for="exampleInputEmail1">Password</label> 
            <div class="input-group">
			<div class="input-group-addon">Password</div>
			<input type="password" id="pwd" name="pwd"
				class="form-control" onchange="isSame()">
			</div>
          </div>
          
          <div class="form-group">
          <label for="exampleInputEmail1">Password Check</label> 
			<div class="input-group">
				<div class="input-group-addon">Password Check</div>
				<input type="password" id="pwdcheck" name="password2"
					class="form-control" onchange="isSame()">
			</div>
          </div>
          <span id="same"></span>

		</div>
        <div class="box-footer">
          <button type="button" class="btn btn-primary btn-block" id="setpw">
          New Password Setting Done</button>
        </div>
      </form>
    </div>
  </div>
</div>

</body>
</html>