<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		$("#urlCheck").click(function() {
			$.post("repository/urlCheck.do", {
				url : $("#repurl").val()
			}).done(function(data) {
				$("#urlResult").text(data);
			});
		});
		$("#createws").click(function() {
			if ($("#urlResult").text().trim() == "사용가능") {
				$("form").submit();
			} else {
				alert("url 중복체크 먼저 하세요");
			}
			return;
		});
	});
</script>
<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3 class="box-title">Createworkspace</h3>
			</div>
			<form role="form"
				action="${pageContext.request.contextPath }/createrep.do"
				method="post">
				<div class="box-body">
					<div class="form-group">
							<label>What's your name?</label>
						<div class="input-group">
							<div class="input-group-addon">Display name</div>
							<input type="text" id="nickname" name="nickname"
								class="form-control" required="required">
						</div>
					</div>
					<div class="form-group">
							<label>What's your grop called?</label>
						<div class="input-group">
							<div class="input-group-addon">Grop name</div>
							<input type="text" name="rep_name" class="form-control"
								required="required">
						</div>
					</div>

					<div class="form-group">
						<div class="input-group">
							<label>What's URL do you want for your workspace?</label> <input
								type="text" id="repurl" name="rep_url" placeholder="ex)whale"
								 required="required"> <label
								class="control-label mb-1">.cetacea.com</label> <input
								type="button" id="urlCheck" value="url 중복체크"
								class="btn btn-primary btn-sm" style="margin-left:10px"> <br>
								<span style="padding:20px;" class="text-light-blue" id="urlResult"></span>
						</div>
					</div>

				</div>

				<div class="box-footer">
					<button type="button" class="btn btn-block btn-primary" id="createws">Create Workspace</button>
				</div>
			</form>
		</div>
	</div>
</div>

<%-- 
<div class="content-wrapper" style="min-height: 863px;">
	<div class="container">
		<section class="content-header"></section>
		<section class="content">
			<div class="col-lg-16">
				<div class="card">
					<div class="card">
						<form action="${pageContext.request.contextPath }/createrep.do"
							method="post" class="">
							<div class="card-body card-block">

								<h3>What's your name?</h3>
								<br> <label class="control-label mb-1">This is how
									your teammates in Slack will see and refer to you</label>

								<div class="form-group">
									<div class="input-group">
										<div class="input-group-addon">Display name</div>
										<input type="text" id="nickname" name="nickname"
											class="form-control" required="required">
											
									</div>
								</div>


							</div>
							<div class="card-body card-block">
								<h3>What's your grop called?</h3>
								<label class="control-label mb-1">Grop name</label>
								<div class="row form-group">
									<div class="col-5">
										<input type="text" name="rep_name" placeholder=""
											class="form-control" required="required">
									</div>
								</div>

								<label class="form-text text-muted">We'll use this to
									name your Slack workspace, which you can always change later.</label> <br>
							</div>
							<div class="card-body card-block">
								<h3>What's URL do you want for your Slack workspace?</h3>
								<br> <label class="form-text text-muted">Choose the
									address you'll use to sign in to Slack</label> <label
									class="control-label mb-1">Your workspace URL</label>

								<div class="row form-group">
									<div class="col-3">
										<input type="text" id="repurl" name="rep_url" placeholder=""
											class="form-control" required="required">
									</div>
									<label class="control-label mb-1">.jixx.com</label>
								</div>
								<input type="button" id="urlCheck" value="url 중복체크"
									class="btn btn-primary btn-sm"> <span id="urlResult"></span>
								<button type="button" class="btn btn-primary btn-sm"
									id="createws">Create Workspace</button>
							</div>
						</form>
					</div>
		</section>
	</div>
</div> --%>
</body>
</html>