<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Student Information successfully entered</h1>
<br><br>
<h2>You have booked <%
String firstName = request.getParameter("firstName");
String schoolClass = request.getParameter("schoolClass"); 
out.println(firstName);
%></h2>

<br><br>
<p>Your booking for <%= firstName%>  <% %>  <% %>of <%= schoolClass%> into ;</p>

</body>
</html>