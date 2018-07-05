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
		
		var check = $("input[type='checkbox']");
		check.click(function(){
			$("p").toggle();
		});
	});
	
</script>
<style>
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
  vertical-align:middle;
}

/* Hide default HTML checkbox */
.switch input {display:none;}

/* The slider */
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
</style>

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
        <input type="checkbox"  name="chtype"><span class="slider round"></span></label>
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