<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%-- 
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<jsp:include page="../template/header.jsp" flush="false" />

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<style type="text/css">
.centered1 {
	display: table;
	margin-left: auto;
	margin-right: auto;
	width: 980px;
	padding-top: 8%;
}

.listbox {
	overflow-y: scroll;
	height: 350px;
}

.callout {
	background-color: #001f3f;
}

.bg-navy {
	margin: 0px;
}

.listyle {
	border-radius: 2px;
	padding: 10px;
	background: #f4f4f4;
	margin-bottom: 2px;
	border-left: 2px solid #e6e7e8;
	color: #444;
}
</style>

<script type="text/javascript">
	$(function() {
		$('input.deletech').on(
				'click',
				function() {
					var channelname = $(this).prev('label.ch_name').text()
							.trim();

					var ch_id = $(this).prev('input[name=ch_id]').val();
					var conresult = confirm("정말 삭제하시겠습니까.");
					if (conresult == true) {
						$(location).attr(
								'href',
								"${pageContext.request.contextPath}/deletech.do?ch_id="
										+ ch_id);
					} else if (conresult == false) {
						return;
					}
				});
		$('#deleterep').click(function() {
			var rep_id = $('input[name=rep_id]').val();
			var conresult = confirm("저장소를 정말 삭제하시겠습니까.");
			if (conresult == true) {
				$('#deleterepform').submit();
			} else if (conresult == false) {
				return;
			}
		})
		$('.changeadminlevel').on(
				'click',
				function() {
					var selectoption = $('#selectbox option:selected').val();
					var id = $(this).prev().prev('input[name=id]').val();
					var rep_id = $(this).prev('input[name=rep_id]').val();
					$(location).attr(
							'href',
							"${pageContext.request.contextPath}/changeadminlevel.do?admin_level="
									+ selectoption + "&rep_id=" + rep_id
									+ "&id=" + id);

				})
		$('#repout')
				.on(
						'click',
						function() {
							var conresult = confirm("저장소를 정말 탈퇴하시겠습니까.");
							if (conresult == true) {
								$(location)
										.attr('href',
												"${pageContext.request.contextPath}/repout.do");
							} else if (conresult == false) {
								return;
							}

						})

	});
</script>
<div class="bg">
  <div class="centered1">
     <c:choose>

    <div class="callout ">
      <form id="deleterepform"
        action="${pageContext.request.contextPath}/emailauth.do">
        <h2 id="rep_name_lb" style="text-align: center; color: #fff">${r.rep_name}저장소</h2>
      </form>
    </div>
    
     <c:when test="${adminlevel eq 1 }">
            <input type="button" id="repout" value="저장소탈퇴">
     </c:when>
     
     
       <div class="row">
      <div class="col-md-6">
     <c:when test="${adminlevel eq 2 }">
        <div class="box listbox">
          <div class="box-header with-border">
            <h3 class="box-title">Channel List</h3>
          </div>

          <div class="box-body no-padding">
           <form id="channelform" action="${pageContext.request.contextPath}/deletech.do">
            <ul class="nav nav-pills nav-stacked">
             <c:forEach var="aa" items="${chlist}" varStatus="status">
            <li class="listyle">
                  <label class="ch_name">${aa.ch_name}</label> <input type="hidden" name="ch_id"
                     value="${aa.ch_id}" class="ch_id ${status.count}"> 
                 <span class="pull-right">
                 <input type="button" value="삭제"
                     class="deletech ${status.count}">
              </span>
               </li>
               </c:forEach>
            </ul>
               </form>
          </div>

        </div>
        </c:when>
        
        
        <c:otherwise>
        
          <div class="box listbox">
          <div class="box-header with-border">
            <h3 class="box-title">Channel List</h3>
          </div>

          <div class="box-body no-padding">
           <form id="channelform" action="${pageContext.request.contextPath}/deletech.do">
            <ul class="nav nav-pills nav-stacked">
             <c:forEach var="aa" items="${chlist}" varStatus="status">
            <li class="listyle">
                  <label class="ch_name">${aa.ch_name}</label> <input type="hidden" name="ch_id"
                     value="${aa.ch_id}" class="ch_id ${status.count}"> 
                 <span class="pull-right">
                 <input type="button" value="삭제"
                     class="deletech ${status.count}">
              </span>
               </li>
               </c:forEach>
            </ul>
               </form>
          </div>

        </div>
        
        
         <div class="box listbox">
          <div class="box-header with-border">
            <h3 class="box-title">Member List</h3>
          </div>
            <form id="usermodform">
               <c:forEach var="aa" items="${um2list}">
                  <c:choose>
                     <c:when test="${aa.admin_level eq 2}">
                     <ul class="nav nav-pills nav-stacked">
                        <li class="listyle"><label>${aa.nickname}</label> {aa.admin_level} <select id="selectbox"><option
                                 value=1>일반사용자</option>
                              <option value=2 selected="selected">중간관리자</option>
                              <option value=3>저장소관리자</option>
                        </select><input type="hidden" name="id" value="${aa.id}"> <input type="hidden" name="rep_id"
                           value="${aa.rep_id}"> <input type="button" value="권한변경" class="changeadminlevel"><input
                           type="button" value="추방" class="deleteuser"></li>
                           </ul>
                     </c:when>
                     <c:when test="${aa.admin_level eq 3}">
                     <ul class="nav nav-pills nav-stacked">
                        <li class="listyle"><label>${aa.nickname}</label><select>
                              <option value=3 selected="selected">저장소관리자</option>
                        </select>
                        </li>
                        </ul>
                     </c:when>
                     <c:otherwise>
                     <ul class="nav nav-pills nav-stacked">
                        <li class="listyle"><label>${aa.nickname}</label><select id="selectbox"><option value=1
                                 selected="selected">일반사용자</option>
                              <option value=2>중간관리자</option>
                              <option value=3>저장소관리자</option>
                        </select><input type="hidden" name="id" value="${aa.id}"> <input type="hidden" name="rep_id"
                           value="${aa.rep_id}"><input type="button" value="권한변경" class="changeadminlevel"><input
                           type="button" value="추방" class="deleteuser"></li>
                           </ul>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
            </form>
            
            
         </c:otherwise>
      </div>
    </div>
    
