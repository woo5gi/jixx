<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="header.jsp" flush="false" />
<style>
.carousel-item {
	height: 100vh;
	min-height: 300px;
	background: no-repeat center center scroll;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}

.carousel-caption {
	position: absolute;
	right: 15%;
	bottom: 765px;
	left: 15%;
	z-index: 10;
	padding-top: 20px;
	padding-bottom: 20px;
	color: #222d32;
	text-align: center;
}

.carousel-caption2 {
	position: absolute;
	right: 15%;
	bottom: 30px;
	left: 15%;
	z-index: 10;
	padding-top: 20px;
	padding-bottom: 20px;
	color: #222d32;
	text-align: center;
}

h3 {
	display: block;
	font-size: 2em;
	-webkit-margin-before: 1em;
	-webkit-margin-after: 1em;
	-webkit-margin-start: 0px;
	-webkit-margin-end: 0px;
	font-weight: bold;
}

p {
	-webkit-margin-before: 0.8em;
	-webkit-margin-after: 0.8em;
	-webkit-margin-start: 0px;
	-webkit-margin-end: 0px;
}
</style>
<script type="text/javascript">
</script>
<body class="skin-blue layout-top-nav" style="height: auto; min-height: 100%;">
	<c:set var="email" value="${email}" />
	<div class="wrapper" style="height: auto; min-height: 100%;">
		<header>
			<div id="carouselExampleIndicators" class="carousel slide"
				data-ride="carousel">
				<div class="carousel-inner" role="listbox">
					<div class="carousel-item active"
						style="background-image: url('resources/images/index1.jpg');height: 100%; width: 100%;">
						<div class="carousel-caption d-none d-md-block">
							<h3>FILE CETACEA</h3>
							<p>*(파일공유 그룹웨어)</p>
						</div>
					</div>
				</div>
			</div>
		</header>
	</div>
</body>
</html>