<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />
<script>
	$(function() {
		$('input[name=editprofile]').click(function() {
			$(location).attr('herf', "${pageContext.request.contextPath}/editprifle.do")
		})
	})
</script>
<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<!-- 		<h3 class="box-title">Frofile</h3> -->
			<img class="profile-user-img img-responsive img-circle" src="resources/images/logo.png"
				alt="User profile picture">
			<form action="${pageContext.request.contextPath}/editprofile.do?">
				<h3 class="profile-username text-center">이메일</h3>
				<p>${m.email}</p>
				

				<ul class="list-group list-group-unbordered">
					<li class="list-group-item"><b>이름</b>
						<p>${m.name}</p></li>
					<li class="list-group-item"><b>password</b>
						<p>
							<input type="password" name="pwd" value="${m.pwd}" readonly>
						</p></li>
					<li class="list-group-item">
						<p>
							<input type="submit" class="btn btn-primary" name="editprofile" value="정보수정">
						</p></li>
				</ul>
			</form>
		</div>
	</div>
</div>
</body>
</html>
