<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.bg {
	min-height: 100%;
	background-color: #ecf0f5;
	margin-left: 230px;
}
</style>

<jsp:include page="../template/mainHeader.jsp" flush="false" />
<div class="bg">

  <section class="content ">
    <div>
      <!-- DIRECT CHAT PRIMARY -->
      <div class="box box-primary direct-chat direct-chat-primary">
        <div class="box-header with-border">
          <h3 class="box-title">Direct Chat</h3>

          <div class="box-tools pull-right">
            <span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="3 New Messages">3</span>
            <button type="button" class="btn btn-box-tool" data-widget="collapse">
              <i class="fa fa-minus"></i>
            </button>
            <button type="button" class="btn btn-box-tool" data-toggle="tooltip" title="" data-widget="chat-pane-toggle"
              data-original-title="Contacts">
              <i class="fa fa-comments"></i>
            </button>
            <button type="button" class="btn btn-box-tool" data-widget="remove">
              <i class="fa fa-times"></i>
            </button>
          </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body" style="height: 680px">
          <!-- Conversations are loaded here -->
          <div class="direct-chat-messages">
            <!-- Message. Default to the left -->
            <div class="direct-chat-msg">
              <div class="direct-chat-info clearfix">
                <span class="direct-chat-name pull-left">Alexander Pierce</span> <span class="direct-chat-timestamp pull-right">23 Jan 2:00 pm</span>
              </div>
              <!-- /.direct-chat-info -->
              <img class="direct-chat-img" src="../dist/img/user1-128x128.jpg">
              <!-- /.direct-chat-img -->
              <div class="direct-chat-text">Is this template really for free? That's unbelievable!</div>
              <!-- /.direct-chat-text -->
            </div>
            <!-- /.direct-chat-msg -->

            <!-- Message to the right -->
            <div class="direct-chat-msg right">
              <div class="direct-chat-info clearfix">
                <span class="direct-chat-name pull-right">Sarah Bullock</span> <span class="direct-chat-timestamp pull-left">23 Jan 2:05 pm</span>
              </div>
              <!-- /.direct-chat-info -->
              <img class="direct-chat-img" src="../dist/img/user3-128x128.jpg">
              <!-- /.direct-chat-img -->
              <div class="direct-chat-text">You better believe it!</div>
              <!-- /.direct-chat-text -->
            </div>
            <!-- /.direct-chat-msg -->
          </div>
          <!--/.direct-chat-messages-->

          <!-- Contacts are loaded here -->
          <div class="direct-chat-contacts">
            <ul class="contacts-list">
              <li><a href="#"> <img class="contacts-list-img" src="../dist/img/user1-128x128.jpg" alt="User Image">

                  <div class="contacts-list-info">
                    <span class="contacts-list-name"> Count Dracula <small class="contacts-list-date pull-right">2/28/2015</small>
                    </span> <span class="contacts-list-msg">How have you been? I was...</span>
                  </div> <!-- /.contacts-list-info -->
              </a></li>
              <!-- End Contact Item -->
            </ul>
            <!-- /.contatcts-list -->
          </div>
          <!-- /.direct-chat-pane -->
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
          <form action="#" method="post">
            <div class="input-group">
              <input type="text" name="message" placeholder="Type Message ..." class="form-control"> <span class="input-group-btn">
                <button type="submit" class="btn btn-primary btn-flat">Send</button>
              </span>
            </div>
          </form>
        </div>
        <!-- /.box-footer-->
      </div>
      <!--/.direct-chat -->
    </div>
  </section>
  <%@include file="../template/mainFooter.jsp"%>
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
		        url : "<%=request.getContextPath()%>
  /post/update.do",
        data : {
        content : updatecontent,
        post_id : postID
        },
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