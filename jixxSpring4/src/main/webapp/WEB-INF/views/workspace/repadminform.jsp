<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('input.deletech').on('click', function() {		
			var channelname = $(this).prev('label.ch_name').text().trim();
			var conresult = confirm("정말 삭제하시겠습니까.");
			if(conresult == true){
				$(location).attr('href', '${pageContext.request.contextPath}/deletech.do?chname='+channelname);		
			}
			else if(conresult == false){
			  document.write("취소를 누르셨군요.");
			}
			
		});
		// 	        $(THIS).PARENT('LI.ADDDEDEMAIL').NEXT().REMOVE(); // REMOVE THE <BR>
		// 			$(THIS).PARENT('LI.ADDDEDEMAIL').REMOVE();
		$('.changeadminlevel').on('click', function() {
			alert('asdf');
		})

	});
</script>
</head>

<body>

	<c:choose>
		<c:when test="${adminlevel eq 2 }">
			<c:forEach var="aa" items="${chlist}">
				<li><label class="ch_name">${aa.ch_name}</label><input type="button" value="삭제"
					class="deletech"></li>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:forEach var="aa" items="${chlist}">
				<li><label class="ch_name">${aa.ch_name}</label><input type="button" value="삭제"
					class="deletech"></li>
			</c:forEach>
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
		</c:otherwise>
	</c:choose>
</body>