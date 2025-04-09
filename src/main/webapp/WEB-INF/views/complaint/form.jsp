<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/2/25
  Time: 20:50
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>New Complaint</title></head>
<body>
<h2>Submit a Complaint</h2>

<form:form method="POST" action="/complaints/submit" modelAttribute="complaint">
    <p>Description: <form:input path="description"/></p>
    <p>Location: <form:input path="location"/></p>
    <p>Severity (1-5): <form:input path="severity" type="number"/></p>
    <p><input type="submit" value="Submit Complaint"/></p>
</form:form>

</body>
</html>