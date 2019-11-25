<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cost Test</title>
</head>
<body>
Cost Page
<br><br>
The total cost is:
 <%
int totalAmount=0;
out.println(totalAmount);

%>
<br><br>
Total Cost: <input type="text" name="totalCost" value="${totalCost}"> <br>

<br><br>
Alternate
<%= request.getAttribute("totalCost") %>.

</body>
</html>