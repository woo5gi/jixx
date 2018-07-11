<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />

<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3 class="box-title">Check your email</h3>
			</div>

			<form role="form" action="${pageContext.request.contextPath}/verify.do" method="post">
				<div class="box-body">
					<div class="form-group">
						<label>Your confirmaiton code</label> <input type="number" name="verify"
							placeholder="받은 인증번호를 입력해주세요" class="form-control">
							<input type="hidden" name="requestfrom" value="memberout">
					</div>
				</div>
				<div class="box-footer">
					<button type="submit" class="btn btn-primary btn-block">회원탈퇴 인증</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>