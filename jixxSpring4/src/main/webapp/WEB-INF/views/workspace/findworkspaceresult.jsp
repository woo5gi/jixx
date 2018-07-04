<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <c:set var="represult" value="${rep_list}"/>
<c:forEach var="aa" items="${repidlist}">${aa}</c:forEach>
<c:forEach var="aa" items="${usernamelist}">${aa}</c:forEach>
<c:forEach var="aa" items="${repnamelist}">${aa} <input type="button" value="가입신청"></c:forEach>
${errorresult}

