
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

<form action= "<%= request.getContextPath() %>/register" method="post"> 
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


  
<h4> click on submit (below) and you will be taken to the Classes and Activities page, where you can select your chosen extra curricular activities  </h4>
<input type="submit" class="button2" value="Submit"/>

<br><br>
</form>

</body>
</html>