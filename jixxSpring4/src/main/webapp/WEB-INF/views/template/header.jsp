<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="text/html; charset=UTF-8">
<title>FILE CETACEA</title>
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
   folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/dist/css/skins/_all-skins.min.css">
<!-- Morris chart -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bower_components/morris.js/morris.css">
<!-- jvectormap -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bower_components/jvectormap/jquery-jvectormap.css">
<!-- Date Picker -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
<!-- Daterange picker -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bower_components/bootstrap-daterangepicker/daterangepicker.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

<!-- jQuery 3 -->
<script src="<%=request.getContextPath()%>/resources/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script
	src="<%=request.getContextPath()%>/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- SlimScroll -->
<script
	src="<%=request.getContextPath()%>/resources/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="<%=request.getContextPath()%>/resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/resources/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="<%=request.getContextPath()%>/resources/dist/js/demo.js"></script>
<style>
/* .card-block {
	background: #ffff;
	padding: 50px;
	margin-left: 20%;
	margin-right: 20%;
	margin-top: 5%;
} */
.centered {
	display: table;
	margin-left: auto;
	margin-right: auto;
	width: 450px;
	padding-top: 13%;
}

.bg {
	min-height: 100%;
	background-color: #ecf0f5;
}
    #user-body1{
    background: #e9e9e9;
    }
    .dropdown-menu{
    overflow-y: scroll;
    max-height: 500px;
    
    }
    
    
</style>

</head>
<body class="skin-blue layout-top-nav" style="height: auto; min-height: 100%;">
	<c:set var="user_id" value="${id }" />
	<c:set var="email" value="${email}" />
	<c:set var="replist" value="${rep_list}" />
	<c:set var="user_name" value="${user_name}" />
	<header class="main-header">
		<nav class="navbar navbar-static-top">
			<div class="container">
				<div class="navbar-header">
					<a href="${pageContext.request.contextPath }/index.do" class="logo"><img
						src="resources/images/logo.png" alt="Logo"> </a>
				</div>
				<div class="collapse navbar-collapse pull-left" id="navbar-collapse"></div>
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<c:choose>
							<c:when test="${user_id eq null}">
								<li class="dropdown user user-menu"><a class="dropdown-toggle"
									href="${pageContext.request.contextPath}/member/loginForm.do"> SIGN IN </a></li>
							</c:when>

							<c:otherwise>
								<li class="dropdown user user-menu"><a class="dropdown-toggle"> ${user_name}님
										환영합니다 </a></li>

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

												<li class="user-body" id="user-body1">
															<a href="${pageContext.request.contextPath}/findworkspaceform.do" class="hidden-xs text-center"
																aria-expanded="false">Find Workspace</a>
												</li>
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
											<ul class="dropdown-menu" >
												<li class="user-header">
													<p>WorkSpace List</p>

												<li class="user-body" id="user-body1">
												<a href="${pageContext.request.contextPath}/crw1.do" class="hidden-xs text-center">Create new Workspace</a>
												</li>
												<c:forEach var="aa" items="${rep_list}">
														<li class="user-body">
														<a href="${pageContext.request.contextPath}/gomain.do?rep_id=${aa.rep_id}"
															class="hidden-xs text-center">${aa.rep_name}</a></li>
													</c:forEach> <!-- Menu Body -->
												<li class="user-body" id="user-body1">
												<a href="${pageContext.request.contextPath}/findworkspaceform.do" class="hidden-xs text-center">Find Workspace</a>
												</li>
													
												</li>
												<!-- Menu Footer-->
												<li class="user-footer">
													<div class="pull-left">
														<a href="${pageContext.request.contextPath}/profileform.do"
															class="btn btn-default btn-flat">Profile</a>
													</div>
													
														
													<div class="pull-right">
														<a href="${pageContext.request.contextPath}/member/logout.do"
															class="btn btn-default btn-flat">Sign out</a>
													</div>
												</li>
												
											</ul>
											</li>
									</c:otherwise>

								</c:choose>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>
	</header>