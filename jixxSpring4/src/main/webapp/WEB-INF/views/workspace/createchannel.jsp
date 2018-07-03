<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	
});
</script>

<!-- ADD THE CLASS layout-top-nav TO REMOVE THE SIDEBAR. -->
<body class="skin-blue layout-top-nav" style="height: auto; min-height: 100%;">
	<div class="wrapper" style="height: auto; min-height: 100%;">

		<header class="main-header">
			<nav class="navbar navbar-static-top">
				<div class="container">
					<div class="navbar-header">
						<a href="../../index2.html" class="navbar-brand">Spring<b>JIXX</b></a>
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
							data-target="#navbar-collapse">
							<i class="fa fa-bars"></i>
						</button>
					</div>

					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse pull-left" id="navbar-collapse"></div>
					<!-- /.navbar-collapse -->
					<!-- Navbar Right Menu -->
					<div class="navbar-custom-menu">
						<ul class="nav navbar-nav">
							<!-- Messages: style can be found in dropdown.less-->

							<!-- /.messages-menu -->

							<!-- Notifications Menu -->



							<!-- User Account Menu -->
							<li class="dropdown user user-menu">
								<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle" data-toggle="dropdown"
								aria-expanded="false"> <!-- The user image in the navbar--> <!-- hidden-xs hides the username on small devices so only the image appears. -->
									<span class="hidden-xs">Create Workspace</span>
							</a>
								<ul class="dropdown-menu">
									<!-- The user image in the menu -->
									<li class="user-header">


										<p>
											ë¡ê·¸ì¸ëìí¬ì¤íì´ì¤<small>Member since Nov. 2012</small>
										</p>
									</li>
									<!-- Menu Body -->
									<li class="user-body">
										<div class="row">
											<div class="col-xs11 text-center">
												<a href="#"> Sign Into Another Workspace</a>
											</div>


										</div> <!-- /.row -->
									</li>
									<!-- Menu Footer-->
									<li class="user-footer">
										<div class="pull-left">
											<a href="#" class="btn btn-default btn-flat">Profile</a>
										</div>
										<div class="pull-right">
											<a href="#" class="btn btn-default btn-flat">Sign out</a>
										</div>
									</li>
								</ul>
							</li>
						</ul>
					</div>
					<!-- /.navbar-custom-menu -->
				</div>
				<!-- /.container-fluid -->
			</nav>
		</header>
		<!-- Full Width Column -->
		<div class="content-wrapper" style="min-height: 863px;">
			<div class="container">
				<!-- Content Header (Page header) -->
				<section class="content-header"></section>


				<!-- Main content -->
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
											<input type="text" name="invate" placeholder="Search by name" class="form-control">
											<c:forEach var="r" items="${usernamelist}">
											<a class="userinvite" name="userlist">${r}</a>											
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
				<!-- /.content -->
			</div>
			<!-- /.container -->
		</div>
		<!-- /.content-wrapper -->
		<footer class="main-footer">
			<div class="container">
				<div class="pull-right hidden-xs">
					<b>Version</b> 2.4.0
				</div>
				<strong>Copyright Â© 2014-2016 <a href="https://adminlte.io">Almsaeed Studio</a>.
				</strong> All rights reserved.
			</div>
			<!-- /.container -->
		</footer>
	</div>
	<!-- ./wrapper -->

</body>
</html>