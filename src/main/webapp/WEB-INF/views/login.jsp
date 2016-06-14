<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
	<title>Bat Chat</title>
	<link href="<c:url value="css/bootstrap.css"/>" rel="stylesheet">
	<link href="<c:url value="css/style.css"/>" rel="stylesheet">
	<script src="<c:url value="js/jquery-1.11.3.min.js" />"></script>
	<script src="<c:url value="js/bootstrap.js" />"></script>
	<script src="<c:url value="js/bc-index.js"/>"></script>
</head>

<script type="text/javascript">
	isSignInButtonEnabled = false;

	loginButtonID = 'loginButton';
	userNameInputID = 'usernameInput';
	passwordInputID = 'passwordInput';


	function setEnabled( ){
		document.getElementById( loginButtonID ).className = document.getElementById( loginButtonID ).className.replace(' disabled', '');
		document.getElementById( loginButtonID ).type = "submit";
	}

	function setDisabled( ){
		document.getElementById( loginButtonID ).className = document.getElementById( loginButtonID ).className + ' disabled';
		document.getElementById( loginButtonID ).type = "button";
	}

	function checkInput(){
		isUserNameEmpty = document.getElementById( userNameInputID ).value == '';
		isUserPasswordEmpty = document.getElementById( passwordInputID ).value == '';
		isAnyFieldEmpty = isUserNameEmpty || isUserPasswordEmpty;

		if( isAnyFieldEmpty ){
			if( isSignInButtonEnabled ){
				setDisabled( );
				isSignInButtonEnabled = false;
			}
		}
		else{
			if( ! isSignInButtonEnabled ){
				setEnabled( );
				isSignInButtonEnabled = true;
			}
		}
	}
</script>


<body id="thebody">

	<!-- Navigation Bar !-->
	<div class="navbar navbar-static navbar-inverse navbar-fixed-top" id="navbar">
		<div class="navbar-inner">
			<div class="container" style="width: auto;">
				<a class="brand" style="color: #fff;"> &nbsp;Bat Chat</a>
				<ul class="nav pull-right" role="navigation">
					<li class="dropdown">
						<a class="dropdown-toggle" id="username" role="button" style="color: #333;"> 
							<i class="icon-user"></i>
							Not Logged In
							<b class="caret"></b>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<!-- Content !-->
	<div class="container">
		<div class="span12" id="allcontent">
			<form action="/login" method="post">
				<c:choose>
					<c:when test="${param.error ne null}">
						<div class="control-group" id="loginmsg">
							Invalid username and password!
						</div>
					</c:when>
					<c:when test="${param.logout ne null}">
						<div class="control-group" id="loginmsg">
							You have been logged out.
						</div>
					</c:when>
					<c:otherwise>
						<div class="control-group" id="loginmsg">
							Enter username and password
						</div>
					</c:otherwise>
				</c:choose>
				<div class="control-group">
					<div class="input-prepend">
						<span class="add-on">
							<i class="icon-user"></i>
						</span>
						<input class="span3" id="usernameInput" type="text" name="username" placeholder="User Name" onchange="checkInput()" onkeyup="checkInput()"/>
					</div>
				</div>
				<div class="control-group">
					<div class="input-prepend">
						<span class="add-on">
							<i class="icon-asterisk"></i>
						</span>
						<input class="span3" id="passwordInput" type="password" name="password" placeholder="Password" onchange="checkInput()" onkeyup="checkInput()"/>
					</div>
				</div>
				<div class="control-group">
					<input type="button" class="btn btn-primary disabled" id="loginButton" value="Sign In"/>
				</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}"/>
			</form>
		</div>
	</div>

</body>

</html>
