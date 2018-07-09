<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../template/header.jsp" flush="false"/>

<div class="bg">
  <div class="centered">
    <div class="box box-primary">
      <div class="box-header with-border">
        <h3 class="box-title">Create a new workspace</h3>
      </div>

      <form role="form" action="${pageContext.request.contextPath }/emailauth.do" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="form-group">
            <label>Your email address</label> 
                    <c:set var="m" value="${m}"/>
                      <input type="text" name="email" placeholder="" class="form-control" value="${m.email}" readonly>
                          <input type="hidden" name="requestfrom" value="createws">
          </div>
        </div>

        <div class="box-footer">
        <button type="submit" class="btn btn-block btn-primary">인증번호전송</button>
        </div>
      </form>
    </div>
  </div>
</div>

<%--     <div class="content-wrapper" style="min-height: 863px;">
      <div class="container">
        <!-- Main content -->
        <section class="content">
          <div class="col-lg-16">
            <div class="card">
              <div class="card-body card-block">
                <h3>Create a new workspace</h3>
                <br>
                <label class="control-label mb-1">Your email address</label>
                <form action="${pageContext.request.contextPath }/emailauth.do" method="post" class="form-horizontal">
                  <div class="row form-group">
                    <div class="col-6">
                    <c:set var="m" value="${m}"/>
                      <input type="text" name="email" placeholder="" class="form-control"
                      value="${m.email}">
                          <input type="hidden" name="requestfrom" value="createws">
                    </div>
                  </div>
                    <button type="submit" class="btn btn-block btn-primary btn-lg">인증번호전송</button>
                </form>
                <br>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div> --%>
</body>
</html>