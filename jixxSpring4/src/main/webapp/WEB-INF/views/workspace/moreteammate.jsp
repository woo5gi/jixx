<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/header.jsp" flush="false" />
<!-- ADD THE CLASS layout-top-nav TO REMOVE THE SIDEBAR. -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function() {
		$("#addemail")
			.click(
				function() {
					$('ul#input')
						.append(
							"<li class='adddedemail'><input type='email' name='address' placeholder='name@example.com' class='form-control' required='required'><input type='button' class='fa fa-fw fa-minus-square' name='delete'><i class='fa fa-fw fa-minus-square'></i></li><br>");
				
		$('input[type=button]').on('click', function() {
	        $(this).parent('li.adddedemail').next().remove(); // remove the <br>
			$(this).parent('li.adddedemail').remove();
			});
		});
	});

	
</script>

<style>
li{
list-style-type:none;
}
.form-control {
width:250px;
</style>
<i class="fa fa-fw fa-minus-square"></i>
<i class="fa fa-fw fa-plus-square"></i>
<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<div class="box-header with-border">
				<c:set var="r" value="${r}" />
				<h3 class="box-title">${r.rep_name}저장소로초대</h3>
			</div>

			<form role="form" action="${pageContext.request.contextPath}/sendinvite.do" id="emailinput"
				method="post" class="form-horizontal">
				<div class="box-body">
					<div class="form-group">

						<label class="form-text text-muted"> You'Anybody else you'd like to invate?</label> <label
							class="control-label mb-1">Email address</label> <input type="hidden" name="rep_name"
							value="${r.rep_name}"> <input type="hidden" name="invitest" value="1">
						<button type="button" id="addemail" class="btn btn-primary btn-sm"><i class="fa fa-fw fa-plus-square"></i></button>
						<div id="emailinput" class="col-5">
							<ul id="input">
								<li><input type="email" name="address" placeholder="name@example.com"
									class="form-control" required="required"></li>
								<br>
							</ul>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<button id="skip" class="btn  btn-primary"
						onclick="location.href='${pageContext.request.contextPath }/gomain.do'" style="width: 49%">Skip
						For Now</button>
					<button type="submit" form="emailinput" class="btn  btn-primary" style="width: 50%">Send
						Invitations</button>
				</div>
			</form>
		</div>
	</div>
</div>


<%-- 
<!-- Full Width Column -->
<div class="content-wrapper" style="min-height: 863px;">
	<div class="container">
		<!-- Main content -->
		<section class="content">
			<div class="col-lg-16">
				<div class="card">
					<div class="card-body card-block">
						<c:set var="r" value="${r}" />
						<h4>${r.rep_name}저장소로초대</h4>
						<h3>Send Invitations</h3>
						<br> <label class="form-text text-muted"> You'Anybody
							else you'd like to invate?</label> <label class="control-label mb-1">Email
							address</label>
						<form action="${pageContext.request.contextPath}/sendinvite.do"
							id="emailinput" method="post" class="form-horizontal">
							<div class="row form-group">
								<input type="hidden" name="rep_name" value="${r.rep_name}">
								<input type="hidden" name="invitest" value="1">
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
							onclick="location.href='${pageContext.request.contextPath }/gomain.do'">Skip
							For Now</button>
						<button type="submit" form="emailinput"
							class="btn btn-primary btn-sm">Send Invitations</button>
					</div>
				</div>
			</div>
		</section>
	</div>
</div> --%>
</body>
</html>