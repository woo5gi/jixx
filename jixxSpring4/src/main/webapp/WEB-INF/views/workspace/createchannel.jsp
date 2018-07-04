<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		$('.userlist').click(function() {
			/* 닉네임버튼누르면
			input태그 안에 value로 들어가게하고,a태그삭제한다.
			 */

			var user = $('.userlist').text().trim();
			$('#invite').val(user);

		})
	});
</script>

<div class="content-wrapper" style="min-height: 863px;">
	<div class="container">
		<section class="content-header"></section>
		<section class="content">
			<div class="col-lg-16">
				<div class="card">
					<div class="card-body card-block">
						<h3>Create a channel</h3>
						<br>
						<label class="form-text text-muted">Channels are where your members communicate.
							They're best when organized around a topic-#leads,for example</label>
						<form action="${pageContext.request.contextPath}/addchannel.do" method="post"
							class="form-horizontal" id="form">
							<label class="switch switch-3d switch-warning mr-3"><input type="checkbox"
								class="switch-input" name="chtype"> <span class="switch-label"></span><span
								class="switch-handle"></span></label> <label class="text-muted">private</label>
							<br>
							<br>

							<div class="row form-group">
								<div class="col-5">
									<label class="control-label mb-1">name</label> <input type="text" name="chtitle"
										placeholder="e.g.leads" class="form-control">
									<br>
									<label class="control-label mb-1">Send invates to:(optional)</label>
									<br>
									<input type="text" name="invate" id="invite" placeholder="Search by name"
										class="form-control">
									<c:forEach var="r" items="${usernamelist}" varStatus="status">
										<a class="userlist" id="user${status.count}">${r}</a>
									</c:forEach>

								</div>
							</div>
						</form>
						<br>

						<button type="reset" class="btn btn-primary btn-sm">Cancle</button>
						<button type="submit" form="form" class="btn btn-primary btn-sm">Create Channel</button>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>
</body>
</html>