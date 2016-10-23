<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.List"%>
<%@ page import="guestbook.Greeting" %>
<%@ page import ="guestbook.Subscriber" %>
<%@ page import ="guestbook.Log" %>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.googlecode.objectify.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Bird Bloggers' Bird Blog</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>
  <body class="container">
  <%
		String guestbookName = request.getParameter("guestbookName");
		if (guestbookName == null) {
			guestbookName = "default";
		}
		pageContext.setAttribute("guestbookName", guestbookName);
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
	%>
    <div class="row">
        <div class="col-xs-12 col-sm-9">
            <h1>Bird Bloggers' Bird Blog</h1>
        </div>
	    <div class="col-xs-12 col-sm-3" style="padding-top: 40px">
		<%
			if (user != null) {
				pageContext.setAttribute("user", user);
		%>
			Hello, ${fn:escapeXml(user.nickname)}! <a
				href="<%=userService.createLogoutURL(request.getRequestURI())%>">sign
				out.</a>
		<%
			} else {
		%>
			Hello! <a
				href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
				in</a> to post or subscribe.
		<%
			}
		%>
		</div>
	</div>
	<div class="row">
        <image src="http://i.imgur.com/ReLgaF7.jpg" class="col-xs-12">
        <div class="col-xs-2 col-xs-offset-10" style="font-size: 8px">
           <!-- <i>(Header Photo...)</i> -->
        </div>
    </div>
	<%
		ObjectifyService.register(Subscriber.class);
		ObjectifyService.register(Greeting.class);
		ObjectifyService.register(Log.class);
		List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();
		Collections.sort(greetings);
		if (greetings.isEmpty()) {
	%>
	<!-- <p>Guestbook '${fn:escapeXml(guestbookName)}' has no messages.</p> -->
	<p>No posts</p>
	<%
		} else {
	%>
	<!-- <p>Messages in Guestbook '${fn:escapeXml(guestbookName)}'.</p> -->
	<!-- <p>Posts</p> -->
	<p><a href="posts.jsp">see all posts.</a></p>
	<%
		int i = greetings.size() - 1;
		Greeting greeting = null;
		while(i >= 0) {
			if((greetings.size() - i) <= 3){
			greeting = greetings.get(i);
				pageContext.setAttribute("greeting_title", greeting.getTitle());
				pageContext.setAttribute("greeting_content", greeting.getContent());
				pageContext.setAttribute("greeting_date", greeting.getDate());
				if (greeting.getUser() == null) {
	%>
	<p>An anonymous person wrote:</p>
	<%
		} else {
					pageContext.setAttribute("greeting_user", greeting.getUser());
	%>
	<p>
		<b>${fn:escapeXml(greeting_user.nickname)}</b> wrote (${fn:escapeXml(greeting_date)}):
	</p>
	<%
		}
	%>
	<h3><b>${fn:escapeXml(greeting_title)}</b></h3>
	<blockquote>${fn:escapeXml(greeting_content)}</blockquote>
	<%
		}
		i -= 1;
		}
		}
		%>
		<p><a href="posts.jsp">see all posts.</a></p>
		<%
		if(user != null){
	%>
	<form action="/ofysign" method="post">
		<div>Title (required) </div>
		<div>
			<textarea name="title" rows="1" class="col-xs-12"></textarea>
		</div>
		<div> Body<div>
		<div>
			<textarea name="content" rows="10" class="col-xs-12"></textarea>
		</div>
		<div>
			<input type="submit" value="Submit" />
		</div>
		<input type="hidden" name="guestbookName"
			value="${fn:escapeXml(guestbookName)}" />
	</form>
	<%
	if (Subscriber.isSubscribed(user) != null) {
	%>
	<a href="/ofysub" method="post"> click to unsubscribe </a>
	<%
	} else {
	%>
	<a href="/ofysub" method="post"> click to subscribe to daily emails </a>
	<%
	}
	} else{
	%>
	<p>
	<a
				href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
				in</a> to post or subscribe.
	</p>

	<%
	}
	%>

    <!--jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  </body>
</html>





