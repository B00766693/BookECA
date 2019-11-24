<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
 <link rel="stylesheet" href="mystyle.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Booking is Successful</h1>
<br><br>
<h2>You have booked <%
String firstName = request.getParameter("firstName");
String schoolClass = request.getParameter("schoolClass"); 
String parentName = request.getParameter("parentName"); 
int totalCost = 0;  //delare total cost variable  - how to get value?

out.println(firstName);
%></h2>

<br><br>
<p>Your booking for <%= firstName%>  <% %>  <% %>of <%= schoolClass%> into ;</p>

<fieldset>
	<legend>Classes and Activities :  Booked   </legend>
	<table>
  <tr>
    <th>Day</th>
    <th>Name</th>
    <th>Time</th>
    <th>Cost</th>
    
  </tr>
  <c:forEach var="activity" items="${listBookedActivity}">
                <tr>
                    <td><c:out value="${activity.dayOn}" /></td>
                    <td><c:out value="${activity.activityName}" /></td>
                    <td><c:out value="${activity.classTime}" /></td>
                    <td><c:out value="${activity.cost}" /></td>
                </tr>
            </c:forEach>
  </table>	
 </fieldset>
 <br>
 <h3>The amount due is <font color=blue> €<%= schoolClass%> <% %> €  <%= totalCost%></font> </h3> 

<p>
Please transfer the amount due to:<br><br>
DSP PTA<br>
Allied Irish Banks<br>
21 Castle Street Dalkey<br>
IBAN: IEAIBK933538123456789<br>
<br>
Please use  <span style="font-weight:bold"><%= parentName%></span> as a reference
</p>
</body>
</html>