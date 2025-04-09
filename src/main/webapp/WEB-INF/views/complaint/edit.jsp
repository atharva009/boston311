<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/9/25
  Time: 19:21
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Edit Complaint | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7"
        crossorigin="anonymous">
  <style>
    body {
      background: url('https://images.unsplash.com/photo-1590402494702-1f4dc8a1e93e?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Segoe UI', sans-serif;
    }
    .edit-container {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 1rem;
      padding: 2rem;
      margin-top: 5vh;
    }
    .btn-boston {
      background-color: #0d3b66;
      color: white;
    }
    .btn-boston:hover {
      background-color: #092a4a;
    }
  </style>
</head>
<body>
<div class="container col-md-6 edit-container shadow-lg">
  <h3 class="mb-4 text-center">Edit Your Complaint</h3>

  <form:form action="/complaints/edit" method="post" modelAttribute="complaint">
    <form:hidden path="id"/>

    <div class="mb-3">
      <label class="form-label">Description</label>
      <form:textarea path="description" cssClass="form-control" rows="3" required="true"/>
    </div>

    <div class="mb-3">
      <label class="form-label">Location</label>
      <form:input path="location" cssClass="form-control" required="true"/>
    </div>

    <div class="mb-3">
      <label class="form-label">Severity (1–5)</label>
      <form:input path="severity" type="number" min="1" max="5" cssClass="form-control" required="true"/>
    </div>

    <div class="d-flex justify-content-between">
      <a href="/citizen/dashboard" class="btn btn-outline-secondary">Cancel</a>
      <button type="submit" class="btn btn-boston">Save Changes</button>
    </div>
  </form:form>
</div>
</body>
</html>