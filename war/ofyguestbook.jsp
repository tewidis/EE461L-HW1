<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="java.util.Collections" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="com.googlecode.objectify.*" %>

<%@ page import="guestbook.Greeting" %> 

<html>

   <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
 </head>

 

  <body>

<h1>Lavanya and Tanner's Blog</h1>

<img src="/images/blog.jpg" alt="Lavanya and Tanner's Blog" style="width:304px;height:228px;">
<div class="movedown">
<%

	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) {

        guestbookName = "default";

    }

    pageContext.setAttribute("guestbookName", guestbookName);

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

<%

    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

    
	ObjectifyService.register(Greeting.class);
	
	List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();   
	
	Collections.sort(greetings); 

    if (greetings.isEmpty()) {

        %>

        <p>Blog '${fn:escapeXml(guestbookName)}' has no messages.</p>

        <%

    } else {

        %>

        <p>Recent posts in Blog '${fn:escapeXml(guestbookName)}'.</p>

        <%
        int size;
		if(greetings.size() < 5) { size = greetings.size(); }
		else { size = 5; }
        for (int i = 0; i < size; i++) {
        	Greeting greeting = greetings.get(i);

            pageContext.setAttribute("greeting_content", greeting.getContent());
            
            pageContext.setAttribute("greeting_title", greeting.getTitle());

            if (greeting.getUser() == null) {

                %>

                <p>An anonymous person wrote:</p>

                <%

            } else {

                pageContext.setAttribute("greeting_user",

                                         greeting.getUser());

                %>

                <p><b>${fn:escapeXml(greeting_user.nickname)}</b> wrote:</p>

                <%

            }

			%>

            <blockquote>${fn:escapeXml(greeting_title)}</blockquote>

            <%

            %>

            <blockquote>${fn:escapeXml(greeting_content)}</blockquote>

            <%

        }

    }
%>

<div class="center">
<a href="entries.jsp">Click here to make a new blog post</a>
<br></br>
<a href="listall.jsp">Click here to see all blog posts</a>
<br></br>

<form action="/cron" method="post">
			    <%
			    if(guestbook.GAEJCronServlet.subscribedUsers.contains(user)) {
			    	%>
			    	<div><input type="submit" class="submitlink" value="Unsubscribe" /></div>
			    	<%
			    }
			    else {
			    	%>
			    	<div><input type="submit" class="submitlink" value="Subscribe" /></div>
			    	<%
			    }
			    %>
			      <input type="hidden" name="userName" value="${fn:escapeXml(userName)}"/>
</form>
</div>
</div>
<%

    } else {

%>

<p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>"><button>Sign in</button></a>

to include your name with greetings you post.</p>

<%

    }

%>

  </body>

</html>
