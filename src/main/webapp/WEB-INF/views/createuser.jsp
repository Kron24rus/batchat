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
function input_check(elementName){
	s = document.getElementById(elementName).value;
	s = s.replace(/[^-_^A-Z^0-9]/gim, '');
	document.getElementById(elementName).value = s;
	return s;
}
function formSubmit() {
	document.getElementById("logoutForm").submit();
}
function fullinput_check()
{

	str2 = input_check('fnameinput');
	str3 = input_check('snameinput');
	<c:choose>
		<c:when test="${requestScope['javax.servlet.forward.servlet_path']=='/createuser'}">
			str4 = input_check('passwordinput');
			str = input_check('usernameinput');
		</c:when>
		<c:otherwise>
			str4 = 'userpassword'
			str = 'username'
		</c:otherwise>
	</c:choose>

	if( str == '' || str2 == '' || str3 == '' || str4 == '' )
		document.getElementById('createuserbutton').innerHTML = '<button class="btn btn-primary disabled" disabled="disabled" onclick="usercreate()">${buttonaction}</button>';
	else
		document.getElementById('createuserbutton').innerHTML = '<button class="btn btn-primary" onclick="usercreate()">${buttonaction}</button>';
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
		<h3>${actiononuser}</h3>
		<form:form action="${formaction}" method="post" modelAttribute="userForm">
			<div class="control-group">
				<div class="input-prepend">
					<span class="add-on">
						<i class="icon-user"></i>
					</span>
					<c:if test="${requestScope['javax.servlet.forward.servlet_path']=='/createuser'}">
						<form:input path="userName" cssClass="span3" id="usernameinput" type="text" placeholder="User name" onkeyup="fullinput_check()" onchange="fullinput_check()" />
					</c:if>
					<c:if test="${requestScope['javax.servlet.forward.servlet_path']=='/modcurrentuser'}">
						<form:input path="userName" cssClass="span3" readonly="true"></form:input>
					</c:if>
				</div>
			</div>

			<div class="control-group">
				<div class="input-prepend">
					<span class="add-on">
						<i class="icon-asterisk"></i>
					</span>
					<form:password path="password" cssClass="span3" id="passwordinput" placeholder="User password" onkeyup="fullinput_check()" onchange="fullinput_check()"/>
				</div>
			</div>
			<div class="control-group">
				<div class="input-prepend">
					<span class="add-on">
						<i class="icon-font"></i>
					</span>
					<form:input path="firstName" cssClass="span3" id="fnameinput" type="text" placeholder="First name" onkeyup="fullinput_check()" onchange="fullinput_check()"/>
				</div>
			</div>
			<div class="control-group">
				<div class="input-prepend">
					<span class="add-on">
						<i class="icon-font"></i>
					</span>
					<form:input path="secondName" cssClass="span3" id="snameinput" type="text" placeholder="Second name" onkeyup="fullinput_check()" onchange="fullinput_check()"/>
				</div>
			</div>
			<div class="control-group">
				<div class="input-prepend">
					<span class="add-on">
						<i class="icon-tags"></i>
					</span>
					<form:select path="postName" items="${postList}" class="span3"/>
				</div>
			</div>
			<div class="control-group">
				<div class="input-prepend">
					<label class="checkbox">
						<form:checkbox path="role" id="isuseradmin"/> Admin
					</label>
				</div>
			</div>
			<div class="control-group" id="createuserbutton">
				<button class="btn btn-primary disabled" disabled="disabled" onclick="usercreate()">${buttonaction}</button>
			</div>
		</form:form>
		<script>
			fullinput_check();
		</script>
	</div>
</div>

</body>
</html>