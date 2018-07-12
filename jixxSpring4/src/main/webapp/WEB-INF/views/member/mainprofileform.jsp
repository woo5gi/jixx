<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/lheader.jsp" flush="false" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<style type="text/css">
.bg {
	min-height: 100%;
	background-color: #ecf0f5;
}
.centered1 {
    display: table;
    margin-left: auto;
    margin-right: auto;
    width: 450px;
    padding-top: 8%;
}

.listbox {
	overflow-y: scroll;
	height: 350px;
}

.callout {
	background-color: #001f3f;
}

.bg-navy {
	margin: 0px;
}
.btnlist {
	border-top-left-radius: 4px;
	border-top-right-radius: 4px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	background-color: #ffffff;
	padding: 7px 10px;
	border-bottom: 1px solid #f4f4f4;
	color: #444444;
	font-size: 14px;
}

.timelinebtn {
	display: inline;
	float: right;
}

.content-header {
	background: #fff;
	box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.15);
	clear: both;
	display: inline-block;
	padding: 15px 20px 13px 20px;
	width: 100%;
}

.skin-blue .content-header {
	background: #ffffff;
}

.cname {
	padding: 15px 15px;
	float: left;
	color: #fff;
	font-size: 17px;
	list-style: none;
}

#user-body1 {
	background: #e9e9e9;
}

.dropdown-menu {
	overflow-y: scroll;
	max-height: 500px;
}

.listyle {
	padding: 12px 5px 12px 15px;
	display: block;
}

.liscroll {
	overflow-y: auto;
	min-height: 44px;
	max-height: 132px;
}

::-webkit-scrollbar {
	width: 16px;
}

::-webkit-scrollbar-track {
	background-color: #222d32;
}

::-webkit-scrollbar-thumb {
	background-color: #555;
}

::-webkit-scrollbar-thumb:hover {
	background: #555;
}

::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment
	{
	width: 0px;
	height: 0px;
	background: #222d32;
}

.i1 {
	padding-right: 10px
}
.liscroll{
   overflow-y: auto; 
   min-height:58px; 
   max-height: 180px;
}
.listyle{
padding: 15px;
border-bottom: 1px solid #f4f4f4;
border-top: 1px solid #dddddd;
}
.listyle1{
padding: 15px;
}

.dropdown-menu>div>li>a{
    display: block;
    padding: 3px 20px;
    clear: both;
    font-weight: 400;
    line-height: 1.42857143;
    color: #333;
    white-space: nowrap;
}
.dropdown-menu{
overflow: hidden;}


input[type=button]{
border: none;
    border-radius: 3px;
    padding: 5 10;
    }
    
</style>

<script type="text/javascript">
	$(function() {
		$('input.deletech').on('click', function() {
			var channelname = $(this).prev('label.ch_name').text().trim();

			var ch_id = $(this).prev('input[name=ch_id]').val();
			var conresult = confirm("정말 삭제하시겠습니까.");
			if (conresult == true) {
				$(location).attr('href', "${pageContext.request.contextPath}/deletech.do?ch_id=" + ch_id);
			} else if (conresult == false) {
				return;
			}
		});
		$('#deleterep').click(function() {
			var rep_id = $('input[name=rep_id]').val();
			var conresult = confirm("저장소를 정말 삭제하시겠습니까.");
			if (conresult == true) {
				$('#deleterepform').submit();
			} else if (conresult == false) {
				return;
			}
		})
		$('.changeadminlevel').on('click', function() {
			var selectoption = $(this).parent().prev().children('select').val();
			var id = $(this).prev().prev('input[name=id]').val();
			var rep_id = $(this).prev('input[name=rep_id]').val();
			$(location).attr('href', "${pageContext.request.contextPath}/changeadminlevel.do?admin_level=" + selectoption + "&rep_id=" + rep_id + "&id=" + id);


		})
		$('#repout').on('click', function() {
			var conresult = confirm("저장소를 정말 탈퇴하시겠습니까.");
			if (conresult == true) {
				$(location).attr('href', "${pageContext.request.contextPath}/repout.do");
			} else if (conresult == false) {
				return;
			}

		})

	});
</script>


