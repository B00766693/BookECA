<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
         .button {
         background-color: #1c87c9;
         border: none;
         color: white;
         padding: 8px 10px;
         text-align: center;
         text-decoration: none;
         display: inline-block;
         float: right;
         font-size: 20px;
         margin: 4px 2px;
         cursor: pointer;
         }
         h2 {
  		position: absolute;
  		left: 205px;
  		top: 38px;
		}
		.button2{
         background-color: #33cc33;
         border: none;
         color: white;
         padding: 8px 10px;
         text-align: center;
         text-decoration: none;
         display: inline-block;
         float: right;
         font-size: 20px;
         margin: 4px 2px;
         cursor: pointer;
         }
      </style>
<title>DSP ECA Booking</title>
</head>
<body>
<img src="images/2465.jpg" alt="DSP Logo" width="175" height="100" >
<a href="timetable.jsp" class="button">Timetable</a>
<a href="classInfo.jsp" class="button">Class Info</a>

<h2> Welcome To The DSP Extra Curricular Activities Booking System  </h2><br><br>

<form action= "<%= request.getContextPath() %>/register" method="post"> <!-- NEED TO PUT ACTION STUFF IN HERE -->
	<fieldset>
	<legend>Student Information </legend>
	First name:  <input type="text" name="firstName" size="20" >
	Last name:  <input type="text" name="lastName" size="20">
	<select name="schoolClass">
		<option value ="junior">Junior Infants</option>
		<option value ="senior">Senior Infants</option>
		<option value ="first">First Class</option>
	</select>
	<br><br>
	<input type="submit" class="button2" value="Submit"/>
</fieldset>
</form>


</body>
</html>