<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="text/html; charset=UTF-8">
<title>JIXX</title>
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
   folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/dist/css/skins/_all-skins.min.css">
<!-- Morris chart -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bower_components/morris.js/morris.css">
<!-- jvectormap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bower_components/jvectormap/jquery-jvectormap.css">
<!-- Date Picker -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
<!-- Daterange picker -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bower_components/bootstrap-daterangepicker/daterangepicker.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

<!-- jQuery 3 -->
<script src="<%=request.getContextPath()%>/resources/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="<%=request.getContextPath()%>/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="<%=request.getContextPath()%>/resources/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="<%=request.getContextPath()%>/resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/resources/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="<%=request.getContextPath()%>/resources/dist/js/demo.js"></script>


<style type="text/css">

/* .main-sidebar{
	 position: fixed;
	 } */
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
</style>
<script type="text/javascript">
  /* $(function() {

   $('input:checkbox[name="alarmcb"]').each(function() {

   this.checked = true; //checked 처리

   if (this.checked) { //checked 처리된 항목의 값

   alert(this.value);

   }

   });

   });
   */
  $(function() {
    var alarmtype = $('input[name=ch_id_forcheckbox]').val();
    if (alarmtype == 1) {
      alarmtype.next('input[name=alarmcb]').checked = true;
    }

  })

  function myFunction() {
    var checkbox = $('input:checkbox[name=alarmcb]');
    var chid = checkbox.val();
    if (checkbox.is(":checked")) {
      alert("체크활성" + chid)
      $.ajax({
      url : "${pageContext.request.contextPath}/alarmcheck.do",
      data : {
      "alarm_type" : 1,
      "chid" : chid
      },
      success : function() {
        alert('알람활성화');
      }
      });
    } else {
      alert("체크비활성" + chid);
      $.ajax({
      url : "${pageContext.request.contextPath}/alarmuncheck.do",
      data : {
      "alarm_type" : 0,
      "chid" : chid
      },
      success : function() {
        alert('알람비활성화');
      }
      });

    }
  }
</script>
</head>

