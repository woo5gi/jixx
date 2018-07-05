<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="mainHeader.jsp" flush="false" />
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<section class="content ">
				<!-- row -->
				<div class="row">
					<div class="col-md-12">
						<!-- The time line -->
						<ul class="timeline" id="div">
							<!-- timeline time label -->
							<li class="time-label" ><span class="bg-red"> 10 Feb. 2014 </span></li>
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
							<!-- END timeline item -->
							<!-- timeline item -->
							<c:forEach items="${list}" var="post" varStatus="status">
								<fmt:formatDate value="${post.logdate}" var="logdate" pattern="yyyy.MM.dd" />
								<fmt:formatDate value="${list[status.index-1].logdate}" var="logdate2" pattern="yyyy.MM.dd" />
								<c:if test="${logdate ne logdate2}">
									<li class="time-label"><span class="bg-red"> ${post.logdate}</span></li>
								</c:if>
								<c:choose>
									<c:when test="${post.post_status eq 3}">
										<li><i class="fa fa-user bg-aqua"></i>

											<div class="timeline-item">
												<span class="time"><i class="fa fa-clock-o"></i>${post.logdate}</span>

												<h3 class="timeline-header no-border">
													<a href="#">${post.nickname}님</a> ${rep_name} ${post.content }
												</h3>
											</div></li>
									</c:when>
									<c:otherwise>
										<li><i class="fa fa-envelope bg-blue"></i> <c:if test="${post.file_thumbnail ne 'x'}">
												<i class="fa fa-camera bg-purple"></i>
											</c:if>

											<div class="timeline-item">
												<span class="time"><i class="fa fa-clock-o"></i>${post.logdate}</span>

												<h3 class="timeline-header">
													<a href="#">${post.nickname}</a>
													<div class="timelinebtn">
														<c:set var="usernickname" value="${sessionScope.nickname}" />
														<c:set var="writtennickname" value="${post.nickname}" />
														<c:if test="${usernickname eq writtennickname}">
															<a class="btn btn-danger btn-xs"
																href="<%= request.getContextPath() %>/post/delete.do?post_id=${post.post_id}&cn=${ch.ch_id}">Delete</a>
														</c:if>
													</div>
												</h3>

												<div class="timeline-body">${post.content}</div>
												<c:if test="${post.file_thumbnail ne 'x'}">
													<img src="<%= request.getContextPath() %>/resources/img/${post.file_thumbnail}"
														class="margin">
													<br>
												</c:if>
												<a
													href="<%= request.getContextPath() %>/post/download.do?fileName=${ post.file_original}">${ post.fileName}</a>
											</div></li>
									</c:otherwise>
								</c:choose>
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

 <script type="text/javascript">
 var page = 2;

 var isLoading = false;

 function loadNewPage() {
     var temp = $(document).height();
     page++;
     $(document).scrollTop($(document).height()-temp);
     isLoading = false;
 }

 $(document).scroll(function() {
   if($(document).scrollTop() < 1 && !isLoading) {
	   $.ajax({
           type : "GET",
           url : "<%=request.getContextPath()%>/post/ajax.do",
           data : { page: page, cn: "${ch.ch_id}" },
           dataType : "json",
           error : function(){
               alert('더이상 불러올 데이터가 없습니다.');
           },
           success : function(data){
        	  console.log(data.length);
        	  if (data.length == '0') {
        		  alert('더이상 불러올 데이터가 없습니다.');
        	  } else {
        	  for (var i = 0; i < data.length; i++) {
						var str = "";
     			if (i != 0) {
        		  if (data[i].logdate != data[i-1].logdate) {
					str += '<li class="time-label"><span class="bg-red">'+ data[i].logdate+'</span></li>';
        		  }
				}
					if (data[i].post_status == '3') {
						str +='<li>'+
						'<li><i class="fa fa-user bg-aqua"></i>'+
						'<div class="timeline-item">'+
						'<span class="time"><i class="fa fa-clock-o"></i> '+data[i].logdate+'</span>'+
						'<h3 class="timeline-header no-border">'+
						'<a href="#">'+data[i].nickname+'님</a> ${rep_name}'+ data[i].content+
						'</h3>'+
						'</div></li>';
					} else {
						str +='<li>';
						if (data[i].file_thumbnail != 'x') {
							str +='<i class="fa fa-camera bg-purple"></i>';
						} else{
							str += '<li><i class="fa fa-envelope bg-blue"></i>';
						}
						str += '<div class="timeline-item">'+
						'<span class="time"><i class="fa fa-clock-o"></i>'+ data[i].logdate+'</span>'+
						'<h3 class="timeline-header">'+
						'<a href="#">'+ data[i].nickname+'</a>'+
						'<div class="timelinebtn">';
						if ('${sessionScope.nickname}' == data[i].nickname) {
							str += '<a class="btn btn-danger btn-xs" href="${pageContext.request.contextPath}/post/delete.do?post_id='+data[i].post_id+'&cn=${ch.ch_id}">Delete</a>';
						}
						str +='</div>'+
						'</h3>'+
						'<div class="timeline-body">'+data[i].content+'</div>';
						if (data[i].file_thumbnail != 'x') {
							str += '<img src="${pageContext.request.contextPath}/resources/img/'+data[i].file_thumbnail + '" class="margin"> <br>';
						}
						if (data[i].file_original != 'x') {
							str += '<a href="${pageContext.request.contextPath}/post/download.do?fileName='+data[i].file_original+'">'+ data[i].fileName+'</a>';
						}
						str += '</div></li>';
					}
						$("#div").prepend(str);
			 	} 
			$("#div").trigger("create");
			}
           }            
       });
     isLoading = true;
     setTimeout(loadNewPage, 100);
   }
   
 });
</script>
						</html>