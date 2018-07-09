<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../template/header.jsp" flush="false" />

<div class="bg">
	<div class="centered">
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3 class="box-title">profile</h3>
			</div>
			<div class="nav-tabs-custom">
				<div class="tab-pane active" id="settings">
					<form id="inputform" class="form-horizontal" action="${pageContext.request.contextPath}/member/editusermeta2.do">

						<div class="form-group">
							<label for="inputEmail" class="col-sm-2 control-label">Email</label>

							<div class="col-sm-10">
								<input type="email" class="form-control" name="email" id="inputEmail" placeholder="Email"
									value="${m.email}">
							</div>
						</div>

						<div class="form-group">
							<label for="inputName" class="col-sm-2 control-label">Name</label>

							<div class="col-sm-10">
								<input type="text" class="form-control" name="name" id="inputName" placeholder="Name" value="${m.name}">
						</div>
						</div>

						<div class="form-group">
							<label for="inputNickName" class="col-sm-2 control-label">NickName</label>

							<div class="col-sm-10">
								<input type="text" class="form-control" name="nickname" id="NickName" placeholder="NickName"
									value="${um2.nickname}">
							</div>
						</div>
						<input type="hidden" name="id" value="${sessionScope.id}">
						<input type="hidden" name="rep_id" value="${sessionScope.rep_id}">
											

						<div class="form-group">
							<label for="inputAuthority" class="col-sm-2 control-label">Authority</label>

							<div class="col-sm-10">
								<c:choose>
									<c:when test="${um2.admin_level eq 1}">
										<input type="text" class="form-control" id="inputAuthority" placeholder="Authority"
										value="일반사용자" readonly>
									</c:when>
									<c:when test="${um2.admin_level eq 2}">
										<input type="text" class="form-control" id="inputAuthority" placeholder="Authority"
										value="중간관리자" readonly>
									</c:when>
									<c:otherwise>
										<input type="text" class="form-control" id="inputAuthority" placeholder="Authority"
										value="저장소관리자" readonly>
									</c:otherwise>
									
								</c:choose>

							</div>
						</div>

					</form>

				</div>
			</div>

			<div class="box-footer">
				<button type="submit" class="btn btn-block btn-primary" form="inputform">Save</button>
			</div>
		</div>
	</div>
</div>

</body>
</html>
