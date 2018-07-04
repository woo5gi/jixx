<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<body>
	<form id="form" action="${pageContext.request.contextPath}/findworkspace.do">
		<input type="text" id="searchvalue" name="search"> <input type="submit" id="search" value="검색">
	</form>
</body>