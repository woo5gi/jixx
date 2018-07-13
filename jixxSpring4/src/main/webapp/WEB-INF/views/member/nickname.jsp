<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/lheader.jsp" flush="false" />
<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="${pageContext.request.contextPath}">FILE CETACEA</a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">join in to start your session</p>
			<form action="<%=request.getContextPath()%>/sessionokinviterep.do" method="post" name="f" id="nicknameinsert">
				<div class="form-group has-feedback">
				<label>저장소 이름</label>
					<input type="text" class="form-control" readonly name="rep_name" required="required"
						value="${rep_name}"> <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
					<input type="hidden" name="rep_id" value="${rep_id}"> 
				</div>
				<div class="form-group has-feedback">
					<input type="text" class="form-control" placeholder="nickname" name="nickname" required="required" id="nickname">
					<span style="width: 34px;" class=" glyphicon-envelope form-control-feedback fa fa-fw fa-user"></span>
				</div>
				<div class="row">
					<!-- /.col -->
					<div class="col-xs-4">
						<button style="display: inline;" type="submit" class="btn btn-primary btn-block btn-flat" id="join">JOIN</button>
					</div>
					<!-- /.col -->
				</div>
			</form>


			<!-- /.social-auth-links -->


		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
</body>
</html>
