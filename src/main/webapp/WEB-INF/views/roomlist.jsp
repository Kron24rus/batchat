<!--

	#!FULLROOMLISTLINK!#

		Content: Link to full room list (current page)

		Example:
			fullroomlist.html
			roomlist.html?mode=full

	#!MYROOMLISTLINK!#

		Content: Link to User's own room list

		Example:
			myroomlist.html
			roomlist.html?mode=my

	#!CREATEROOMLINK!#

		Content: Link to creating new room

		Example:
			createroom.html

	#!USERINFOLINK!#

		Content: Link to current user info

		Example:
			userinfo.html

	#!LOGOUTLINK!#

		Content: Log out link

		Example:
			logout.html

	#!ADMINCREATEUSERLINK!#

		Content: Admin's create user link

		Example:
			createuser.html
			admin.html?mode=create

	#!ADMINMODIFYUSERLINK!#

		Content: Admin's modify user link

		Example:
			modifyuser.html
			admin.html?mode=modify

	#!ROOMLIST!#

		Content: Room List

		Row:
			<tr class="#?TRCLASS?#">
				<td>#?ROOMNAME?#</td>
				<td>#?ROOMOWNER?#</td>
				<td>#?ROOMACCESSMODE>#</td>
				<td>
					#?ROOMENTERBUTTON?#
					#?ROOMMODIFYBUTTON?#
					#?ROOMDELETEBUTTON?#
				</td>
			</tr>

		Row Parameters:

			#?TRCLASS?#

				Content: row class

				Variants:
					User can modify and delete room:

						info

					User can only enter the room:

						success

					User cannot even enter the room:

						error

			#?ROOMNAME?#

				Content: room name

				Example:
					Common_chat

			#?ROOMOWNER?#

				Content: name of the room's owner

				Example:
					kron22

			#?ROOMACCESSMODE?#

				Content: room access mode

				Variants:
					private
					public

			#?ROOMENTERBUTTON?#

				Content: button to enter the room

				Variants:
					User cannot enter: (empty string)

					User can enter:

						<a class="btn btn-success" href="#$ROOMENTERLINK$#"><i class="icon-arrow-up icon-white"></i>Enter</a>

				Parameters:

					#$ROOMENTERLINK$#

						Content: room enter link

						Example:
							room.html?name=Common_chat
							room.html?name=Common_chat&act=enter

			#?ROOMMODIFYBUTTON?#

				Content: button to modify the room

				Variants:
					User cannot modify: (empty string)

					User can modify:

						<a class="btn btn-warning" href="#$ROOMMODIFYLINK$#"><i class="icon-wrench icon-white"></i>Modify</a>

				Parameters:

					#$ROOMMODIFYLINK$#

						Content: room modify link

						Example:
							modifyroom.html?name=Common_chat
							room.html?name=Common_chat&act=modify

			#?ROOMDELETEBUTTON?#

				Content: button to delete the room

				Variants:
					User cannot delete: (empty string)

					User can delete:

						<a class="btn btn-danger" href="javascript:deleteAgreement('#$ROOMNAME$#','#$ROOMDELETELINK$#')"><i class="icon-remove icon-white" ></i>Delete</a>

				Parameters:
					#$ROOMNAME$#

						Content: room name

						Example:
							Common_Chat

					#$ROOMDELETELINK$#

						Content: link to delete room

						Example:
							deleteroom.html?name=Common_chat
							room.html?name=Common_chat&act=delete
!-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!doctype html>

<html>
<head>
	<title>Bat Chat</title>
	<link href="<c:url value="css/bootstrap.css"/>" rel="stylesheet">
	<link href="<c:url value="css/style.css"/>" rel="stylesheet">
	<script src="<c:url value="js/jquery-1.11.3.min.js" />"></script>
	<script src="<c:url value="js/bootstrap.js" />"></script>
</head>

<script type="text/javascript">
	function deleteAgreement( roomName, roomDeleteLink )
	{
		document.getElementById('modalMessage').innerHTML = 'Are you sure you want to delete room <font color="red">' + roomName + '</font>?';
		document.getElementById('modalftr2').innerHTML = '<a class="btn btn-success" data-dismiss="modal" aria-hidden="true" href="' + roomDeleteLink + '" >Yes</a> <a class="btn btn-danger" data-dismiss="modal" aria-hidden="true">No</a>';
		$('#myModal').modal();
	}
	function formSubmit() {
		document.getElementById("logoutForm").submit();
	}
</script>

