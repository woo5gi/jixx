<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ch_list" value="${ch_list}"/>
<c:set var="user_list" value="${user_list}"/>
  
    <!-- Main Footer -->
    <footer class="main-footer">
      <!-- To the right -->
      <form class="form-horizontal" action="<%= request.getContextPath() %>/post/write.do" method="post" enctype="multipart/form-data">
        <div class="row form-group">
          <div class="col col-md-12">
            <div class="input-group">
              <div class="input-group-btn">
                <div class="btn-group">
                  <button type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn btn-primary"><i class="fa fa-plus-square"></i>&nbsp;</button>
                  <div tabindex="-1" aria-hidden="true" role="menu" class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, -12px, 0px); top: -134px; left: 0px; will-change: transform;">
                    <li class="header btnlist">Code or text snippet</li>
                    <li class="header btnlist">Post</li>
                    <li class="header btnlist">Your computer<input type="file" name="file"></li>
                  
                 </div>
                  <br>
                </div>
              </div>
              <input type="hidden" name="ch_list" value="${ch_list}">
              <input type="hidden" name="nicknamelist" value="${nicknamelist}">
              <input type="text" id="input3-group3" name="content" placeholder=".." class="form-control">
              <div class="input-group-btn">
                <div class="btn-group">
                  <button type="submit" class="btn btn-outline-secondary">Secondary</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </form>
  </footer>