<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp" flush="false" />
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
/* 	$(function() {
		alert('a');
		$('#search').on('click',function() {
			alert("a");
			var content = $('#searchvalue').val();
			if (content == '') {
				alert("내용을입력하세요");
			} else {
				$('#form').submit();
			}
		});
	}); */
</script>
<div class="bg">
	<div class="centered">
	<div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Find Workspace</h3>
            </div>
            <div class="box-body no-padding">
              <table class="table table-striped">
                <tbody>
                <tr>
                  <th>NO.</th>
                  <th>멤버</th>
                  <th>저장소이름</th>
                  <th>가입</th>
                </tr>
                
                <tr>
               	<c:set var="represult" value="${rep_list}"/>
                <td><c:forEach var="aa" items="${repidlist}">${aa}</c:forEach></td>
                <td><c:forEach var="aa" items="${usernamelist}">${aa}&nbsp;&nbsp;</c:forEach></td>
                <c:forEach var="aa" items="${repnamelist}">
                <td> ${aa}</td>
                <td><input type="button" value="가입신청"></td>
                </c:forEach>
                </tr>
                
                <tr>
                <td colspan="4" class="text-red" style="text-align: center;">${errorresult}</td>
                </tr>
                              
                </tbody>
                </table>
            </div>
          </div>
		
	</div>
</div>

</body>
</html>

<%-- 
<c:set var="represult" value="${rep_list}"/>
<c:forEach var="aa" items="${repidlist}">${aa}</c:forEach>
<c:forEach var="aa" items="${usernamelist}">${aa}</c:forEach>
<c:forEach var="aa" items="${repnamelist}">${aa} <input type="button" value="가입신청"></c:forEach>
${errorresult}
 --%>

