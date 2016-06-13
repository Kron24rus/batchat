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

	#!PRIVATEUSERLIST!#

		Content: List of users allowed to room

		Row:
			<tr>
				<td>
					#?USRLOGIN?# ( #?USRFIRSTNAME?# #?USRSECONDNAME?#, #?USRPOST?# ) 
				</td>
				<td>
					<input type="checkbox" id="#?CHKBOXID?#" value="#?CHKBOXID?#">
				</td>
			</tr>

		Parameters:

			#?USRLOGIN?#

				Content: user login

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

				Content: user's post

				Example:
					Software Developer

			#?CHKBOXID?#

				Content: checkbox id

				Example:
					kron22_checkbox
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

	roomNameCorrectMessage = 'Name is correct';
	roomNameEmptyMessage = 'Name is empty';
	roomNameIncorrectMessage = 'Name is incorrect. Allowed symbols: A-Za-z0-9_';

	allowedSymbolsString = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_';

	function checkString( value ){
		for( i in value ){
			if( allowedSymbolsString.indexOf( value[i] ) == -1 ) return false;
		}
		return true;
	}

	function roomNameCheck(){
		roomNameString = document.getElementById('roomNameInput').value;

		RNC = document.getElementById('roomNameContainer');
		RNM = document.getElementById('roomNameMessage');
		CRB = document.getElementById('createRoomButton');

		if( roomNameString == '' ){
			RNC.className = 'control-group error';
			RNM.innerHTML = roomNameEmptyMessage;
			if( ! CRB.disabled ){
				CRB.disabled = true;
				CRB.className = CRB.className + ' disabled';
			}
		}
		else if( ! checkString( roomNameString ) ){
			RNC.className = 'control-group error';
			RNM.innerHTML = roomNameIncorrectMessage;
			if( !CRB.disabled ){
				CRB.disabled = true;
				CRB.className = CRB.className + ' disabled';
			}
		}
		else{
			RNC.className = 'control-group success';
			RNM.innerHTML = roomNameCorrectMessage;
			if( CRB.disabled ){
				CRB.disabled = false;
				CRB.className = CRB.className.replace('disabled');
			}
		}
	}

	function toggleUserList(){
		if( document.getElementById('isRoomPrivate').checked ){
			document.getElementById('userListContainer').style.visibility = 'visible';
		}
		else{
			document.getElementById('userListContainer').style.visibility = 'hidden';
		}
	}
	function formSubmit() {
		document.getElementById("logoutForm").submit();
	}
</script>

<body id="thebody" onload="roomNameCheck()">
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
								${pageContext.request.userPrincipal.name}
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
			<h3>Create room</h3>

			<form>
				<div class="control-group" id="roomNameContainer">
					<div class="input-prepend">
						<span class="add-on">
							<i class="icon-font"></i>
						</span>
						<input class="span3" id="roomNameInput" type="text" placeholder="Room name" onchange="roomNameCheck()" onkeyup="roomNameCheck()">
					</div><br>
					<span class="help-inline" id="roomNameMessage"></span>
				</div>
				<div class="control-group"><div class="input-prepend">
					<label class="checkbox">
						<input type="checkbox" id="isRoomPrivate" value="isRoomPrivate" onchange="toggleUserList()">
							Private
						</label>
					</div>
				</div>
				<div class="control-group" id="userListContainer" style="visibility:hidden;">
					<table>
						<tbody>
							#!PRIVATEUSERLIST!#
						</tbody>
					</table>
				</div>
				<div class="control-group" id="createroombutton">
					<input type="submit" class="btn btn-primary disabled" disabled value="Create" id="createRoomButton">
				</div>
			</form>

			<div class="modal hide fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-body" id="modalmsg">
				</div>
				<div class="modal-footer">
					<a class="btn btn-success" data-dismiss="modal" aria-hidden="true" href="#!FULLROOMLISTLINK!#">
						All rooms list
					</a>
					<a class="btn btn-success" data-dismiss="modal" aria-hidden="true" href="#!MYROOMLISTLINK!#">
						My rooms list
					</a>
					<a class="btn btn-primary" data-dismiss="modal" aria-hidden="true">
						Back to creating
					</a>
				</div>
			</div>

		</div>
	</div>

</body>

</html>