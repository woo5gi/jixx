<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />
<script type="text/javascript">
	$(function() {
		$('#pwdchange').click(function() {
			$(location).attr('href', "${pageContext.request.contextPath}/member/forgotpass.do");
		})
		$('#memberout').click(function(){
			$(location).attr('href', "${pageContext.request.contextPath}/emailauth.do?requestfrom=memberout&email=${sessionScope.email}");
		})
	})
	
</script>

<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3 class="box-title">Edit Your Frofile</h3>
			</div>
			<form role="form" action="${pageContext.request.contextPath}/member/edit.do">
				<input type="hidden" name="id" value="${m.id}">
				<div class="box-body">
					<div class="form-group">
						<label>EMAIL ID</label> <input type="email" name="email" placeholder="" class="form-control"
							value="${m.email}">
					</div>
					<div class="form-group">
						<label>NAME</label> <input type="text" name="name" placeholder="" class="form-control"
							value="${m.name}">
					</div>
					<div class="form-group">
						<label>PASSWORD</label> <input type="password" name="pwd" placeholder="" class="form-control"
							value="${m.pwd}"><input type="button" id="pwdchange" class="btn btn-primary"
							value="비밀번호 재설정">
					</div>
					<label class="form-text text-muted">This could be your first name, or a nickname -
						however you'd like people to refer to you in FILE CETACEA</label>
				</div>
				<div class="box-footer">
					<button type="button" id="memberout" class="btn btn-primary" style="width: 50%">회원탈퇴</button>
					<button id="submit" class="btn  btn-primary" style="width: 49%">Save</button>
				</div>
				

<!-- 				<div class="box-footer">
					<button type="submit" class="btn btn-primary">Save</button>
				</div> -->
			</form>
			<!-- <input type="button" class="btn btn-primary" id="memberout" value="회원탈퇴"> -->
		</div>
	</div>
</div>



<!-- 
<div class="content-wrapper" style="min-height: 863px;">
	<div class="container">
		Main content
		<section class="content">
			<div class="col-lg-16">
				<div class="card">
					<div class="card-body card-block">
						<h3>Edit Your Frofile</h3>
						<br> <label class="form-text text-muted"></label>

						<form action="" method="post" class="form-horizontal">

							<div class="row form-group">
								<div class="col-5">
									<label class="control-label mb-1">Full Name</label> <input
										type="email" name="fullname" placeholder=""
										class="form-control"><br> <label
										class="control-label mb-1">Display name(optional)</label> <input
										type="email" name="displayname" placeholder=""
										class="form-control"><br> <label
										class="form-text text-muted">This could be your first
										name, or a nickname - however you'd like people to refer to
										you in FILE CETACEA</label>
								</div>
							</div>
						</form>
						<br>

						<button type="submit" class="btn btn-primary btn-sm">Save</button>
					</div>
				</div>
			</div>
		</section>
	</div>
</div> -->

</body>
</html>