<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />

 <div class="bg">
  <div class="centered">
    <div class="box box-primary">
      <div class="box-header with-border">
        <h3 class="box-title">Check your email</h3>
      </div>

      <form role="form" action="${pageContext.request.contextPath }/verify.do"
							method="post">
        <div class="box-body">
          <div class="form-group">
            <label>Your confirmaiton code</label> 
            <input type="text" name="verify" placeholder="받은 인증번호를 입력해주세요"
										class="form-control">
          </div>
		</div>
        <div class="box-footer">
         <button type="submit" class="btn btn-primary btn-block">Submit</button>
        </div>
      </form>
    </div>
  </div>
</div>



<div class="content-wrapper">
	<div class="container">
		<!-- Main content -->
		<section class="content">
			<div class="col-lg-16">
				<div class="card">
					<div class="card-block">
						<h3>Check your email</h3>
						<br> <label class="control-label mb-1">Your
							confirmaiton code</label>
						<form action="${pageContext.request.contextPath }/verify.do"
							method="post">
							<div class="row form-group">
								<div class="col-5">
									<input type="text" name="verify" placeholder="받은 인증번호를 입력해주세요"
										class="form-control">
								</div>
							</div>
							<button type="submit" class="btn btn-primary btn-sm">Submit</button>
						</form>
						<br>

					</div>
				</div>
			</div>
		</section>
	</div>
</div>


</body>
</html>