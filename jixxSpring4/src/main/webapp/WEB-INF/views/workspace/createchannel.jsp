<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		$('.userlist').click(function() {
			/* 닉네임버튼누르면
			input태그 안에 value로 들어가게하고,a태그삭제한다.
			 */

			var user = $('.userlist').text().trim();
			$('#invite').val(user);

		})
	});
</script>


<div class="bg">
  <div class="centered">
    <div class="box box-primary">
      <div class="box-header with-border">
        <h3 class="box-title">Create a channel</h3>
      </div>
      <label class="form-text text-muted">Channels are where your members communicate.
									They're best when organized around a topic-#leads,for example</label>

      <form role="form"  action="${pageContext.request.contextPath}/addchannel.do" method="post"
									class="form-horizontal" id="form">
        <div class="box-body">
        <label class="switch switch-3d switch-warning mr-3">
        <input type="checkbox"class="switch-input" name="chtype"> 
        <span class="switch-label"></span>
        <span class="switch-handle"></span></label> 
        <label class="text-muted">private</label>
          <div class="form-group">
            <label>name</label> <input type="text" name="chtitle" placeholder="e.g.leads" class="form-control">
          </div>
          <div class="form-group">
            <label>Send invates to:(optional)</label> <input type="text" name="invate" placeholder="Search by name" class="form-control">
											<c:forEach var="r" items="${usernamelist}" varStatus="status">
											<a class="userinvite" class="userlist" id="user${status.count}">${r}</a>											
											</c:forEach>
          </div>
        </div>

        <div class="box-footer">
          <button type="reset" class="btn btn-primary" style="width: 49%">Cancle</button>
          <button type="submit" form="form" class="btn btn-primary " style="width: 49%">Create Channel</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>