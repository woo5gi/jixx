<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/header.jsp" flush="false" />
<!-- ADD THE CLASS layout-top-nav TO REMOVE THE SIDEBAR. -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document)
			.ready(
					function() {
						$("#addemail")
								.click(
										function() {
											$('ul#input')
													.append(
															"<li><input type='email' name='address' placeholder='name@example.com' class='form-control' required='required'></li>");
										});
						$("#deleteemail").click(function() {
							$('ul#input').children("li").remove();
						});
					});
</script>

<div class="content-wrapper" style="min-height: 863px;">
	<div class="container">
		<!-- Content Header (Page header) -->
		<section class="content-header"></section>


		<!-- Main content -->
		<section class="content">
			<div class="col-lg-16">
				<div class="card">
					<div class="card-body card-block">
						<c:set var="r" value="${r }" />
						<h4>${r.rep_name}저장소생성완료</h4>
						<h3>Send Invitations</h3>
						<br> <label class="form-text text-muted">All set!
							You'Anybody else you'd like to invate?</label> <label
							class="control-label mb-1">Email address</label>
						<form action="${pageContext.request.contextPath}/sendinvite.do"
							id="emailinput" method="post" class="form-horizontal">
							<div class="row form-group">
								<input type="hidden" name="rep_name" value="${r.rep_name}">
								<input type="hidden" name="invitest" value="0">
								<button type="button" id="addemail"
									class="btn btn-primary btn-sm">more invitation</button>
								<button type="button" id="deleteemail"
									class="btn btn-primary btn-sm">cancel invitation</button>
								<div id="emailinput" class="col-5">
									<ul id="input">
										<li><input type="email" name="address"
											placeholder="name@example.com" class="form-control"
											required="required"></li>
									</ul>
								</div>
							</div>
						</form>
						<br>

						<button id="skip" class="btn btn-primary btn-sm"
							onclick="location.href='${pageContext.request.contextPath }/gomain.do?rep_id=${r.rep_id}'">Skip
							For Now</button>
						<button type="submit" form="emailinput"
							class="btn btn-primary btn-sm">Send Invitations</button>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>

</body>
</html>