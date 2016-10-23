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

 <form action="/ofysign" method="post">

	  <p>Title of blog post</p>

	  <div><textarea name="title" rows="1" cols="60"></textarea></div>

	  <p>Content of blog post</p>

      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Submit Blog Post" /></div>
      
      <a href="ofyguestbook.jsp"><button type="button">Cancel</button></a>

      <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

    </form>