<body id="thebody">

	<!-- scrt for log out -->
	<form action="/logout" method="post" id="logoutForm">
		<input type="hidden"
			   name="${_csrf.parameterName}"
			   value="${_csrf.token}"/>
	</form>

	<!-- Navigation bar !-->
	<div class="navbar navbar-static navbar-inverse navbar-fixed-top" id="navbar">
		<div class="navbar-inner">
			<div class="container" style="width: auto;">
				<a class="brand" style="color: #fff;"> &nbsp;Bat Chat</a>
				<ul class="nav" role="navigation">
					<li class="dropdown" align="left">
						<a class="dropdown-toggle" role="button" data-toggle="dropdown" style="color: #fff;">
							<i class="icon-th-list icon-white"></i>
							Rooms
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a id="get" href="/roomlist" tabindex="-1">
									<i class="icon-th-list"></i>
									Room List
								</a>
							</li>
							<li>
								<a href="/myroomlist" tabindex="-1">
									<i class="icon-user"></i>
									My Rooms
								</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="/createroom" tabindex="-1">
									<i class="icon-plus"></i>
									Create Room
								</a>
							</li>
						</ul>
					</li>
				</ul>

				<sec:authorize access="hasRole('ROLE_ADMIN') and isAuthenticated()">
					<ul class="nav" role="navigation">
						<li class="dropdown" align="left" id="adminlist">
							<a class="dropdown-toggle" role="button" data-toggle="dropdown" style="color: #fff;">
								<i class="icon-wrench icon-white"></i>
								Admin Tools
								<b class="caret"></b>
							</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="/createuser" tabindex="-1">
										<i class="icon-plus"></i>
										Create User
									</a>
								</li>
								<li>
									<a href="/modifyuser" tabindex="-1">
										<i class="icon-edit"></i>
										Modify/Delete User
									</a>
								</li>
							</ul>
						</li>
					</ul>
				</sec:authorize>

				<ul class="nav pull-right" role="navigation">
					<li class="dropdown" align="left">
						<a class="dropdown-toggle" id="username" role="button" data-toggle="dropdown"  style="color: #fff;"> 
							<i class="icon-user icon-white"></i>
								${pageContext.request.userPrincipal.name}
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="/userinfo?username=${pageContext.request.userPrincipal.name}" tabindex="-1">
									<i class="icon-user"></i>
									User Info
								</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="javascript:formSubmit()" tabindex="-1">
									<i class="icon-remove"></i>
									Log Out
								</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<!-- Content !-->
	<div id="content"></div>
	<div class="container">
		<div class="span12" id="allcontent">
			<table class="table table-hover table-striped table-bordered">
				<thead id="roomlisthead">
					<tr>
						<th>Room Name</th>
						<th>Owner</th>
						<th>Access Mode</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody id="roomlistbody">
					<h3>${rooms}</h3>
					<c:forEach items="${roomlist}" var="item">
						<c:if test="${pageContext.request.userPrincipal.name == item.user.userName and rooms=='My rooms'}">
						<tr class="info">
							<td>
								<c:out value="${item.roomName}"></c:out>
							</td>
							<td>
								<c:out value="${item.user.userName}"></c:out>
							</td>
							<td>
								<c:choose>
									<c:when test="${item.isPrivate()==true}">
										private
									</c:when>
									<c:otherwise>
										public
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<a class="btn btn-success" href="/roomchat?roomname=${item.roomName}">
									<i class="icon-arrow-up icon-white"></i>
									Enter
								</a>
								<sec:authorize access="hasRole('ROLE_ADMIN') and isAuthenticated()">
									<a class="btn btn-warning" href="/modifyroom">
										<i class="icon-wrench icon-white"></i>
										Modify
									</a>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_USER') and isAuthenticated()">
									<c:if test="${pageContext.request.userPrincipal.name == item.user.userName}">
										<a class="btn btn-warning" href="/modifyroom">
											<i class="icon-wrench icon-white"></i>
											Modify
										</a>
									</c:if>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_ADMIN') and isAuthenticated()">
									<a class="btn btn-danger" href="/deleteroom?roomname=${item.roomName}">
										<i class="icon-remove icon-white"></i>
										Delete
									</a>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_USER') and isAuthenticated()">
									<c:if test="${pageContext.request.userPrincipal.name == item.user.userName}">
										<a class="btn btn-danger" href="/deleteroom?roomname=${item.roomName}">
											<i class="icon-remove icon-white"></i>
											Delete
										</a>
									</c:if>
								</sec:authorize>
							</td>
						</tr>
						</c:if>
						<c:if test="${rooms=='All rooms'}">
							<tr class="info">
								<td>
									<c:out value="${item.roomName}"></c:out>
								</td>
								<td>
									<c:out value="${item.user.userName}"></c:out>
								</td>
								<td>
									<c:choose>
										<c:when test="${item.isPrivate()==true}">
											private
										</c:when>
										<c:otherwise>
											public
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<a class="btn btn-success" href="/roomchat?roomname=${item.roomName}">
										<i class="icon-arrow-up icon-white"></i>
										Enter
									</a>
									<sec:authorize access="hasRole('ROLE_ADMIN') and isAuthenticated()">
										<a class="btn btn-warning" href="/modifyroom">
											<i class="icon-wrench icon-white"></i>
											Modify
										</a>
									</sec:authorize>
									<sec:authorize access="hasRole('ROLE_USER') and isAuthenticated()">
										<c:if test="${pageContext.request.userPrincipal.name == item.user.userName}">
											<a class="btn btn-warning" href="/modifyroom">
												<i class="icon-wrench icon-white"></i>
												Modify
											</a>
										</c:if>
									</sec:authorize>
									<sec:authorize access="hasRole('ROLE_ADMIN') and isAuthenticated()">
										<a class="btn btn-danger" href="/deleteroom?roomname=${item.roomName}">
											<i class="icon-remove icon-white"></i>
											Delete
										</a>
									</sec:authorize>
									<sec:authorize access="hasRole('ROLE_USER') and isAuthenticated()">
										<c:if test="${pageContext.request.userPrincipal.name == item.user.userName}">
											<a class="btn btn-danger" href="/deleteroom?roomname=${item.roomName}">
												<i class="icon-remove icon-white"></i>
												Delete
											</a>
										</c:if>
									</sec:authorize>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>

			<!-- Modal element !-->
			<div class="modal hide fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-body" id="modalMessage">
				</div>
				<div class="modal-footer" id="modalFooter">
				</div>
			</div>
		</div>
	</div>

</body>

</html>