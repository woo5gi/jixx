<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(function() {
		$('.deletech').on('click', function() {})
		

	});
</script>

<c:choose>
	<c:when test="${adminlevel eq 2 }">
		<c:forEach var="aa" items="${chlist}">
			<li><label>${aa.ch_name}</label><input type="button" value="삭제" class="deletech"></li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:forEach var="aa" items="${chlist}">
			<li><label>${aa.ch_name}</label><input type="button" value="삭제" class="deletech"></li>
		</c:forEach>
		<c:forEach var="aa" items="${nicknamelist}">
			<li><label>${aa}</label><select><option value=1>일반사용자</option>
					<option value=1>중간관리자</option>
					<option value=1>저장소대빵</option>
			</select><input type="button" value="권한변경" class="changeadminlevel"><input type="button"
				value="추방" class="deleteuser"></li>
		</c:forEach>
	</c:otherwise>
</c:choose>
