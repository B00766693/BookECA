<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="net.aisling.javaee.ParticipantDao.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import = "java.sql.*"%>
<link rel="stylesheet" href="mystyle.css">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking Details</title>
</head>
<body>
<img src="images/2465.jpg" alt="DSP Logo" width="175" height="100" >

<br>
 <%
String firstName = request.getParameter("firstName"); //Why isn't this working here
String schoolClass = request.getParameter("schoolClass"); 
String lastName = request.getParameter("lastName");
%>

<!-- Getting the id in result set:-->

<%
String participantNo;
int participantNoConvert;

try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql_database", "root", "aisling");
			Statement st=con.createStatement();
			ResultSet resultSet = null;
			
			String sql = "SELECT * FROM participant WHERE first_Name = 'Bob' AND last_name = 'Smith'" ;
			resultSet=st.executeQuery(sql);
			
			while (resultSet.next()){
			participantNo = resultSet.getString(1);
			participantNoConvert = Integer.parseInt(participantNo.trim());
			out.println("The id number is  " + participantNo + "  the convertedId number is " + participantNoConvert );
			}
			resultSet.close();
			st.close();
}
			catch(Exception e){
			System.out.println(e);
			}


%>


<!-- Inserting ecas selected into database -->
<%
String [] ecasSelected=request.getParameterValues("bookingCode");

if (ecasSelected !=null){
	for(int i=0; i <ecasSelected.length; i++){
		String eca = ecasSelected[i];
		int ecaConvert = Integer.parseInt(eca.trim());
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql_database", "root", "aisling");
			Statement st=con.createStatement();
			int is=st.executeUpdate("INSERT INTO activity_enrollment(id, activityId) VALUES(8, "+ecaConvert+")");
			out.println("Data is successfully inserted into database.");
			}
			catch(Exception e){
			System.out.println(e);
			}
}
}
%>

<sql:setDataSource
        var="myDS"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/mysql_database"
        user="root" password="aisling"
    />

<p><h1>You have booked <%= firstName%>  <% %>  <% %>of <%= schoolClass%> into :</h1></p>

<fieldset>
	<legend>Classes and Activities :  Booked   </legend>
	<table>
  <tr>
    
    <th>Activity/Class</th>
    <th>Day</th>
    <th>Time</th>
    <th>Cost</th>
  </tr>
  
	
<sql:query var="bookingsMade"   dataSource="${myDS}"> 
        SELECT activityName, dayOfWeek, classTime, cost
		FROM activity_enrollment
        JOIN ecas ON ecas.activityId = activity_enrollment.activityID 
        JOIN participant ON participant.id = activity_enrollment.id
		WHERE first_name = 'elsie' AND last_name = 'Main' ;
		
    </sql:query>
    
    
   
  <c:forEach var="user" items="${bookingsMade.rows}">
                <tr>
                    
                    <td><c:out value="${user.activityName}" /></td>
                    <td><c:out value="${user.dayOfWeek}" /></td>
                    <td><c:out value="${user.classTime}" /></td>
                    <td><c:out value="${user.cost}" /></td>   
                </tr>
            </c:forEach>   
  
  </table>	
</fieldset>
  

</body>
</html>