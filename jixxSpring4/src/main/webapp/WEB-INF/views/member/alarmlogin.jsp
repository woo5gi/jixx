<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../template/lheader.jsp" flush="false" />
<body class="hold-transition login-page">
  <div class="login-box">
    <div class="login-logo">
      <a href="<%=request.getContextPath()%>/index.do">FILE CETACEA</a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
      <p class="login-box-msg">JOIN FILE CETACEA</p>

      <form action="<%=request.getContextPath()%>/alarmgomain.do" method="post" id="alarmlogin" onsubmit="return false;">
      	<input type="hidden" name="rep_id" value="${rep_id }">
      	<input type="hidden" name="cn" value="${cn }">
        <div class="form-group has-feedback">
          <input type="email" class="form-control" placeholder="Email" name="email" required="required" id="alarmemail">
          <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
          <input type="password" class="form-control" placeholder="Password" name="pwd" required="required" id="alarmpwd">
          <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="row">
          <div class="col-xs-8">
            <div class="checkbox icheck">
            </div>
          </div>
          <!-- /.col -->
          <div class="col-xs-4">
            <button type="submit" class="btn btn-primary btn-block btn-flat" onclick="alarmlogincheck()">Sign In</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
      <a href="${pageContext.request.contextPath }/member/forgotpass.do" class="text-center">I forgot my password</a><p>&nbsp;&nbsp;</p>
      <a href="${pageContext.request.contextPath }/member/signup.do" class="text-center">Register a new membership</a>

    </div>
    <!-- /.login-box-body -->
  </div>
  <!-- /.login-box -->
  <script>
  function alarmlogincheck(){
		var email = $('#alarmemail').val();
		var pwd = $('#alarmpwd').val();
		 $.ajax({
	           type : "post",
	           url : "<%=request.getContextPath()%>/member/logincheck.do",
	           data : { email: email, pwd: pwd },
	           dataType : "text",
	           success : function(data){
	        	  if (data == "성공") {
					$("#alarmlogin").removeAttr("onsubmit");
					$('#alarmlogin').submit();
				}
	        	  }
	           });
		 return false;
	}
  </script>


</body>
</html>
