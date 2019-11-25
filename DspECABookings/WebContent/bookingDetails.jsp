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
<a href="timetable.jsp" class="button">Add Details to Calendar - placeholder of timetable.jsp</a>
<a href=<%= request.getContextPath() %>/register" class="button">Book Another Child</a>

<h1>Booking is Successful</h1>
 <%
String firstName = request.getParameter("firstName");
String schoolClass = request.getParameter("schoolClass"); 
String parentName = request.getParameter("parentName"); 
%> 
<h3>You have booked <font color=green> <%= firstName%> </font> <% %>  <% %>of <font color=green><%= schoolClass%> </font>into: </h3>


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
 <h3>The total amount due is <font color=blue>  <% %> €  <%= request.getAttribute("totalCost")%></font> </h3> 

<p>
Please transfer the amount due to:<br><br>
DSP PTA<br>
Allied Irish Banks<br>
21 Castle Street Dalkey<br>
IBAN: IEAIBK933538123456789<br>
<br>
Please use  <span style="font-weight:bold"><%= parentName%></span> as a reference in your bank transfer.
</p>


</body>
</html>