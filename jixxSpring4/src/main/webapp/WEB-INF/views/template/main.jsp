<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.bg {
	min-height: 100%;
	background-color: #ecf0f5;
	margin-left:230px;
}
</style>
<jsp:include page="mainHeader.jsp" flush="false" />
<div class="bg">
		<!-- Content Wrapper. Contains page content -->
			<section class="content ">
				<!-- row -->
				<div class="row">
					<div class="col-md-12">
						<!-- The time line -->
						<ul class="timeline" id="div">
							<c:forEach items="${list}" var="post" varStatus="status">
								<fmt:formatDate value="${post.logdate}" var="logdate" pattern="yyyy.MM.dd" />
								<fmt:formatDate value="${list[status.index-1].logdate}" var="logdate2" pattern="yyyy.MM.dd" />
								<c:if test="${logdate ne logdate2}">
									<li class="time-label" id="${post.logdate}"><span class="bg-red"> ${post.logdate}</span></li>
								</c:if>
								<c:choose>
									<c:when test="${post.post_status eq 3}">
										<li><i class="fa fa-user bg-aqua"></i>

											<div class="timeline-item">
												<span class="time"><i class="fa fa-clock-o"></i>${post.logdate}</span>

												<h3 class="timeline-header no-border">
													<a href="#">${post.nickname}님</a> ${rep_name} ${post.content }
												</h3>
											</div></li><br>
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
														<a class="change"> 수정</a>
															<a class="btn btn-danger btn-xs"
																href="<%= request.getContextPath() %>/post/delete.do?post_id=${post.post_id}&cn=${ch.ch_id}" id="delete">Delete</a>
														</c:if>
													</div>
												</h3>

												<div class="timeline-body" id="${post.post_id}">${post.content}</div>
												<c:if test="${post.file_thumbnail ne 'x'}">
													<img src="<%= request.getContextPath() %>/resources/img/${post.file_thumbnail}"
														class="margin">
													<br>
												</c:if>
												<a
													href="<%= request.getContextPath() %>/post/download.do?fileName=${ post.file_original}">${ post.fileName}</a>
													<c:if test="${param.search ne null}">
													<a href="<%=request.getContextPath()%>/post/list.do?page=1&cn=${post.channel_id}">채널
														</a>
													</c:if>
											</div></li><br>
									</c:otherwise>
								</c:choose>
							</c:forEach>
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
 var getParameters = function (paramName) {
	    var returnValue;

	    var url = location.href;

	    var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');

	    for (var i = 0; i < parameters.length; i++) {
	        var varName = parameters[i].split('=')[0];
	        if (varName.toUpperCase() == paramName.toUpperCase()) {
	            returnValue = parameters[i].split('=')[1];
	            return decodeURIComponent(returnValue);
	        }
	    }
	};
	
 var page = 2;

 var isLoading = false;

 function loadNewPage() {
     var temp = $(document).height();
     page++;
     $(document).scrollTop($(document).height()-temp);
     isLoading = false;
 	$('.change').on('click',function(){
		var content = $(this).parent().parent().next('div.timeline-body').text().trim();
		var thisA = $(this);
		$(this).parent().parent().next('div.timeline-body').empty();
		$(this).parent().parent().next('div.timeline-body').append('<input type="text" value="'+content+'"/>');
		$(this).parent().parent().next('div.timeline-body').append('<button class="cencel">취소</button>');
		$(this).parent().parent().next('div.timeline-body').append('<button class="ok">완료</button>');
		$(this).hide();
		$('.cencel').on('click',function(){	
			thisA.show();
			$(this).parent().text(content);
		});
		$('.ok').on('click',function(){
			var updatecontent = $(this).prev().prev().val();
			var postID = $(this).parent().attr("id");
			 $.ajax({
				type : "GET",
		        url : "<%=request.getContextPath()%>/post/update.do",
		        data : { content: updatecontent, post_id: postID},
			});
			thisA.show();
			$(this).parent().text(updatecontent);
		});
	});
 }
 $( document ).ready(function() {
 $(document).scroll(function() {
	 var searchitem = getParameters('search');
   if($(document).scrollTop() < 1 && !isLoading) {
	 if (searchitem == undefined) {
	console.log(searchitem);
	   $.ajax({
           type : "GET",
           url : "<%=request.getContextPath()%>/post/ajax.do",
           data : { page: page, cn: "${ch.ch_id}" },
           dataType : "json",
           error : function(){
               alert('더이상 불러올 데이터가 없습니다.');
               page--;
           },
           success : function(data){
        	  console.log(data.length);
        	  if (data.length == '0') {
        		  alert('더이상 불러올 데이터가 없습니다.');
        		  page--;
        	  } else {
        	  for (var i = 1; i < data.length; i++) {
						var str = "";
        		  
					if (data[i].post_status == '3') {
						if (data.length == i+1) {
							var logdate1 = $('#'+data[i-1].logdate).val();
							if (logdate1 == undefined) {								
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
							} else {
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
								$('#'+data[i-1].logdate).remove();
							}
						}
						str +='<li>'+
						'<li><i class="fa fa-user bg-aqua"></i>'+
						'<div class="timeline-item">'+
						'<span class="time"><i class="fa fa-clock-o"></i> '+data[i].logdate+'</span>'+
						'<h3 class="timeline-header no-border">'+
						'<a href="#">'+data[i].nickname+'님</a> ${rep_name}'+ data[i].content+
						'</h3>'+
						'</div></li>';
						if (data[i].logdate != data[i-1].logdate) {
							var logdate = $('#'+data[i-1].logdate).val();
							if (logdate == undefined) {								
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
							} else {
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
								$('#'+data[i-1].logdate).remove();
							}
		        		  }
					} else {
						if (data.length == i+1) {
							var logdate1 = $('#'+data[i-1].logdate).val();
							if (logdate1 == undefined) {								
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
							} else {
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
								$('#'+data[i-1].logdate).remove();
							}
						}
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
							str += '<a class="change"> 수정</a>'+
							'<a class="btn btn-danger btn-xs" href="${pageContext.request.contextPath}/post/delete.do?post_id='+data[i].post_id+'&cn=${ch.ch_id}">Delete</a>';
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
						if (data[i].logdate != data[i-1].logdate) {
							var logdate = $('#'+data[i-1].logdate).val();
							if (logdate == undefined) {								
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
							} else {
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
								$('#'+data[i-1].logdate).remove();
							}
		        		  }
					}
						$("#div").prepend(str);
			 	} 
			$("#div").trigger("create");
			}
           }            
       });
     isLoading = true;
     setTimeout(loadNewPage, 100);
   } else {
	   $.ajax({
           type : "GET",
           url : "<%=request.getContextPath()%>/post/searchAjax.do",
           data : { page: page, search: searchitem, rep_id: '${sessionScope.rep_id}' },
           dataType : "json",
           error : function(){
               alert('더이상 불러올 데이터가 없습니다.');
               page--;
           },
           success : function(data){
        	  console.log(data.length);
        	  if (data.length == '0') {
        		  alert('더이상 불러올 데이터가 없습니다.');
        		  page--;
        	  } else {
        	  for (var i = 1; i < data.length; i++) {
						var str = "";
        		  
					if (data[i].post_status == '3') {
						if (data.length == i+1) {
							var logdate1 = $('#'+data[i-1].logdate).val();
							if (logdate1 == undefined) {								
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
							} else {
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
								$('#'+data[i-1].logdate).remove();
							}
						}
						str +='<li>'+
						'<li><i class="fa fa-user bg-aqua"></i>'+
						'<div class="timeline-item">'+
						'<span class="time"><i class="fa fa-clock-o"></i> '+data[i].logdate+'</span>'+
						'<h3 class="timeline-header no-border">'+
						'<a href="#">'+data[i].nickname+'님</a> ${rep_name}'+ data[i].content+
						'</h3>'+
						'</div></li>';
						if (data[i].logdate != data[i-1].logdate) {
							var logdate = $('#'+data[i-1].logdate).val();
							if (logdate == undefined) {								
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
							} else {
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
								$('#'+data[i-1].logdate).remove();
							}
		        		  }
					} else {
						if (data.length == i+1) {
							var logdate1 = $('#'+data[i-1].logdate).val();
							if (logdate1 == undefined) {								
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
							} else {
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
								$('#'+data[i-1].logdate).remove();
							}
						}
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
							str += '<a class="change"> 수정</a>'+
							'<a class="btn btn-danger btn-xs" href="${pageContext.request.contextPath}/post/delete.do?post_id='+data[i].post_id+'&cn=${ch.ch_id}">Delete</a>';
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
						str += '<a href="${pageContext.request.contextPath}/post/list.do?page=1&cn='+data[i].channel_id+'"> <iclass="fa fa-asterisk">채널</i></a>';
						str += '</div></li>';
						if (data[i].logdate != data[i-1].logdate) {
							var logdate = $('#'+data[i-1].logdate).val();
							if (logdate == undefined) {								
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
							} else {
								str += '<li class="time-label" id="'+data[i-1].logdate+'"><span class="bg-red">'+ data[i-1].logdate+'</span></li>';
								$('#'+data[i-1].logdate).remove();
							}
		        		  }
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
	 
 }

 });
	$('.change').on('click',function(){
		var content = $(this).parent().parent().next('div.timeline-body').text().trim();
		var thisA = $(this);
		$(this).parent().parent().next('div.timeline-body').empty();
		$(this).parent().parent().next('div.timeline-body').append('<input type="text" value="'+content+'"/>');
		$(this).parent().parent().next('div.timeline-body').append('<button class="cencel">취소</button>');
		$(this).parent().parent().next('div.timeline-body').append('<button class="ok">완료</button>');
		$(this).hide();
		$('.cencel').on('click',function(){	
			thisA.show();
			$(this).parent().text(content);
		});
		$('.ok').on('click',function(){
			var updatecontent = $(this).prev().prev().val();
			var postID = $(this).parent().attr("id");
			 $.ajax({
				type : "GET",
		        url : "<%=request.getContextPath()%>/post/update.do",
		        data : { content: updatecontent, post_id: postID},
			});
			thisA.show();
			$(this).parent().text(updatecontent);
		});
	});
 });
</script>
<script>

</script>
</div>
						</html>