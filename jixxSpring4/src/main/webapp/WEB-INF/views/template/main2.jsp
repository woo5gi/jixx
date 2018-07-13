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
                     <c:choose>
                        <c:when test="${empty list}">
                        <div class="error-content">
                               <h3><i class="fa fa-warning text-red"></i> 검색결과가 없습니다!</h3>
                          </div>
                        </c:when>
                        <c:otherwise>
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
                                       <c:if test="${post.post_status ne 0 }">
                                          <a class="repost1">댓글달기</a>
                                       </c:if>
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
                                       <c:forEach items="${repost}" var="repost">
                                       <c:if test="${repost.repost_id eq post.post_id }">
                                       <c:choose>
                                       <c:when test="${repost.post_status eq 0 }">
                                          <div> 삭제된 댓글입니다. </div>
                                       </c:when>
                                       <c:otherwise>
                                          <div class="timeline-item">
                                             <span class="time"><i class="fa fa-clock-o"></i>${repost.logdate}</span>
                                                <a href="#">${repost.nickname}</a>
                                             <span class="timeline-body" id="${repost.post_id}">${repost.content}</span>
                                             <a class="btn btn-danger btn-xs"
                                                href="<%= request.getContextPath() %>/post/delete.do?post_id=${repost.post_id}&cn=${ch.ch_id}" id="delete">Delete</a>
                                          </div>
                                       </c:otherwise>
                                       </c:choose>
                                       </c:if>
                                       </c:forEach>
                                       </div></li><br>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <li><i class="fa fa-clock-o bg-gray"></i></li>
                  </ul>
                        </c:otherwise>
                     </c:choose>
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
 
 
 $( document ).ready(function() {
 $(document).scroll(function() {
    var searchitem = getParameters('search');
   if($(document).scrollTop() < 1 && !isLoading) {
    if (searchitem == undefined) {
      $.ajax({
           type : "GET",
           url : "<%=request.getContextPath()%>/post/ajax.do",
           data : { page: page, cn: "${ch.ch_id}" },
           dataType : "json",
           error : function(){
           },
           success : function(data){
              var list = data.list;
              var repost = data.repost;
             if (list.length == '0') {
                alert('더이상 불러올 데이터가 없습니다.');
             } else {
             for (var i = 1; i < list.length; i++) {
                  var str = "";
               if (list[i].post_status == '3') {
                  var logdate = $('#'+list[i-1].logdate).val();
                  if (logdate == undefined) {
                     if (list[i].logdate != list[i-1].logdate) {
                     str += '<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>';
                     }
                  }
                  str +='<li>'+
                  '<li><i class="fa fa-user bg-aqua"></i>'+
                  '<div class="timeline-item">'+
                  '<span class="time"><i class="fa fa-clock-o"></i> '+list[i].logdate+'</span>'+
                  '<h3 class="timeline-header no-border">'+
                  '<a href="#">'+list[i].nickname+'님</a> ${rep_name}'+ list[i].content+
                  '</h3>'+
                  '</div></li>';
               } else {
                  str +='<li>';
                  if (list[i].file_thumbnail != 'x') {
                     str +='<i class="fa fa-camera bg-purple"></i>';
                  } else{
                     str += '<li><i class="fa fa-envelope bg-blue"></i>';
                  }
                  str += '<div class="timeline-item">'+
                  '<span class="time"><i class="fa fa-clock-o"></i>'+ list[i].logdate+'</span>'+
                  '<h3 class="timeline-header">'+
                  '<a href="#">'+ list[i].nickname+'</a>'+
                  '<div class="timelinebtn">';
                  if (list[i].post_status != 0) {
                     str += '<a class="repost'+page+'">댓글달기</a>';                  
                  }
                  if ('${sessionScope.nickname}' == list[i].nickname) {
                     str += '<a class="change"> 수정</a>'+
                     '<a class="btn btn-danger btn-xs" href="${pageContext.request.contextPath}/post/delete.do?post_id='+list[i].post_id+'&cn=${ch.ch_id}">Delete</a>';
                  }
                  str +='</div>'+
                  '</h3>'+
                  '<div class="timeline-body">'+list[i].content+'</div>';
                  if (list[i].file_thumbnail != 'x') {
                     str += '<img src="${pageContext.request.contextPath}/resources/img/'+list[i].file_thumbnail + '" class="margin"> <br>';
                  }
                  if (list[i].file_original != 'x') {
                     str += '<a href="${pageContext.request.contextPath}/post/download.do?fileName='+list[i].file_original+'">'+ list[i].fileName+'</a>';
                  }
                  for (var j = 0; j < repost.length; j++) {
                     if (list[i].post_id == repost[j].repost_id) {
                        if (repost[j].post_status == 0) {
                           str += '<div> 삭제된 댓글입니다. </div>';
                        } else {
                           str += '<div class="timeline-item">'+
                            '<span class="time"><i class="fa fa-clock-o"></i>'+ (new Date).yyyymmdd() +'</span>'+
                            '<a href="#">'+repost[j].nickname+'</a>'+
                            '<span class="timeline-body" >'+repost[j].centent+'</span>'+
                            '<a class="btn btn-danger btn-xs"'+
                            'href="${pageContext.request.contextPath}/post/delete.do?post_id='+repost[j].post_id+'&cn=${ch.ch_id}" id="delete">Delete</a>'+
                            '</div>';
                        }
                     }
                  }
                  str += '</div></li>';
                  var logdate = $('#'+list[i-1].logdate).val();
                     if (logdate == undefined) {
                        if (list[i].logdate != list[i-1].logdate) {
                        str += '<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>';
                        }
                     } else {
                        $('#'+list[i-1].logdate).remove();
                        $('#div').prepend('<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>');                  
                     }
                  }
                  $("#div").prepend(str);
                }
               if (logdate == undefined) {
                  $('#div').prepend('<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>');
               } else {
                  $('#'+list[i-1].logdate).remove();
                  $('#div').prepend('<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>');                  
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
               alert('실패염');
           },
           success : function(data){
              var list = data.list;
              var repost = data.repost;
              if (list.length == '0') {
                alert('더이상 불러올 데이터가 없습니다.');
             } else {
             for (var i = 1; i < list.length; i++) {
                  var str = "";
               if (list[i].post_status == '3') {
                  var logdate = $('#'+list[i-1].logdate).val();
                  if (logdate == undefined) {
                     if (list[i].logdate != list[i-1].logdate) {
                     str += '<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>';
                     }
                  }
                  str +='<li>'+
                  '<li><i class="fa fa-user bg-aqua"></i>'+
                  '<div class="timeline-item">'+
                  '<span class="time"><i class="fa fa-clock-o"></i> '+list[i].logdate+'</span>'+
                  '<h3 class="timeline-header no-border">'+
                  '<a href="#">'+list[i].nickname+'님</a> ${rep_name}'+ list[i].content+
                  '</h3>'+
                  '</div></li>';
               } else {
                  str +='<li>';
                  if (list[i].file_thumbnail != 'x') {
                     str +='<i class="fa fa-camera bg-purple"></i>';
                  } else{
                     str += '<li><i class="fa fa-envelope bg-blue"></i>';
                  }
                  str += '<div class="timeline-item">'+
                  '<span class="time"><i class="fa fa-clock-o"></i>'+ list[i].logdate+'</span>'+
                  '<h3 class="timeline-header">'+
                  '<a href="#">'+ list[i].nickname+'</a>'+
                  '<div class="timelinebtn">';
                  if (list[i].post_status != 0) {
                     str += '<a class="repost'+page+'">댓글달기</a>';                  
                  }
                  if ('${sessionScope.nickname}' == list[i].nickname) {
                     str += '<a class="change"> 수정</a>'+
                     '<a class="btn btn-danger btn-xs" href="${pageContext.request.contextPath}/post/delete.do?post_id='+list[i].post_id+'&cn=${ch.ch_id}">Delete</a>';
                  }
                  str +='</div>'+
                  '</h3>'+
                  '<div class="timeline-body">'+list[i].content+'</div>';
                  if (list[i].file_thumbnail != 'x') {
                     str += '<img src="${pageContext.request.contextPath}/resources/img/'+list[i].file_thumbnail + '" class="margin"> <br>';
                  }
                  if (list[i].file_original != 'x') {
                     str += '<a href="${pageContext.request.contextPath}/post/download.do?fileName='+list[i].file_original+'">'+ list[i].fileName+'</a>';
                  }
                  for (var j = 0; j < repost.length; j++) {
                     if (list[i].post_id == repost[j].repost_id) {
                        if (repost[j].post_status == 0) {
                           str += '<div> 삭제된 댓글입니다. </div>';
                        } else {
                           str += '<div class="timeline-item">'+
                            '<span class="time"><i class="fa fa-clock-o"></i>'+ (new Date).yyyymmdd() +'</span>'+
                            '<a href="#">'+repost[j].nickname+'</a>'+
                            '<span class="timeline-body" >'+repost[j].centent+'</span>'+
                            '<a class="btn btn-danger btn-xs"'+
                            'href="${pageContext.request.contextPath}/post/delete.do?post_id='+repost[j].post_id+'&cn=${ch.ch_id}" id="delete">Delete</a>'+
                            '</div>';
                        }
                     }
                  }
                  str += '<a href="${pageContext.request.contextPath}/post/list.do?page=1&cn='+list[i].channel_id+'"> <iclass="fa fa-asterisk">채널</i></a>';
                  str += '</div></li>';
                  var logdate = $('#'+list[i-1].logdate).val();
                     if (logdate == undefined) {
                        if (list[i].logdate != list[i-1].logdate) {
                        str += '<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>';
                        }
                     } else {
                        $('#'+list[i-1].logdate).remove();
                        $('#div').prepend('<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>');                  
                     }
                  }
                  $("#div").prepend(str);
                }
               if (logdate == undefined) {
                  $('#div').prepend('<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>');
               } else {
                  $('#'+list[i-1].logdate).remove();
                  $('#div').prepend('<li class="time-label" id="'+list[i-1].logdate+'"><span class="bg-red">'+ list[i-1].logdate+'</span></li>');                  
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
   $(function(){
       $('.repost1').on('click',function(){
          var repostA = $(this);
          var str = "<div class='repostdata'>";
          str += "<hr><p>댓글</p>" +
          '<input type="text" value=""/>' +
          '<button class="repostCencel">취소</button>' +
          '<button class="repostOk">완료</button>' +
          '</div>';
          $(this).parent().parent().next('div.timeline-body').after(str);
          repostA.hide();
       $('.repostCencel').on('click',function(){   
         repostA.show();
         $(this).parent('.repostdata').remove();
      });
      $('.repostOk').on('click',function(){
         var repostOk = $(this);
         var repostContent = $(this).prev().prev().val();
         var postID = $(this).parent().prev(".timeline-body").attr("id");
         var repostAppend = $(this).parent().parent();
          $.ajax({
            type : "post",
              url : "<%=request.getContextPath()%>/post/repost.do",
              data : { content: repostContent, repost_id: postID, channel_id:'${ch.ch_id}'},
              dataType : "json",
                 error : function(){
                 },
              success : function(data){
              var str = '<div class="timeline-item">';
              str += '<span class="time"><i class="fa fa-clock-o"></i>'+ (new Date).yyyymmdd() +'</span>'+
              '<a href="#">'+data.nickName+'</a>'+
              '<span class="timeline-body" >'+repostContent+'</span>'+
              '<a class="btn btn-danger btn-xs"'+
              'href="${pageContext.request.contextPath}/post/delete.do?post_id='+data.post_id+'&cn=${ch.ch_id}" id="delete">Delete</a>'+
              '</div>';
              repostAppend.append(str);
              }
         });
          $(this).parent('.repostdata').remove();
          repostA.show();
         });
       });
    }); 
 Date.prototype.yyyymmdd = function(){
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString();
    var dd = this.getDate().toString();
    return yyyy +"-"+(mm[1] ? mm : '0'+mm[0])+"-"+(dd[1] ? dd : '0'+dd[0]);
};
var repostok = 2;
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
   $('.repost'+''+(page-1)).on('click',function(){
         var repostA = $(this);
         var str = "<div class='repostdata'>";
         str += "<hr><p>댓글</p>" +
         '<input type="text" value=""/>' +
         '<button class="repostCencel">취소</button>' +
         '<button class="repostOk">완료</button>' +
         '</div>';
         $(this).parent().parent().next('div.timeline-body').after(str);
         repostA.hide();
      $('.repostCencel').on('click',function(){   
      repostA.show();
      $(this).parent('.repostdata').remove();
      });
   $('.repostOk').on('click',function(){
      var repostOk = $(this);
      var repostContent = $(this).prev().prev().val();
      var postID = $(this).parent().prev(".timeline-body").attr("id");
      var repostAppend = $(this).parent().parent();
       $.ajax({
         type : "post",
           url : "<%=request.getContextPath()%>/post/repost.do",
           data : { content: repostContent, repost_id: postID, channel_id:'${ch.ch_id}'},
           dataType : "json",
              error : function(){
                  alert('실패 ㅠ');
              },
           success : function(data){
           var str = '<div class="timeline-item">';
           str += '<span class="time"><i class="fa fa-clock-o"></i>'+ (new Date).yyyymmdd() +'</span>'+
           '<a href="#">'+data.nickName+'</a>'+
           '<span class="timeline-body" >'+repostContent+'</span>'+
           '<a class="btn btn-danger btn-xs"'+
           'href="${pageContext.request.contextPath}/post/delete.do?post_id='+data.post_id+'&cn=${ch.ch_id}" id="delete">Delete</a>'+
           '</div>';
           repostAppend.append(str);
           }
      });
       $(this).parent('.repostdata').remove();
       repostA.show();
      });
   });
}
</script>
</div>
                  </html>