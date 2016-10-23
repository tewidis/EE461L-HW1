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

<%

    String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) {

        guestbookName = "default";

    }

    pageContext.setAttribute("guestbookName", guestbookName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

	}

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
    	
		<p>Posts in Blog '${fn:escapeXml(guestbookName)}'.</p>

        <%

        for (Greeting greeting : greetings) {

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
<a href="ofyguestbook.jsp"><button type="button">Return</button></a>

</html>
