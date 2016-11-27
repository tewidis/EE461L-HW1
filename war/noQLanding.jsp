<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.List"%>
<%@ page import ="noQ.CustomerCount" %>
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
    <title>NoQ</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>
  <body class="container">
	<div class="row">
        <div class="col-xs-12 text-center">
            <img src="/images/CHI'LANTRO_logo.jpg" alt="Logo">
        </div>
	</div>
    <div class="row">
        <div class="col-xs-12 text-center">
            <h1>Welcome to Chi'lantro!</h1>
        </div>
	</div>
	<div class="row">
        <div class="col-xs-12 text-center">
        	<div class="text">
            	<p>Your placard number is</p>
            </div>
        </div>
	</div>
	<div class="row">
        <div class="col-xs-12 text-center">
	        <div class="placard">
            <%
            ObjectifyService.register(CustomerCount.class);
            List<CustomerCount> customers = ObjectifyService.ofy().load().type(CustomerCount.class).list();
            pageContext.setAttribute("customer_number", customers.get(0).count);


            %>
	            <p>B${fn:escapeXml(customer_number)}</p>
	        </div>
        </div>
	</div>
	<div class="row">
        <div class="col-xs-12 text-center">
        	<div class="text">
            	<p>Your position in line is</p>
            </div>
        </div>
	</div>
	<div class="row">
        <div class="col-xs-12 text-center">
        	<div class="place">
            	<p>14</p>
            </div>
        </div>
	</div>
	<div class="row">
        <div class="col-xs-12 text-center">
        	<div class="text">
            	<p>Estimated wait time: 10 minutes</p>
            </div>
        </div>
	</div>
	<div class="row">
        <div class="col-xs-12 text-center">
        	<input type="submit" value="Refresh">
        	<input type="submit" value="Cancel">
        </div>
	</div>
	<div class="row">
    <!--jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  </body>
</html>





