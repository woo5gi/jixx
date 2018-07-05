<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						"<li class='adddedemail'><input type='email' name='address' placeholder='name@example.com' class='form-control'><button id ='mbtn' type='button' class='btn btn-primary btn-sm' name='delete'><i class='fa fa-fw fa-minus-square'></i></li><br>");
			
	$('button[type=button]').on('click', function() {
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
width:325px;
float: left;
margin-bottom: 10px;
}
#mbtn{

float: right;
margin: 5px;
padding:4px;
}

</style>

<div class="bg">
	<div class="centered">
	
	<div class="alert alert-success alert-dismissible">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
               <c:set var="r" value="${r }" />
                <h4><i class="icon fa fa-check"></i>${r.rep_name}저장소생성완료!</h4>
               		저장소가 생성되었습니다.
              </div>
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
						<button type="button" id="addemail" class="btn btn-primary btn-sm" style="float: right;margin: 5px;padding: 4px;"><i class="fa fa-fw fa-plus-square"></i></button>
						<div id="emailinput" class="col-5">
							<ul id="input">
								<li><input type="email" name="address" placeholder="name@example.com"
									class="form-control" ></li>
								<br>
							</ul>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<button id="skip" class="btn  btn-primary"
						onclick="location.href='${pageContext.request.contextPath }/gomain.do?rep_id=${r.rep_id}" style="width: 49%">Skip
						For Now</button>
					<button type="submit" form="emailinput" class="btn  btn-primary" style="width: 50%">Send
						Invitations</button>
				</div>
			</form>
	</div>
	</div>
	</div>
	
</body>
</html>