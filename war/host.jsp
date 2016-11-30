<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.List"%>
<%@ page import ="noQ.Customer" %>
<%@ page import ="noQ.Parameter" %>
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
    <%
            ObjectifyService.register(Customer.class);
            ObjectifyService.register(Parameter.class);
            String id = request.getParameter("cID");
            if(request.getParameter("cID")==null){
                id = "0";
            }
            pageContext.setAttribute("cid", id);
            Integer position = (Integer.parseInt(id) - Customer.served);
            pageContext.setAttribute("position", position);
            pageContext.setAttribute("waitTime", (position*Parameter.avgWaitTime));
            pageContext.setAttribute("avgWaitTime", Parameter.avgWaitTime);
            pageContext.setAttribute("customerServed", Customer.served);
            pageContext.setAttribute("customerWaiting",Customer.customerWaiting);
            %>
    <div class="row">
        <div class="col-xs-12 text-center">
            <img src="http://i.imgur.com/vsfyUpj.png" alt="Logo">
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 text-center">
            <h1>Host</h1>
        </div>
    </div>
    
    <div class="row">
        <div class="col-xs-12 text-center">
            <div class="text">
                <p style="display:inline">Customers Waiting: -<p style="display:inline" id="cWaiting"> </p><p style="display:inline">-</p>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-xs-12 text-center">
            <div class="text">
                <p style="display:inline">Customers served: -<p style="display:inline" id="cServed"> </p><p style="display:inline">-</p>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-xs-12 text-center">
            <p style="display:inline">Average Time (mins): </p>
            <form action="param" method="get" style="display:inline">
                <input type="text" name="avgWaitTime" value="${fn:escapeXml(avgWaitTime)}" maxlength="3" size="3"> 
                <input type="submit" value="Set">
            </form>
            
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-xs-12 text-center">
            <input type="button" value="Refresh" onClick="window.location.reload()">
            <form action="/dismissHost" style="display:inline">
                <input type="submit" value="Next">
            </form>   
            <form action="/reset" style="display:inline">
               <input type="submit" value="Reset">
            </form>
        </div>
    </div>
    <div class="row">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        var myVar = setInterval(function(){ myTimer() }, 250);
        var notification=0;
       
        function myTimer() {
            $.get("cWaitServlet",
                function(cWaiting) {
                document.getElementById("cWaiting").firstChild.nodeValue = cWaiting;  
             });
             $.get("cServedServlet",
                function(cServed) {
                document.getElementById("cServed").firstChild.nodeValue = cServed;  
             });              

        }
    </script>
    <!--jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  </body>
</html>





