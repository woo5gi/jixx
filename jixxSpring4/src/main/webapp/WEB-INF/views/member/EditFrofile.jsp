<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />
<div class="content-wrapper" style="min-height: 863px;">
	<div class="container">
		<!-- Main content -->
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
										you in JIXX</label>
								</div>
							</div>
						</form>
						<br>

						<button type="submit" class="btn btn-primary btn-sm">Save</button>
					</div>
				</div>
			</div>
		</section>
		<!-- /.content -->
	</div>
	<!-- /.container -->
</div>

</body>
</html>