<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!doctype html>

<html>
<head>
	<title>Bat Chat</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</head>

<script language="JavaScript">
	function formSubmit() {
		document.getElementById("logoutForm").submit();
	}
</script>

<body id="thebody" onload="admintoolsinit()">
<!-- scrt for log out -->
<form action="/logout" method="post" id="logoutForm">
	<input type="hidden"
		   name="${_csrf.parameterName}"
		   value="${_csrf.token}"/>
</form>

<div class="navbar navbar-static navbar-inverse navbar-fixed-top" id="navbar">
	<div class="navbar-inner">
		<div class="container" style="width: auto;">
			<a class="brand" href="#" style="color: #fff;"> &nbsp;Bat Chat</a>
			<ul class="nav" role="navigation">
				<li class="dropdown" align="left">
					<a class="dropdown-toggle" role="button" href="#" data-toggle="dropdown" style="color: #fff;">
						<i class="icon-th-list icon-white"></i>
						Rooms
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu" role="menu">
						<li>
							<a href="/roomlist" tabindex="-1">
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
			<ul class="nav" role="navigation">
				<li class="dropdown" align="left" id="adminlist">
					<a class="dropdown-toggle" role="button" href="#" data-toggle="dropdown" style="color: #fff;">
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
			<ul class="nav pull-right" role="navigation">
				<li class="dropdown" align="left">
					<a class="dropdown-toggle" id="username" role="button" href="#" data-toggle="dropdown"  style="color: #fff;"> 
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

<div class="container">
	<div class="span12" id="allcontent">
		<table class="table table-hover table-striped table-bordered">
			<thead id="userlisthead">
				<tr>
					<th>User Name</th>
					<th>First & second name</th>
					<th>Post</th>
					<th>Role</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody id="userlistbody">
			<c:forEach items="${userlist}" var="item">

				<tr>
					<td>
						<c:out value="${item.userName}"></c:out>
					</td>
					<td>
						<c:out value="${item.getUserInfo().firstName}"></c:out>
						<c:out value="${item.getUserInfo().secondName}"></c:out>
					</td>
					<td>
						<c:out value="${item.getUserInfo().getPost().postName}"></c:out>
					</td>
					<td>
						<c:forEach items="${item.getRoles()}" var="role">
							<c:if test="${role.role=='ROLE_ADMIN'}">
								<span class="text-error">Admin</span>
							</c:if>
							<c:if test="${role.role=='ROLE_USER'}">
								<span class="text-info">User</span>
							</c:if>
						</c:forEach>
					</td>
					<td>
						<!--	<a class="btn btn-success">
                                <i class="icon-refresh icon-white"></i>
                                Reset pass
                            </a> -->
						<a class="btn btn-warning" href="/modcurrentuser?username=${item.userName}">
							<i class="icon-wrench icon-white"></i>
							Modify
						</a>
						<c:if test="${pageContext.request.userPrincipal.name != item.userName}">
							<a class="btn btn-danger" href="/deleteuser?username=${item.userName}">
								<i class="icon-remove icon-white"></i>
								Delete
							</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="modal hide fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-body" id="modalmsg2">Are you sure you want to delete this user?</div>
			<div class="modal-footer" id="modalftr2"></div>
		</div>
	</div>
</div>

</body>
</html>