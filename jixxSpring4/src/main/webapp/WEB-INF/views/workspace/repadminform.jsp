<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('input.deletech').on('click', function() {
			var channelname = $(this).prev('label.ch_name').text().trim();
			
			var ch_id = $(this).prev('input[name=ch_id]').val();
			var conresult = confirm("정말 삭제하시겠습니까.");
			if (conresult == true) {
				$(location).attr('href',"${pageContext.request.contextPath}/deletech.do?ch_id="+ch_id);			
			} else if (conresult == false) {
				return;
			}

		});
		// 	        $(THIS).PARENT('LI.ADDDEDEMAIL').NEXT().REMOVE(); // REMOVE THE <BR>
		// 			$(THIS).PARENT('LI.ADDDEDEMAIL').REMOVE();
		$('.changeadminlevel').on('click', function() {
			alert('asdf');
		})
		$('#deleterep').click(function(){
			var rep_id = $('input[name=rep_id]').val();
			var conresult = confirm("저장소를 정말 삭제하시겠습니까.");
			if (conresult == true) {
				$('#deleterepform').submit();
			} else if (conresult == false) {
				return;
			}			
		})
	});
</script>

</head>

<body>

	<c:choose>
		<c:when test="${adminlevel eq 2 }">
			<form id="channelform" action="${pageContext.request.contextPath}/deletech.do">
				<c:forEach var="aa" items="${chlist}" varStatus="status">
					<li><label class="ch_name">${aa.ch_name}</label>
					<input type="hidden" name="ch_id" value="${aa.ch_id}" class="ch_id ${status.count}">
						<input type="button" value="삭제" class="deletech ${status.count}"></li>
				</c:forEach>
			</form>
		</c:when>
		<c:otherwise>
			<form id="channelform" action="${pageContext.request.contextPath}/deletech.do">
				<c:forEach var="aa" items="${chlist}">
					<li><label class="ch_name">${aa.ch_name}</label><input type="text" name="ch_id"
						value="${aa.ch_id}" class="ch_id ${status.count}">
						<input type="button" value="삭제" class="deletech ${status.count}"></li>
				</c:forEach>
			</form>
			<form id="usermodform">
				<c:forEach var="aa" items="${um2list}">
					<c:choose>
						<c:when test="${aa.admin_level eq 2}">
							<li><label>${aa.nickname}</label> {aa.admin_level} <select><option value=1>일반사용자</option>
									<option value=2 selected="selected">중간관리자</option>
									<option value=3>저장소관리자</option>
							</select><input type="button" value="권한변경" class="changeadminlevel"><input type="button"
								value="추방" class="deleteuser"></li>
						</c:when>
						<c:when test="${aa.admin_level eq 3}">
							<li><label>${aa.nickname}</label> {aa.admin_level} <select>
									<option value=3 selected="selected">저장소관리자</option>
							</select></li>
						</c:when>
						<c:otherwise>
							<li><label>${aa.nickname}</label> {aa.admin_level} <select><option value=1
										selected="selected">일반사용자</option>
									<option value=2>중간관리자</option>
									<option value=3>저장소관리자</option>
							</select><input type="button" value="권한변경" class="changeadminlevel"><input type="button"
								value="추방" class="deleteuser"></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</form>
			<form id="deleterepform" action="${pageContext.request.contextPath}/emailauth.do">
			<label id="rep_name_lb">${r.rep_name}저장소</label><input type="hidden" name="rep_id" value="${r.rep_id}">
			<input type="hidden" name="requestfrom" value="deleterep">
			<input type="hidden" name="email" value="${m.email}">
			<input type="button" id="deleterep" value="저장소삭제">
			</form>
		</c:otherwise>
	</c:choose>
</body>