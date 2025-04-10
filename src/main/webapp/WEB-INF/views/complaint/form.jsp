<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/9/25
  Time: 19:43
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Report New Issue – Boston311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #f0f4f8;
      font-family: 'Segoe UI', sans-serif;
    }

    .card {
      border-radius: 1.25rem;
    }

    .card-header {
      background-color: #003c71;
      color: white;
      border-top-left-radius: 1.25rem;
      border-top-right-radius: 1.25rem;
    }

    .btn-primary {
      background-color: #003c71;
      border-color: #003c71;
    }

    .btn-primary:hover {
      background-color: #002e59;
    }
  </style>
</head>
<body>

<div class="container mt-5">
  <div class="card shadow">
    <div class="card-header">
      <h4 class="mb-0">Report a New Complaint</h4>
    </div>
    <div class="card-body">
      <form:form action="${pageContext.request.contextPath}/complaints/submit" method="post" modelAttribute="complaint">

        <!-- Department -->
        <div class="mb-3">
          <label for="department" class="form-label">Department</label>
          <form:select path="department.id" cssClass="form-select" id="department">
            <form:option value="" label="-- Select Department --"/>
            <form:options items="${departments}" itemValue="id" itemLabel="name"/>
          </form:select>
        </div>

        <!-- Location -->
        <div class="mb-3">
          <label for="location" class="form-label">Location</label>
          <form:input path="location" id="location" cssClass="form-control" placeholder="Street or landmark" />
        </div>

        <!-- Description -->
        <div class="mb-3">
          <label for="description" class="form-label">Description</label>
          <form:textarea path="description" id="description" cssClass="form-control" rows="4" placeholder="Describe the issue" />
        </div>

        <!-- Severity -->
        <div class="mb-3">
          <label for="severity" class="form-label">Severity</label>
          <form:select path="severity" cssClass="form-select" id="severity">
            <form:option value="" label="-- Select Severity --"/>
            <form:option value="1" label="Low"/>
            <form:option value="2" label="Medium"/>
            <form:option value="3" label="High"/>
            <form:option value="4" label="Urgent"/>
          </form:select>
        </div>

        <div class="d-flex justify-content-between">
          <a href="${pageContext.request.contextPath}/citizen/dashboard" class="btn btn-secondary">Back</a>
          <button type="submit" class="btn btn-primary">Submit Complaint</button>
        </div>

      </form:form>
    </div>
  </div>
</div>

</body>
</html>
