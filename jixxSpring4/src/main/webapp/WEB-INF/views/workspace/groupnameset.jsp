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
            <label >Grop name</label> 
				<input type="text" name="Gropname" placeholder=""
					class="form-control">
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



<!-- <div class="content-wrapper" style="min-height: 863px;">
	<div class="container">
		Content Header (Page header)
		<section class="content-header"></section>


		Main content
		<section class="content">
			<div class="col-lg-16">
				<div class="card">
					<div class="card-body card-block">
						<h3>What's your grop called?</h3>
						<br> <label class="control-label mb-1">Grop name</label>
						<form action="" method="post" class="form-horizontal">
							<div class="row form-group">
								<div class="col-5">
									<input type="text" name="Gropname" placeholder=""
										class="form-control">
								</div>
							</div>
						</form>
						<label class="form-text text-muted">We'll use this to name
							your Slack workspace, which you can always change later.</label> <br>
						<button type="submit" class="btn btn-primary btn-sm">Continue
							to Workspace URL â</button>
					</div>
				</div>
			</div>
		</section>
	</div>
</div> -->

</body>
</html>