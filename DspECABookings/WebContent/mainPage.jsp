
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link   href="asset/css/style.css" rel="stylesheet">

<title>DSP ECA Booking</title>
</head>
<body>
<img src="asset/images/2465.jpg" alt="DSP Logo" width="175" height="100" >
<a href="timetable.jsp" class="button">Timetable</a>
<a href="classInfo.jsp" class="button">Class Info</a>


<h2> Welcome To The DSP Extra Curricular Activities Booking System  </h2><br><br>



<form  action= "<%= request.getContextPath() %>/register" method="get">
	<fieldset>
	<legend>Student Information:     </legend>
	First name*:  <input type="text" name="firstName" size="20" required >
	Last name*:  <input type="text" name="lastName" size="20" required>
	<select name="schoolClass">
		<option value ="Junior Infants">Junior Infants</option>
		<option value ="Senior Infants">Senior Infants</option>
		<option value ="First Class">First Class</option>
		<option value ="Second Class">Second Class</option>
		<option value ="Third Class">Third Class</option>
		<option value ="Fourth Class">Fourth Class</option>
		<option value ="Fifth Class">Fifth Class</option>
		<option value ="Sixth Class">Sixth Class</option>
	</select>
	<br><br>
	Parent name*:  <input type="text" name="parentName" size="20" required >
	<div class="tooltip">Mobile No.*:<span class="tooltiptext">Ensure your mobile number has 10 digits and starts with 08</span>  <input type="tel" name="telNo" size="20" pattern="[0-9]{10}" required> <small>Format: 08xxxxxxxx (no spaces)</small>
	</div>
</fieldset>

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
  
  <c:forEach var="activity" items="${listActivity}">
                <tr>
                    <td><c:out value="${activity.dayOn}" /></td>
                    <td><c:out value="${activity.activityName}" /></td>
                    <td><c:out value="${activity.classTime}" /></td>
                    <td><c:out value="${activity.eligibility}" /></td>
                    <td><c:out value="${activity.noOfWeeks}" /></td>
                    <td>€<c:out value="${activity.cost}" /></td>
                    <td><c:out value="${activity.maxClassSize}" /> </td>
                    <td><c:out value="${activity.spacesAvailable}" /></td>
                    <td><input type= "checkbox" name="bookingCode" value="${activity.aId}" /></td>
                </tr>
            </c:forEach>
  </table>	
</fieldset>
  
<h4> click on submit (below) , to confirm your booking  </h4>
<input type="submit" class="button2" value="Submit"/>

</form>


</body>
</html>