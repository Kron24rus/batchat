<!--

	#!USERNAME!#

		Content: Name of the current user

		Example:
			kron22

	#!ADMINTOOLSLIST!#

		Content: Links for Admin

		Variants:
			User is Admin:

				<ul class="nav" role="navigation">
					<li class="dropdown" align="left" id="adminlist">
						<a class="dropdown-toggle" role="button" data-toggle="dropdown" style="color: #fff;">
							<i class="icon-wrench icon-white"></i>
							Admin Tools
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="#!ADMINCREATEUSERLINK!#" tabindex="-1">
									<i class="icon-plus"></i>
									Create User
								</a>
							</li>
							<li>
								<a href="#!ADMINMODIFYUSERLINK!#" tabindex="-1">
									<i class="icon-edit"></i>
									Modify/Delete User
								</a>
							</li>
						</ul>
					</li>
				</ul>

			User is Not Admin:

				<ul class="nav" role="navigation">
					<li class="dropdown">
						<a class="dropdown-toggle" id="username" role="button" style="color: #333;">
							<i class="icon-wrench"></i>
							Admin Tools
							<b class="caret"></b>
						</a>
					</li>
				</ul>

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

	#!ADMINSTATUS!#

		Content: info about administrator status

		Variants:

			User is not admin: (empty string)

			User is admin:
				<div class="control-group">
					<p class="text-error">
						<button class="btn btn-small"  rel="popover" data-placement="right" data-trigger="hover" title="Administrator rights" data-content="Administrator can enter every private room, modify or delete every room. Also administrator can create users, modify or delete rhem.">
							<i class="icon-wrench" ></i>
						</button>
						Administrator
					</p>
				</div>

	#!USERFIRSTNAME!#

		Content: user's first name

		Example:
			Alexandr

	#!USERSECONDNAME!#

		Content: user's second name

		Example:
			Mikheev

	#!USERPOST!#

		Content: user's post

		Example:
			Software Developer
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
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</head>


<script type="text/javascript">
	$(function(){
		$("[rel='popover']").popover( { delay: { show: 100, hide: 100 } } );
	});
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
								<c:out value="${pageContext.request.remoteUser}"></c:out>
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="/userinfo" tabindex="-1">
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
	<div class="container">
		<div class="span12" id="allcontent">
			<h3>User ${pageContext.request.userPrincipal.name}</h3>
			#!ADMINSTATUS!#
			<div class="control-group">
				<p class="text-info">
					<i class="icon-font"></i>
					#!USERFIRSTNAME!# #!USERSECONDNAME!#
				</p>
			</div>
			<div class="control-group">
				<p class="text-success">
					<i class="icon-user"></i>
					#!USERPOST!#
				</p>
			</div>
		</div>
	</div>

</body>

</html>