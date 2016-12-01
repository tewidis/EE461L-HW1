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
	<div class="row">
        <div class="col-xs-12 text-center">
            <img src="http://i.imgur.com/vsfyUpj.png" alt="Logo">
        </div>
	</div>
    <div class="row">
        <div class="col-xs-12 text-center">
            <h1>Welcome to NoQ!</h1>
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
            ObjectifyService.register(Customer.class);
            ObjectifyService.register(Parameter.class);
            String id = request.getParameter("cID");
            if(request.getParameter("cID")==null){
                id = "0";
            }
            pageContext.setAttribute("cid", id);
            %>
	            <p>-${fn:escapeXml(cid)}-</p>
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
            	<p id="pos"> </p>
            </div>
        </div>
	</div>
	<div class="row">
        <div class="col-xs-12 text-center">
        	<div class="text">
            	<p style="display:inline">Estimated wait time: <p style="display:inline" id="avgTime"> </p><p style="display:inline"> minutes</p>
            </div>
        </div>
	</div>
	<div class="row">
        <div class="col-xs-12 text-center">
            <!--<input type="button" value="Refresh" onClick="window.location.reload()"> -->
        	<form style="display:inline" >
        	   <input type="submit" value="Cancel" onClick="stopTimer()">
        	</form>
        </div>
	</div>
	<div class="row">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
        var myVar = setInterval(function(){ myTimer() }, 250);
        var notification=0;
        function Redirect() {
               window.location="/thankYou.jsp";
        }
        function myTimer() {
            var cid=<%= pageContext.getAttribute("cid") %>
             $.post("position", { orderId : cid},
                function(position) {
                document.getElementById("pos").firstChild.nodeValue = position;
                if(position<=0 && notification==0){
                    alert("It's Your Turn!");
                    notification=1;
                    Redirect();
                }

             });
            var avg=<%= pageContext.getAttribute("waitTime") %>
            $.post("param", { orderId : cid},
                function(avgTime) {
                document.getElementById("avgTime").firstChild.nodeValue = avgTime;
                //alert(avgTime);
             });


        }
        function stopTimer() {
            var cid=<%= pageContext.getAttribute("cid") %>
            $.get("dismissCustomer",{ orderId : cid},
                function(position){
                  window.location="/thankYou.jsp";
                }); 

        }
    </script>
	
    <!--jQuery (necessary for Bootstrap's JavaScript plugins) -->
    
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  </body>
</html>





