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

		Content: Link to full room list

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

	#!ROOMNAME!#

		Content: Current Room name

		Example:
			Common_chat

	#!MESSAGELIST!#

		Content: Message List

		Row:
			<font color="#?FONTMSGCOLOR?#"> #?MSGAUTHOR?# @ #?MSGAUTHORFIRSTNAME?# #?MSGAUTHORSECONDNAME?# </font>: #?MESSAGECONTENT?#<br>

		Parameters:

			#?FONTMSGCOLOR?#

				Content: User name fonr color

				Variants:

					User is admin:
						#d4f

					User is room owner, but not admin:
						#0cb

					Else:
						#081

			#?MSGAUTHOR?#

				Content: message author name

				Example:
					kron22

			#?MSGAUTHORFIRSTNAME?#

				Content: message author's first name

				Example:
					Alexandr

			#?MSGAUTHORSECONDNAME?#

				Content: message author's second name

				Example:
					Mikheev

			#?MESSAGECONTENT?#

				Content: message content

				Example:
					sample message

	#!USERLIST#!

		Content: List of users allowed to room

		Row:
			#?ICONOWNER?# #?ICONADMIN?#  <font color="#?FONTUSERCOLOR?#">#?USRNAME?#</font> ( #?USRFIRSTNAME?# #?USRSECONDNAME?#, <font color="#00f">#?USRPOST?#</font> )<br>

		Parameters:

			#?ICONOWNER?#

				Content: Owner user icon

				Variants:

					User is not room owner: (empty string)

					User is room owner:
						<i class="icon-user"></i>

			#?ICONADMIN?#

				Content: Admin user icon

				Variants:

					User is not admin: (empty string)

					User is admin:
						<i class="icon-wrench"></i>

			#?FONTUSERCOLOR?#

				Content: color of username

				Variants:
					
					User is admin:
						#d4f

					User is room owner, but not admin:
						#0cb

					Else:
						#081

			#?USRNAME?#

				Content: username

				Example:
					kron22

			#?USRFIRSTNAME?#

				Content: user's first name

				Example:
					Alexandr

			#?USRSECONDNAME?#

				Content: user's second name

				Example:
					Mikheev

			#?USRPOST?#

				Content: user's position

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
	roomname = '#!ROOMNAME!#';

	function messageInputKeyCheck( keyboardInfo ){
		if( keyboardInfo.keyCode == 13 ) messageSend();
	}

	function messageSend(){
		document.getElementById('messageInput').value = '';
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
			<h3 id="roomname">
				Room #!ROOMNAME!#
			</h3>
			<div class="container">
				<div class="well span8" style="height: 400px; overflow-y: scroll; text-align: left; word-wrap: break-word;" id="messagelist">
					#!MESSAGELIST!#
				</div>
				<div class="well span2" style="height:400px; overflow-y: scroll; overflow-x: scroll; font-size: 9pt; text-align: left;" id="roomuserlist">
					#!USERLIST!#
				</div>
				<div class="container" id="messageform">
					<input type="text" class="span8 search-query" id="messageInput" placeholder="Your message" onkeyup="messageInputKeyCheck(event)">
					<button class="btn btn-primary" id="messagesubmit" onclick="messageSend()">Send</button>
				</div>
			</div>
		</div>
	</div>

</body>

</html>