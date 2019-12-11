
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
<a href="<%= request.getContextPath() %>/download" class="button">Timetable</a>
<a href="classInfo.jsp" class="button">Class Info</a>
<a href="codeOfConduct.jsp" class="button">Code of Conduct</a>

<h2> Welcome To The DSP Extra Curricular Activities Booking System  </h2><br><br>
<p style="text-align:right;"><strong>Note:</strong>Click the <mark>right handside down arrow in calendar header</mark><br> to add/remove activities from the view</p>
<iframe style="floatright;"src="https://calendar.google.com/calendar/embed?height=400&amp;wkst=2&amp;bgcolor=%23B39DDB&amp;ctz=Europe%2FDublin&amp;src=dXRyaGs5c3QwZ3ZyM3ZtcHJyYnBuaWJvb2NAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&amp;src=NGJpOW1taG5lMHFrZ2x1aWJrcTFlbXNmbGdAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&amp;src=N3M2ZmZqZzE3anFscnBjMGh1ZXQ1dGZsbzBAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&amp;src=aTAzMnRzOWE5Y2U5cGl1YW1xOXZ1NDQ2dGtAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&amp;src=OTA3ZGpkaHVvZDR0aG82YWVybzZsZnRwM2dAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&amp;color=%23A87070&amp;color=%23D6AE00&amp;color=%233366CC&amp;color=%23227F63&amp;color=%233366CC&amp;title=Extra%20%20Curricular%20Activities&amp;showPrint=0&amp;showTabs=0&amp;showTz=0" style="border-width:0" width="1000" height="400" frameborder="0" scrolling="no"></iframe>

<form  action= "<%= request.getContextPath() %>/register" method="get">
	<fieldset>
	<legend>Student Information:     </legend>
	First name*:  <input type="text" name="firstName" size="20" required >
	Last name*:  <input type="text" name="lastName" size="20" required>
	<select name="schoolClass" id="schoolClass">
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
	<div class="tooltip">Mobile No.*:<span class="tooltiptext">Ensure your mobile number has 10 digits and starts with 08</span>  <input type="tel" name="telNo" size="20" pattern="[0-9]{10}"> <small>Format: 08xxxxxxxx (no spaces)</small>
	</div>
	<br><br>
	<label for="conduct">Agree to the Code of Conduct*:</label>  <input type= "checkbox" id="conduct" name="conduct" required> 	<br><br>
	Medical Information and/or Additional Needs*:  <input type="text" name="medInfo" size="100" required ><br><br>
	
	<div class="tooltip">Emergency Mobile No.* (alternate number):<span class="tooltiptext">Ensure your mobile number has 10 digits and starts with 08</span>  <input type="tel" name="AlternateTelNo" size="20" pattern="[0-9]{10}"> <small>Format: 08xxxxxxxx (no spaces)</small>
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
                    <td><input type= "checkbox" name="bookingCode" id="bookingCode" value="${activity.aId}" onclick="ValidateActivitySelection();"/></td>
                </tr>
            </c:forEach>
  </table>	
</fieldset>
  
<h4> click on submit (below) , to confirm your booking  </h4>
<input type="submit" class="button2" value="Submit"/>

</form>



<script type="text/javascript">  
function ValidateActivitySelection() {
	
	var checkboxes = document.getElementsByName("bookingCode");
	var chosenActivity;
	var schoolClass = document.getElementById("schoolClass").value;
	
	for(var i = 0; i < checkboxes.length; i++)   {  
        if(checkboxes[i].checked)  {
        	chosenActivity = (checkboxes[i].value);
        		if ((chosenActivity == 1) && ((schoolClass != "First Class") || (schoolClass != "Second Class"))){
        			checkboxes[i].checked = false;
        			alert("Only 1st & 2nd class eligible for Monday Basketball"); 
        			}
        		else {
        			if((chosenActivity == 3) && (schoolClass != "Third Class")){
        				checkboxes[i].checked = false;
        				alert("Only 3rd class eligible for Wednesday Basketball"); 
        			}
        			else{
        				if (((chosenActivity == 5) || (chosenActivity == 2))&& ((schoolClass == "Junior Infants") || (schoolClass == "Senior Infants")) ){
        					checkboxes[i].checked = false;
        					alert(" Junior & Senior Infants are not eligible for Arts & Crafts or Hockey"); 
            			}
     				}
				}
		}
	}
}



</body>
</html>