<body class="hold-transition skin-blue sidebar-mini">
  <c:set var="user_id" value="${id}" />
  <c:set var="rep_id" value="${rep_id}" />
  <c:set var="ch_list" value="${ch_list}" />
  <c:set var="user_list" value="${user_list}" />
  <c:set var="email" value="${email}" />
  <c:set var="replist" value="${rep_list}" />
  <c:set var="user_name" value="${user_name}" />
  <c:set var="rep_name" value="${rep_name}" />
  <c:set var="ch" value="${ch}" />
  <c:set var="alarmtypelist" value="${alarmtypelist}" />
  <div class="wrapper">
    <!-- Main Header -->
    <header class="main-header"> <!-- Logo --> <a href="${pageContext.request.contextPath }/index.do" class="logo"><img
      src="${pageContext.request.contextPath }/resources/images/logo.png" alt="Logo"> </a> <!-- Header Navbar --> <nav
      class="navbar navbar-static-top" role="navigation"> <!-- <div><a href="#">채널</a></div> -->
    <li class="cname">${ch.ch_name}#</li>
    <div class="navbar-custom-menu">
      <ul class="nav navbar-nav">
        <!-- Messages: style can be found in dropdown.less-->
        <li class="dropdown messages-menu">
          <!-- Menu toggle button --> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-envelope-o"></i> <span
            class="label label-success">4</span>
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
          <!-- Menu toggle button --> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-bell-o"></i> <span
            class="label label-warning">10</span>
        </a>
          <ul class="dropdown-menu">
            <li class="header">You have 10 notifications</li>
            <li>
              <!-- Inner Menu: contains the notifications -->
              <ul class="menu">
                <li>
                  <!-- start notification --> <a href="#"> <i class="fa fa-users text-aqua"></i> 5 new members joined today
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
          <!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-flag-o"></i> <span
            class="label label-danger">9</span>
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
                      <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0"
                        aria-valuemax="100">
                        <span class="sr-only">20% Complete</span>
                      </div>
                    </div>
                </a>
                </li>
                <!-- end task item -->
              </ul>
            </li>
            <li class="footer"><a href="#">View all tasks</a></li>
          </ul>
        </li>
        <!-- User Account Menu -->
        <c:choose>
          <c:when test="${user_id eq null}">
            <li class="dropdown user user-menu"><a class="dropdown-toggle" href="${pageContext.request.contextPath}/member/loginForm.do">
                SIGN IN </a></li>
          </c:when>

          <c:otherwise>
            <li class="dropdown user user-menu"><a href="${pageContext.request.contextPath}/gomain.do?rep_id=${sessionScope.rep_id} "
              class="dropdown-toggle"> ${user_name}님 의 ${rep_name}저장소 </a></li>

            <c:choose>
              <c:when test="${empty replist}">
                <li class="dropdown user user-menu"><a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"> <span
                    class="hidden-xs">Create Workspace</span>
                </a>
                  <ul class="dropdown-menu">
                    <li class="user-header">
                      <p>
                        <a href="${pageContext.request.contextPath}/crw1.do"> <span class="hidden-xs" style="color: #fff;">Create New
                            Workspace</span>
                        </a>
                      </p>
                    </li>

                    <li class="user-body" id="user-body1"><a href="${pageContext.request.contextPath}/findworkspaceform.do"
                      class="hidden-xs text-center" aria-expanded="false">Find Workspace</a></li>
                    <!-- Menu Footer-->
                    <li class="user-footer">
                      <div class="pull-left">
                        <a href="#" class="btn btn-default btn-flat">Profile</a>
                      </div>
                      <div class="pull-right">
                        <a href="${pageContext.request.contextPath}/member/logout.do" class="btn btn-default btn-flat">Sign out</a>
                      </div>
                    </li>
                  </ul></li>
              </c:when>

              <c:otherwise>
                <li class="dropdown user user-menu" style=""><a href="${pageContext.request.contextPath}/gomain.do" class="dropdown-toggle"
                  data-toggle="dropdown" aria-expanded="false"> <span class="hidden-xs">My Workspace</span>
                </a>
                  <ul class="dropdown-menu">
                    <li class="user-header">
                      <p>WorkSpace List</p>
                    <li class="user-body" id="user-body1"><a href="${pageContext.request.contextPath}/crw1.do" class="hidden-xs text-center">Create
                        new Workspace</a></li>
                    <c:forEach var="aa" items="${rep_list}">
                      <li class="user-body"><a href="${pageContext.request.contextPath}/gomain.do?rep_id=${aa.rep_id}"
                        class="hidden-xs text-center">${aa.rep_name}</a></li>
                    </c:forEach>
                    <!-- Menu Body -->
                    <li class="user-body" id="user-body1"><a href="${pageContext.request.contextPath}/findworkspaceform.do"
                      class="hidden-xs text-center">Find Workspace</a></li></li>

                <!-- Menu Footer-->
                <li class="user-footer">
                  <div class="pull-left">
                    <a href="${pageContext.request.contextPath}/profileform.do" class="btn btn-default ">Profile</a>
                  </div> <c:choose>
                    <c:when test="${adminlevel eq 1 }">
                      <div class="pull-left">
                        <a href="${pageContext.request.contextPath}/repadminform.do?adminlevel=1" class="btn btn-default btn-flat">저장소관리</a>
                      </div>
                    </c:when>
                    <c:when test="${adminlevel eq 2 }">
                      <div class="pull-left">
                        <a href="${pageContext.request.contextPath}/repadminform.do?adminlevel=2" class="btn btn-default btn-flat">저장소관리</a>
                      </div>
                    </c:when>
                    <c:otherwise>
                      <div class="pull-left">
                        <a href="${pageContext.request.contextPath}/repadminform.do?adminlevel=3" class="btn btn-default btn-flat">저장소관리</a>
                      </div>
                    </c:otherwise>
                  </c:choose>
                  <div class="pull-left">
                    <a href="${pageContext.request.contextPath}/member/logout.do" class="btn btn-default btn-flat">Sign out</a>
                  </div>
                </li>
              </c:otherwise>
            </c:choose>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
    </nav> </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar" style=" overflow-y: auto;"> <!-- sidebar: style can be found in sidebar.less --> <section class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel">
      <!-- 	<div class="pull-left image">
				<img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
			</div> -->
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
    <form action="${pageContext.request.contextPath}/searchboard.do?" method="get" class="sidebar-form">
      <div class="input-group">
        <input type="text" name="search" class="form-control" placeholder="Search..."> <span class="input-group-btn">
          <button type="submit" id="search-btn" class="btn btn-flat">
            <i class="fa fa-search"></i>
          </button>
        </span>
      </div>
    </form>
    <!-- /.search form --> <!-- Sidebar Menu -->
    <ul class="sidebar-menu" data-widget="tree">
      <li class="header"><a href="${pageContext.request.contextPath}/addchannelform.do">Channels &nbsp; &nbsp;<i class="fa fa-plus-circle"></i>
      </a></li>
      <div class="liscroll">
        <c:forEach var="aa" items="${ch_list}" varStatus="status">
          <li class="listyle"><a href="<%=request.getContextPath()%>/post/list.do?page=1&cn=${aa.ch_id}"> <i class="fa fa-asterisk i1"></i>${aa.ch_name}

          </a><input type="text" name="ch_id_forcheckbox" value="${aa.ch_id}"> <input type="text" value="${alarmtypelist[status.index]}">
            <input name="alarmcb" type="checkbox" onclick="myFunction()" value="${aa.ch_id}${status.index}"></li>

        </c:forEach>
      </div>
      <li class="header"><a href="index.html"> Direct Messages &nbsp; <i class="fa fa-plus-circle i1"></i>
      </a></li>
      <div class="liscroll">
        <c:forEach var="aa" items="${nicknamelist}" varStatus="status">
          <%-- 				<li class="listyle"><a href="<%=request.getContextPath()%>/post/list.do?page=1&cn=${status.count}&ch_list=${ch_list}&nicknamelist=${nicknamelist}"> --%>
          <li class="listyle"><a href="<%=request.getContextPath()%>/privatechat.do" method="post"> <i class="fa fa fa-user i1"></i>${aa}</a></li>
        </c:forEach>
      </div>
      <li class="header i1"><a href="<%=request.getContextPath()%>/privatechat.do" method="post"> Chat Room <i class="fa fa-plus-circle"></i></a>
      </li>
      <li class="header i1"><a href="${pageContext.request.contextPath }/moreteam.do?"> Invite </a></li>
    </ul>
    </section> </aside>