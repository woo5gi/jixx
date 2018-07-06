<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />

<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3 class="box-title">Frofile</h3>
			</div>
			<div class="nav-tabs-custom">
				<div class="tab-pane active" id="settings">
					<form class="form-horizontal">

						<div class="form-group">
							<label for="inputEmail" class="col-sm-2 control-label">Email</label>

							<div class="col-sm-10">
								<input type="email" class="form-control" id="inputEmail"
									placeholder="Email">
							</div>
						</div>

						<div class="form-group">
							<label for="inputName" class="col-sm-2 control-label">Name</label>

							<div class="col-sm-10">
								<input type="email" class="form-control" id="inputName"
									placeholder="Name">
							</div>
						</div>

						<div class="form-group">
							<label for="inputNickName" class="col-sm-2 control-label">NickName</label>

							<div class="col-sm-10">
								<input type="text" class="form-control" id="NickName"
									placeholder="NickName">
							</div>
						</div>

						<div class="form-group">
							<label for="inputAuthority" class="col-sm-2 control-label">Authority</label>

							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputAuthority"
									placeholder="Authority">
							</div>
						</div>						

					</form>

				</div>
			</div>

			<div class="box-footer">
				<button type="submit" class="btn btn-block btn-primary">Save</button>
			</div>
		</div>
	</div>
</div>

</body>
</html>
