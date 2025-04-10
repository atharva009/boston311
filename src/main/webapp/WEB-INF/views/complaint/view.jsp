<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/9/25
  Time: 19:42
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>View Complaint | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7"
        crossorigin="anonymous">
  <style>
    body {
      background: url('https://images.unsplash.com/photo-1590080876250-27a4193a76c2?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Segoe UI', sans-serif;
    }
    .view-container {
      background: rgba(255, 255, 255, 0.97);
      border-radius: 1rem;
      padding: 2rem;
      margin-top: 5vh;
    }
    .label {
      font-weight: bold;
      color: #0d3b66;
    }
  </style>
</head>
<body>
<div class="container col-md-8 view-container shadow-lg">
  <h3 class="mb-4 text-center">Complaint Details</h3>

  <div class="mb-3">
    <span class="label">Complaint ID:</span> ${complaint.id}
  </div>
  <div class="mb-3">
    <span class="label">Description:</span><br/>
    <p>${complaint.description}</p>
  </div>
  <div class="mb-3">
    <span class="label">Location:</span> ${complaint.location}
  </div>
  <div class="mb-3">
    <span class="label">Severity:</span> ${complaint.severity}
  </div>
  <div class="mb-3">
    <span class="label">Status:</span>
    <c:choose>
      <c:when test="${complaint.status == 'Open'}">
        <span class="badge bg-warning text-dark">${complaint.status}</span>
      </c:when>
      <c:when test="${complaint.status == 'In Progress'}">
        <span class="badge bg-primary">${complaint.status}</span>
      </c:when>
      <c:when test="${complaint.status == 'Resolved'}">
        <span class="badge bg-success">${complaint.status}</span>
      </c:when>
      <c:otherwise>
        <span class="badge bg-secondary">${complaint.status}</span>
      </c:otherwise>
    </c:choose>
  </div>
  <div class="mb-4">
    <span class="label">Reported On:</span> ${complaint.dateReported}
  </div>

  <div class="text-end">
    <a href="/citizen/dashboard" class="btn btn-outline-secondary">Back to Dashboard</a>
  </div>
</div>
</body>
</html>