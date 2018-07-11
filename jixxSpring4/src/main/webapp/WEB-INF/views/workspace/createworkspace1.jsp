<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../template/header.jsp" flush="false"/>

<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3 class="box-title">Create a new workspace</h3>
			</div>
			<form role="form"
				action="${pageContext.request.contextPath }/emailauth.do"
				method="post" class="form-horizontal">
				<div class="box-body">
					<div class="form-group">
						<label>Your email address</label>
						<c:set var="m" value="${m}" />
						<input type="text" name="email"class="form-control" value="${m.email}" readonly> 
						<input type="hidden" name="requestfrom" value="createws">
					</div>
				</div>
				<div class="box-footer">
					<button type="submit" class="btn btn-block btn-primary">인증번호전송</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>