<%--             <form id="deleterepform" action="${pageContext.request.contextPath}/emailauth.do">
               <label id="rep_name_lb">${r.rep_name}저장소</label><input type="hidden" name="rep_id"
                  value="${r.rep_id}"> <input type="hidden" name="requestfrom" value="deleterep">
               <input type="hidden" name="email" value="${m.email}"> <input type="button"
                  id="deleterep" value="저장소삭제">
            </form> --%>
         
     
 <!--    
    <div class="row">
      <div class="col-md-6">
        <div class="box listbox">
          <div class="box-header with-border">
            <h3 class="box-title">Channel List</h3>
          </div>

          <div class="box-body no-padding">
            <ul class="nav nav-pills nav-stacked">
              <li class="listyle">United States of America 
              <span class="pull-right">
                  <button type="button" class="btn btn-block btn-danger btn-xs">Danger</button>
              </span>
              </li>
            </ul>
          </div>

        </div>
      </div>
    </div> -->
    
    
    </c:choose>
  </div>
</div>

    <%--   <c:choose>
         <c:when test="${adminlevel eq 1 }">
            <input type="button" id="repout" value="저장소탈퇴">
         </c:when>
         <c:when test="${adminlevel eq 2 }">
            <form id="channelform" action="${pageContext.request.contextPath}/deletech.do">
               <c:forEach var="aa" items="${chlist}" varStatus="status">
                  <li><label class="ch_name">${aa.ch_name}</label> <input type="hidden" name="ch_id"
                     value="${aa.ch_id}" class="ch_id ${status.count}"> <input type="button" value="삭제"
                     class="deletech ${status.count}"></li>
               </c:forEach>
               <input type="button" id="repout" value="저장소탈퇴">
            </form>
         </c:when>
         
         <c:otherwise>
            <form id="channelform" action="${pageContext.request.contextPath}/deletech.do">
               <c:forEach var="aa" items="${chlist}">
                  <li><label class="ch_name">${aa.ch_name}</label><input type="hidden" name="ch_id"
                     value="${aa.ch_id}" class="ch_id ${status.count}"> <input type="button" value="삭제"
                     class="deletech ${status.count}"></li>
               </c:forEach>
            </form>
            <form id="usermodform">
               <c:forEach var="aa" items="${um2list}">
                  <c:choose>
                     <c:when test="${aa.admin_level eq 2}">
                        <li><label>${aa.nickname}</label> {aa.admin_level} <select id="selectbox"><option
                                 value=1>일반사용자</option>
                              <option value=2 selected="selected">중간관리자</option>
                              <option value=3>저장소관리자</option>
                        </select><input type="hidden" name="id" value="${aa.id}"> <input type="hidden" name="rep_id"
                           value="${aa.rep_id}"> <input type="button" value="권한변경" class="changeadminlevel"><input
                           type="button" value="추방" class="deleteuser"></li>
                     </c:when>
                     <c:when test="${aa.admin_level eq 3}">
                        <li><label>${aa.nickname}</label><select>
                              <option value=3 selected="selected">저장소관리자</option>
                        </select></li>
                     </c:when>
                     <c:otherwise>
                        <li><label>${aa.nickname}</label><select id="selectbox"><option value=1
                                 selected="selected">일반사용자</option>
                              <option value=2>중간관리자</option>
                              <option value=3>저장소관리자</option>
                        </select><input type="hidden" name="id" value="${aa.id}"> <input type="hidden" name="rep_id"
                           value="${aa.rep_id}"><input type="button" value="권한변경" class="changeadminlevel"><input
                           type="button" value="추방" class="deleteuser"></li>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
            </form>
            <form id="deleterepform" action="${pageContext.request.contextPath}/emailauth.do">
               <label id="rep_name_lb">${r.rep_name}저장소</label><input type="hidden" name="rep_id"
                  value="${r.rep_id}"> <input type="hidden" name="requestfrom" value="deleterep">
               <input type="hidden" name="email" value="${m.email}"> <input type="button"
                  id="deleterep" value="저장소삭제">
            </form>
         </c:otherwise>
      </c:choose> --%>
      
