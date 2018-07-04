<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="mainHeader.jsp" flush="false" />
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
	<div class="wrapper">
		<!-- Main Header -->
		<header class="main-header">

			<!-- Logo -->
			<a href="${pageContext.request.contextPath }/index.do" class="logo"><img
				src="${pageContext.request.contextPath }/resources/images/logo.png" alt="Logo"> </a>

			<!-- Header Navbar -->
			<nav class="navbar navbar-static-top" role="navigation">
				<!-- <div><a href="#">채널</a></div> -->
				<li class="cname">${ch.ch_name}#</li>
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- Messages: style can be found in dropdown.less-->
						<li class="dropdown messages-menu">
							<!-- Menu toggle button --> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-envelope-o"></i> <span class="label label-success">4</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 4 messages</li>
								<li>
									<!-- inner menu: contains the messages -->
									<ul class="menu">
										<li>
											<!-- start message --> <a href="#">
												<div class="pull-left">
													<!-- User Image -->
													<img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
												</div> <!-- Message title and timestamp -->
												<h4>
													Support Team <small><i class="fa fa-clock-o"></i> 5 mins</small>
												</h4> <!-- The message -->
												<p>Why not buy a new awesome theme?</p>
										</a>
										</li>
										<!-- end message -->
									</ul> <!-- /.menu -->
								</li>
								<li class="footer"><a href="#">See All Messages</a></li>
							</ul>
						</li>
						<!-- /.messages-menu -->

						<!-- Notifications Menu -->
						<li class="dropdown notifications-menu">
							<!-- Menu toggle button --> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-bell-o"></i> <span class="label label-warning">10</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 10 notifications</li>
								<li>
									<!-- Inner Menu: contains the notifications -->
									<ul class="menu">
										<li>
											<!-- start notification --> <a href="#"> <i class="fa fa-users text-aqua"></i> 5 new
												members joined today
										</a>
										</li>
										<!-- end notification -->
									</ul>
								</li>
								<li class="footer"><a href="#">View all</a></li>
							</ul>
						</li>
						<!-- Tasks Menu -->
						<li class="dropdown tasks-menu">
							<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-flag-o"></i> <span class="label label-danger">9</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 9 tasks</li>
								<li>
									<!-- Inner menu: contains the tasks -->
									<ul class="menu">
										<li>
											<!-- Task item --> <a href="#"> <!-- Task title and progress text -->
												<h3>
													Design some buttons <small class="pull-right">20%</small>
												</h3> <!-- The progress bar -->
												<div class="progress xs">
													<!-- Change the css width attribute to simulate progress -->
													<div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar"
														aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">20% Complete</span>
													</div>
												</div>										</a>
										</li>
										<!-- end task item -->
									</ul>
								</li>
								<li class="footer"><a href="#">View all tasks</a></li>
							</ul>
						</li>
						<!-- User Account Menu -->
						<c:choose>
							<c:when test="${empty replist}">
								<li class="dropdown user user-menu"><a
									class="dropdown-toggle" data-toggle="dropdown"
									aria-expanded="false"> <span class="hidden-xs">Create
											Workspace</span>
								</a>
									<ul class="dropdown-menu">
										<li class="user-header">
											<p>
												<a href="${pageContext.request.contextPath}/crw1.do"> <span
													class="hidden-xs" style="color: #fff;">Create New
														Workspace</span>
												</a>
											</p>
										</li>

										<li class="user-body">
											<div class="row">
												<div class="col-xs11 text-center">
													<a href="${pageContext.request.contextPath}/crw1.do">
														<span class="hidden-xs">Find Workspace</span>
													</a>
												</div>
											</div>
										</li>
										<!-- Menu Footer-->
										<li class="user-footer">
											<div class="pull-left">
												<a href="#" class="btn btn-default btn-flat">Profile</a>
											</div>
											<div class="pull-right">
												<a
													href="${pageContext.request.contextPath}/member/logout.do"
													class="btn btn-default btn-flat">Sign out</a>
											</div>
										</li>
									</ul></li>
							</c:when>

							<c:otherwise>
								<li class="dropdown user user-menu"><a
									href="${pageContext.request.contextPath}/gomain.do"
									class="dropdown-toggle" data-toggle="dropdown"
									aria-expanded="false"> <span class="hidden-xs">My
											Workspace</span>
								</a>
									<ul class="dropdown-menu">
										<li class="user-header">
											<p>WorkSpace List</p> <c:forEach var="aa" items="${rep_list}">

												<li class="user-body"><a
													href="${pageContext.request.contextPath}/gomain.do?rep_id=${aa.rep_id}"
													class="hidden-xs text-center">${aa.rep_name}</a></li>

											</c:forEach> <!-- Menu Body -->
										</li>
										<li class="user-body" style="overflow-y: scroll;">
											<div class="row">
												<div class="col-xs11 text-center">
													<a href="${pageContext.request.contextPath}/crw1.do"
														aria-expanded="false"> <span class="hidden-xs">Create
															new Workspace</span>
													</a>
												</div>
											</div>
										</li>

										<!-- Menu Footer-->
										<li class="user-footer">
											<div class="pull-left">
												<a href="${pageContext.request.contextPath}/profileform.do"
													class="btn btn-default btn-flat">Profile</a>
											</div>
											<div class="pull-right">
												<a
													href="${pageContext.request.contextPath}/member/logout.do"
													class="btn btn-default btn-flat">Sign out</a>
											</div>
										</li>
									</ul></li>
							</c:otherwise>

						</c:choose>
					</ul>
				</div>
			</nav>
		</header>
		
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">

			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">

				<!-- Sidebar user panel (optional) -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
					</div>
					<div class="pull-left info">
						<p>${sessionScope.nickname}</p>
						<!-- Status -->
						<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
					</div>
				</div>

				<ul class="sidebar-menu" data-widget="tree">
					<li class="header"><a href="index.html"> <i class="fa fa-sun-o"></i>All Threads
					</a></li>
				</ul>

				<!-- search form (Optional) -->
				<form action="#" method="get" class="sidebar-form">
					<div class="input-group">
						<input type="text" name="q" class="form-control" placeholder="Search..."> <span
							class="input-group-btn">
							<button type="submit" name="search" id="search-btn" class="btn btn-flat">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
				</form>
				<!-- /.search form -->

				<!-- Sidebar Menu -->
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header"><a href="${pageContext.request.contextPath}/addchannelform.do">
							Channels &nbsp; &nbsp;<i class="fa fa-plus-circle"></i>
					</a> <c:forEach var="aa" items="${ch_list}" varStatus="status">
							<li><a
								href="<%=request.getContextPath()%>/post/list.do?page=1&cn=${aa.ch_id}">
									<i class="fa fa-asterisk"></i>${aa.ch_name}
							</a></li>
						</c:forEach> <!-- <li><a href="#"><i id="icon2" class="fa fa-lock"></i>Channel
							2</a></li> -->
					<li class="header"><a href="index.html"> Direct Messages &nbsp; <i
							class="fa fa-plus-circle"></i>
					</a> <c:forEach var="aa" items="${nicknamelist}" varStatus="status">
							<li><a
								href="<%=request.getContextPath()%>/post/list.do?page=1&cn=${status.count}&ch_list=${ch_list}&nicknamelist=${nicknamelist}">
									<i class="fa fa-asterisk"></i>${aa}
							</a></li>
						</c:forEach> <!-- 	<li><a href="#"><i class="fa fa fa-user"></i>사람1</a></li>
					<li><a href="#"><i class="fa fa-users"></i>사람1,사람2</a></li> -->
					<li class="header"><a href="${pageContext.request.contextPath }/moreteam.do?"> Invate
							People &nbsp; <i class="fa fa-plus-circle"></i>
					</a></li>


				</ul>
				<!-- /.sidebar-menu -->
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<section class="content ">

				<!-- row -->
				<div class="row">
					<div class="col-md-12">
						<!-- The time line -->
						<ul class="timeline">
							<!-- timeline time label -->
							<li class="time-label"><span class="bg-red"> 10 Feb. 2014 </span></li>
							<!-- /.timeline-label -->
							<!-- timeline item -->
							<li><i class="fa fa-envelope bg-blue"></i>

								<div class="timeline-item">
									<span class="time"><i class="fa fa-clock-o"></i> 12:05</span>

									<h3 class="timeline-header">
										<a href="#">Support Team</a>
										<div class="timelinebtn">
											<a class="btn btn-danger btn-xs">Delete</a>
										</div>
									</h3>

									<div class="timeline-body">Etsy doostang zoodles disqus groupon greplin oooj voxy
										zoodles, weebly ning heekya handango imeem plugg dopplr jibjab, movity jajah plickers
										sifteo edmodo ifttt zimbra. Babblely odeo kaboodle quora plaxo ideeli hulu weebly
										balihoo...</div>
								</div></li>
							<li><i class="fa fa-envelope bg-blue"></i>

								<div class="timeline-item">
									<span class="time"><i class="fa fa-clock-o"></i> 12:05</span>

									<h3 class="timeline-header">
										<a href="#">Support Team</a>
										<div class="timelinebtn">
											<a class="btn btn-danger btn-xs">Delete</a>
										</div>
									</h3>

									<div class="timeline-body">Etsy doostang zoodles disqus groupon greplin oooj voxy
										zoodles, weebly ning heekya handango imeem plugg dopplr jibjab, movity jajah plickers
										sifteo edmodo ifttt zimbra. Babblely odeo kaboodle quora plaxo ideeli hulu weebly
										balihoo...</div>
								</div></li>

							<!-- END timeline item -->
							<!-- timeline item -->
							<li><i class="fa fa-user bg-aqua"></i>

								<div class="timeline-item">
									<span class="time"><i class="fa fa-clock-o"></i> 5 mins ago</span>

									<h3 class="timeline-header no-border">
										<a href="#">Sarah Young</a> accepted your friend request
									</h3>
								</div></li>
							<!-- END timeline item -->
							<!-- timeline item -->
							<c:forEach items="${list}" var="post"  varStatus="status">
							<fmt:formatDate value="${post.logdate}" var="logdate" pattern="yyyy.MM.dd"/>
							<fmt:formatDate value="${list[status.index-1].logdate}" var="logdate2" pattern="yyyy.MM.dd"/>
							<c:if test="${logdate ne logdate2}">
								<li class="time-label"><span class="bg-red"> ${post.logdate}</span></li>
							</c:if>
								<li><i class="fa fa-comments bg-yellow"></i>

									<div class="timeline-item">
										<span class="time"><i class="fa fa-clock-o"></i>${post.logdate}</span>

										<h3 class="timeline-header">
											<a href="#">${post.nickname}</a>
											<div class="timelinebtn">
											<c:set var="usernickname" value="${sessionScope.nickname}"/>
											<c:set var="writtennickname" value="${post.nickname}"/>										
											<c:if test="${usernickname eq writtennickname}">
												<a class="btn btn-danger btn-xs" href="<%= request.getContextPath() %>/post/delete.do?post_id=${post.post_id}&cn=${ch.ch_id}">Delete</a>
											</c:if>
											</div>
										</h3>

										<div class="timeline-body">${post.content}</div>
										<c:if test="${post.file_thumbnail ne 'x'}">
										<img src="<%= request.getContextPath() %>/resources/img/${post.file_thumbnail}"> <br>
										</c:if>
										<a href="<%= request.getContextPath() %>/post/download.do?fileName=${ post.file_original}">${ post.fileName}</a>
									</div></li>
							</c:forEach>
							<!-- END timeline item -->
							<!-- timeline time label -->
							<li class="time-label"><span class="bg-green"> 3 Jan. 2014 </span></li>
							<!-- /.timeline-label -->
							<!-- timeline item -->
							<li><i class="fa fa-camera bg-purple"></i>

								<div class="timeline-item">
									<span class="time"><i class="fa fa-clock-o"></i> 2 days ago</span>

									<h3 class="timeline-header">
										<a href="#">Mina Lee</a> uploaded new photos
										<div class="timelinebtn">
											<a class="btn btn-danger btn-xs">Delete</a>
										</div>
									</h3>

									<div class="timeline-body">
										<img src="http://placehold.it/150x100" alt="..." class="margin"> <img
											src="http://placehold.it/150x100" alt="..." class="margin"> <img
											src="http://placehold.it/150x100" alt="..." class="margin"> <img
											src="http://placehold.it/150x100" alt="..." class="margin">
									</div>
								</div></li>
							<li><i class="fa fa-camera bg-purple"></i>

								<div class="timeline-item">
									<span class="time"><i class="fa fa-clock-o"></i> 2 days ago</span>

									<h3 class="timeline-header">
										<a href="#">Mina Lee</a> uploaded new photos
										<div class="timelinebtn">
											<a class="btn btn-danger btn-xs">Delete</a>
										</div>
									</h3>

									<div class="timeline-body">
										<img src="http://placehold.it/150x100" alt="..." class="margin"> <img
											src="http://placehold.it/150x100" alt="..." class="margin"> <img
											src="http://placehold.it/150x100" alt="..." class="margin"> <img
											src="http://placehold.it/150x100" alt="..." class="margin">
									</div>
								</div></li>
							<!-- timeline item -->

							<!-- END timeline item -->
							<li><i class="fa fa-clock-o bg-gray"></i></li>
						</ul>
					</div>
				</div>
			</section>
		</div>

		<%@include file="mainFooter.jsp"%>
	</div>

</body>
</html>