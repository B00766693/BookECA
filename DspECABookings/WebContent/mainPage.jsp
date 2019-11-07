
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="mystyle.css">
<title>DSP ECA Booking</title>
</head>
<body>
<img src="images/2465.jpg" alt="DSP Logo" width="175" height="100" >
<a href="timetable.jsp" class="button">Timetable</a>
<a href="classInfo.jsp" class="button">Class Info</a>

<h2> Welcome To The DSP Extra Curricular Activities Booking System  </h2><br><br>

<form action= "<%= request.getContextPath() %>/register" method="post"> <!-- NEED TO PUT ACTION STUFF IN HERE -->
	<fieldset>
	<legend>Student Information:     </legend>
	First name:  <input type="text" name="firstName" size="20" >
	Last name:  <input type="text" name="lastName" size="20">
	<select name="schoolClass">
		<option value ="junior">Junior Infants</option>
		<option value ="senior">Senior Infants</option>
		<option value ="first">First Class</option>
		<option value ="second">Second Class</option>
		<option value ="third">Third Class</option>
		<option value ="fourth">Fourth Class</option>
		<option value ="fifth">Fifth Class</option>
		<option value ="sixth">Sixth Class</option>
	</select>
	<br><br>
	Parent name:  <input type="text" name="parentName" size="20" >
	Tel No.:  <input type="text" name="telNo" size="20">
</fieldset>



<fieldset>
	<legend>Classes And Activities :     </legend>
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
  
  <sql:setDataSource
        var="myDS"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/mysql_database"
        user="root" password="aisling"
    />

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
                    <td><input type = "checkbox" name="bookingCode" value="${user.ecaCode}"></td>
                </tr>
            </c:forEach>
  

  </table>
	
</fieldset>

<input type="submit" class="button2" value="Submit"/>

</form>


</body>
</html>