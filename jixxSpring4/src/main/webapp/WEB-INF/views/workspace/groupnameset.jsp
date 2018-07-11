<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />

<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3 class="box-title">What's your grop called?</h3>
			</div>

			<form role="form">
				<div class="box-body">
					<div class="form-group">
						<label>Grop name</label> <input type="text" name="Gropname" class="form-control">
					</div>
				</div>
				<label class="form-text text-muted">We'll use this to name
					your Slack workspace, which you can always change later.</label>
				<div class="box-footer">
					<button type="submit" class="btn btn-primary btn-block">Continue
						to Workspace URL</button>
				</div>
			</form>
		</div>
	</div>
</div>


</body>
</html>