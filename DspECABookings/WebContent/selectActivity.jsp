<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page import="net.aisling.javaee.ParticipantDao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <link rel="stylesheet" href="mystyle.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select The Activities and Classes</title>
</head>
<body>
<img src="images/2465.jpg" alt="DSP Logo" width="175" height="100" >
<a href="classInfo.jsp" class="button">Class Info</a>

<%
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
%>
<h2>Select the Activities and Classes you want to book for <%= firstName%>:  </h2><br>
<h3>Click on the checkboxes below the calendar to book</h3>

<p align="center"><iframe src="https://calendar.google.com/calendar/embed?src=ds94lfp2ln2h53bj5kn0qpe9b0%40group.calendar.google.com&ctz=Europe%2FDublin" style="border: 0" width="650" height="300" frameborder="0" scrolling="no"></iframe></p>

<sql:setDataSource
        var="myDS"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/mysql_database"
        user="root" password="aisling"
    />
    


<form action= "bookingDetails.jsp" method="post"> 

<fieldset>
	<legend>Classes and Activities :     </legend>
	<table>
  <tr>
    <th>Day</th>
    <th>Name</th>
    <th>Time</th>
    <th>Eligible</th>
    <th>Weeks</th>
    <th>Cost</th>
    <th>Places</th>
    <th>Available</th>
    <th>Book</th>
  </tr>
  

<sql:query var="listUsers"   dataSource="${myDS}">
        SELECT * FROM ecas;
    </sql:query>
  
  <c:forEach var="user" items="${listUsers.rows}">
                <tr>
                    <td><c:out value="${user.dayOfWeek}" /></td>
                    <td><c:out value="${user.activityName}" /></td>
                    <td><c:out value="${user.classTime}" /></td>
                    <td><c:out value="${user.eligibility}" /></td>
                    <td><c:out value="${user.noOfWeeks}" /></td>
                    <td><c:out value="${user.cost}" /></td>
                    <td><c:out value="${user.maxClassSize}" /></td>
                    <td><c:out value="${user.spacesAvailable}" /></td>
                    <td><input type = "checkbox" name="bookingCode" value="${user.activityId}" ></td>
                </tr>
            </c:forEach>
            
  
  </table>	
</fieldset>
  
<!-- page goes to bookingDetails -->

<input type="submit" class="button2" value="Submit"/> <!-- ???NEED TO HAVE SECOND OPTION in SERVLET -->






<br><br>
</form>
</body>
</html>