<%-- 
<div class="bg">
	<div class="centered1">


		<div class="callout ">
			<form id="deleterepform"
				action="${pageContext.request.contextPath}/emailauth.do">
				<h2 id="rep_name_lb" style="text-align: center; color: #fff">${r.rep_name}저장소</h2>
			</form>
		</div>
		<c:choose>
			<div class="row">
				<div class="col-md-6">
					<div class="box listbox">
						<div class="box-header with-border">
							<h3 class="box-title">Channel List</h3>
						</div>

						<div class="box-body no-padding">
							<c:when test="${adminlevel eq 2 }">
								<form id="channelform"
									action="${pageContext.request.contextPath}/deletech.do">
									<c:forEach var="aa" items="${chlist}" varStatus="status">
										<ul class="nav nav-pills nav-stacked">
											<li class="listyle"><label class="ch_name">${aa.ch_name}</label>
												<input type="hidden" name="ch_id" value="${aa.ch_id}"
												class="ch_id ${status.count}"> <input type="button"
												value="삭제" class="deletech ${status.count}"></li>
										</ul>
									</c:forEach>
									<input type="button" id="repout" value="저장소탈퇴">
								</form>
							</c:when>
							<c:when test="${adminlevel eq 1 }">
								<input type="button" id="repout" value="저장소탈퇴">
							</c:when>
							<form id="channelform"
								action="${pageContext.request.contextPath}/deletech.do">
								<c:forEach var="aa" items="${chlist}">
									<ul class="nav nav-pills nav-stacked">
										<li class="listyle"><label class="ch_name">${aa.ch_name}</label>
											<input type="hidden" name="ch_id" value="${aa.ch_id}"
											class="ch_id ${status.count}"> <input type="button"
											value="삭제" class="deletech ${status.count}"></li>
									</ul>
								</c:forEach>
							</form>
						</div>

					</div>
				</div>


				<c:otherwise>
					<div class="col-md-6">
						<div class="box listbox">
							<div class="box-header with-border">
								<h3 class="box-title">Member List</h3>
							</div>

							<div class="box-body no-padding">
								<form id="usermodform">
									<c:forEach var="aa" items="${um2list}">
										<c:choose>
											<c:when test="${aa.admin_level eq 2}">
												<ul class="nav nav-pills nav-stacked">
													<li class="listyle"><label>${aa.nickname}</label>
														{aa.admin_level} <select id="selectbox"><option
																value=1>일반사용자</option>
															<option value=2 selected="selected">중간관리자</option>
															<option value=3>저장소관리자</option>
													</select> <input type="hidden" name="id" value="${aa.id}"> <input
														type="hidden" name="rep_id" value="${aa.rep_id}">
														<input type="button" value="권한변경" class="changeadminlevel">
														<input type="button" value="추방" class="deleteuser"></li>
												</ul>
											</c:when>
											<c:when test="${aa.admin_level eq 3}">
												<ul class="nav nav-pills nav-stacked">
													<li class="listyle"><label>${aa.nickname}</label> <select>
															<option value=3 selected="selected">저장소관리자</option>
													</select></li>
												</ul>
											</c:when>
											<c:otherwise>
												<ul class="nav nav-pills nav-stacked">
													<li class="listyle"><label>${aa.nickname}</label> <select
														id="selectbox">
															<option value=1 selected="selected">일반사용자</option>
															<option value=2>중간관리자</option>
															<option value=3>저장소관리자</option>
													</select> <input type="hidden" name="id" value="${aa.id}"> <input
														type="hidden" name="rep_id" value="${aa.rep_id}">
														<input type="button" value="권한변경" class="changeadminlevel">
														<input type="button" value="추방" class="deleteuser"></li>
												</ul>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form>
							</div>

						</div>
					</div>
			</div>



			</c:otherwise>
		</c:choose>
	</div>
</div> --%>
</body>
</html>