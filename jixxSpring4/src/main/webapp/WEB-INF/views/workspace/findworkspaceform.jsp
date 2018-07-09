<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />
<script type="text/javascript">
/* 	$(function() {
		alert('a');
		$('#search').on('click',function() {
			alert("a");
			var content = $('#searchvalue').val();
			if (content == '') {
				alert("내용을입력하세요");
			} else {
				$('#form').submit();
			}
		});
	}); */
</script>
<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<div class="register-box-body">

				<h2 class="headline text-black">
					<i class="fa fa-search"></i> &nbsp; Find Workspace
				</h2>
				<form class="search-form" id="form"
					action="${pageContext.request.contextPath}/findworkspace.do">
					<div class="input-group">

						<input type="text" name="search" class="form-control"
							placeholder="Find Workspace" id="searchvalue">

						<div class="input-group-btn">
							<button type="submit" name="submit" id="search"
								class="btn  btn-flat" style="padding:9.5px;">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>