<body class="hold-transition skin-blue sidebar-mini">
	<c:set var="user_id" value="${id}" />
	<c:set var="rep_id" value="${rep_id}" />
	<c:set var="ch_list" value="${ch_list}" />
	<c:set var="user_list" value="${user_list}" />
	<c:set var="user_id" value="${id }" />
	<c:set var="email" value="${email}" />
	<c:set var="replist" value="${rep_list}" />
	<c:set var="user_name" value="${user_name}" />
	<c:set var="rep_name" value="${rep_name}" />
	<c:set var="ch" value="${ch}" />
	<c:set var="alarmtypelist" value="${alarmtypelist}" />
	<div class="wrapper">
		<!-- Main Header -->
		<header class="main-header"> <!-- Logo --> <a
			href="${pageContext.request.contextPath }/index.do" class="logo"><img
			src="${pageContext.request.contextPath }/resources/images/logo.png" alt="Logo"> </a> <!-- Header Navbar -->
		<nav class="navbar navbar-static-top" role="navigation"> <!-- <div><a href="#">채널</a></div> -->
		<li class="cname">${ch.ch_name}#</li>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- User Account Menu -->
				<c:choose>
					<c:when test="${user_id eq null}">
						<li class="dropdown user user-menu"><a class="dropdown-toggle"
							href="${pageContext.request.contextPath}/member/loginForm.do"> SIGN IN </a></li>
					</c:when>

					<c:otherwise>
						<li class="dropdown user user-menu"><a
							href="${pageContext.request.contextPath}/gomain.do?rep_id=${sessionScope.rep_id} "
							class="dropdown-toggle"> ${user_name}님 의 ${rep_name}저장소 </a></li>

						<c:choose>
							<c:when test="${empty replist}">
								<li class="dropdown user user-menu"><a class="dropdown-toggle" data-toggle="dropdown"
									aria-expanded="false"> <span class="hidden-xs">Create Workspace</span>
								</a>
									<ul class="dropdown-menu">
										<li class="user-header">
											<p>
												<a href="${pageContext.request.contextPath}/crw1.do"> <span class="hidden-xs"
													style="color: #fff;">Create New Workspace</span>
												</a>
											</p>
										</li>

										<li class="user-body" id="user-body1"><a
											href="${pageContext.request.contextPath}/findworkspaceform.do"
											class="hidden-xs text-center" aria-expanded="false">Find Workspace</a></li>
										<!-- Menu Footer-->
										<li class="user-footer">
											<div class="pull-left">
												<a href="#" class="btn btn-default btn-flat">Profile</a>
											</div>
											<div class="pull-right">
												<a href="${pageContext.request.contextPath}/member/logout.do"
													class="btn btn-default btn-flat">Sign out</a>
											</div>
										</li>
									</ul></li>
							</c:when>

							<c:otherwise>
								<li class="dropdown user user-menu" style=""><a
									href="${pageContext.request.contextPath}/gomain.do" class="dropdown-toggle"
									data-toggle="dropdown" aria-expanded="false"> <span class="hidden-xs">My
											Workspace</span>
								</a>
									<ul class="dropdown-menu">
										<li class="user-header">
											<p>WorkSpace List</p>
										<li class="user-body" id="user-body1"><a
											href="${pageContext.request.contextPath}/crw1.do" class="hidden-xs text-center">Create
												new Workspace</a></li>
												<div  class="liscroll">
										<c:forEach var="aa" items="${rep_list}">
											<li class="user-body listyle"><a
												href="${pageContext.request.contextPath}/gomain.do?rep_id=${aa.rep_id}"
												class="hidden-xs text-center">${aa.rep_name}</a></li>
										</c:forEach>
										</div>
										<!-- Menu Body -->
										<li class="user-body" id="user-body1"><a
											href="${pageContext.request.contextPath}/findworkspaceform.do"
											class="hidden-xs text-center">Find Workspace</a></li></li>

								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-left">
										<a href="${pageContext.request.contextPath}/profileform.do" class="btn btn-default ">Profile</a>
									</div> <c:choose>
										<c:when test="${adminlevel eq 1 }">
											<div class="pull-left">
												<a href="${pageContext.request.contextPath}/repadminform.do?adminlevel=1"
													class="btn btn-default btn-flat">저장소관리</a>
											</div>
										</c:when>
										<c:when test="${adminlevel eq 2 }">
											<div class="pull-left">
												<a href="${pageContext.request.contextPath}/repadminform.do?adminlevel=2"
													class="btn btn-default btn-flat">저장소관리</a>
											</div>
										</c:when>
										<c:otherwise>
											<div class="pull-left">
												<a href="${pageContext.request.contextPath}/repadminform.do?adminlevel=3"
													class="btn btn-default btn-flat">저장소관리</a>
											</div>
										</c:otherwise>
									</c:choose>
									<div class="pull-left">
										<a href="${pageContext.request.contextPath}/member/logout.do"
											class="btn btn-default btn-flat">Sign out</a>
									</div>
								</li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		</nav> 
		</header>


<div class="bg">
	<div class="centered1">
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
