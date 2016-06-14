<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bat Chat</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/sockjs-0.3.4.js"></script>
    <script src="js/stomp.js"></script>
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script type="text/javascript">
        var stompClient = null;
        var usernames = {};
        var colors = [
            "#e32636", "#78dbe2", "#9f2b68",
            "#9966cc", "#44944a", "#2f4f4f",
            "#6a5acd", "#990066", "#79553d",
            "#003153", "#1e5945", "#a5260a",
            "#b03f35", "#957b8d", "#d87093",
            "#2a8d9c", "#62639b", "#480607",
            "#3e5f8a", "#cd7f32", "#6495ed",
            "#34c924", "#256d7b", "#00541f",
            "#c154c1", "#1a153f", "#474a51",
            "#1460bd", "#00693e", "#1e90ff",
            "#01796f", "#006633", "#ffd700",
            "#4b0082", "#1cd3a2", "#884535"
        ];

        function sleep(ms) {
            ms += new Date().getTime();
            while (new Date() < ms){}
        }

        function setConnected(connected) {
            document.getElementById('response').innerHTML = '';
        }

        function connect() {
            var socket = new SockJS('/hello');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function(frame) {
                stompClient.subscribe('/topic/greetings', function(greeting){
                    showGreeting(JSON.parse(greeting.body));
                });
                stompClient.subscribe('/topic/history', function(greeting){
                    showHistory(JSON.parse(greeting.body));
                });
            });
            sendHistoryQuery();
        }

        function disconnect() {
            if (stompClient != null) {
                stompClient.disconnect();
            }
            setConnected(false);
        }

        function getColor(username){
            if(usernames[username] === undefined){
                usernames[username] = colors[Math.floor(Math.random() * colors.length)];
                document.getElementById('roomuserlist').innerHTML = document.getElementById('roomuserlist').innerHTML +
                    '<b><code><font color="' + usernames[username] + '">' + username + '</font></code></b><br>';
            }
            return usernames[username];
        }

        function sendName() {
            var content = document.getElementById('content').value;
            if(content == '') return;
            stompClient.send("/app/hello", {}, JSON.stringify({ 'content': content }));
            document.getElementById('content').value = '';
        }

        function sendHistoryQuery(){
            if(stompClient.ws.readyState === SockJS.CONNECTING || stompClient.subscheck != 2)
                setTimeout(sendHistoryQuery, 100);
            else
                stompClient.send("/app/history", {}, JSON.stringify({ 'content': '' }));
        }

        function showGreeting(message) {
            document.getElementById('response').innerHTML = document.getElementById('response').innerHTML +
                '<b><code><font color="' + getColor(message.author) + '">' + message.author + '</font></code></b>: ' +
                message.content + '<br>';
            document.getElementById('response').scrollTop = document.getElementById('response').scrollHeight;
        }

        function showHistory(history){
            document.getElementById('response').innerHTML = '';
            for(i=0; i < history.authors.length; i++){
                showGreeting({"author": history.authors[i], "content": history.contents[i]});
            }
        }

        function messageInputKeyCheck( keyboardInfo ){
            if( keyboardInfo.keyCode == 13 ) sendName();
        }
        function formSubmit() {
            document.getElementById("logoutForm").submit();
        }
    </script>
</head>
<body onload="connect()" id="thebody">

     <!-- scrt for log out -->
     <form action="/logout" method="post" id="logoutForm">
         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
     </form>

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
            <h3 id="roomname">
                Room #!ROOMNAME!#
            </h3>
            <div class="container">
                <div class="well span8" style="height: 400px; overflow-y: scroll; text-align: left; word-wrap: break-word;" id="response">
                </div>
                <div class="well span2" style="height:400px; overflow-y: scroll; overflow-x: scroll; font-size: 9pt; text-align: left;" id="roomuserlist">

                </div>
                <div class="container" id="messageform">
                    <input type="text" class="span8 search-query" id="content" placeholder="Your message" onkeyup="messageInputKeyCheck(event)">
                    <button class="btn btn-primary" id="messagesubmit" onclick="sendName()">Send</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>