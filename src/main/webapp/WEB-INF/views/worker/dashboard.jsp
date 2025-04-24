<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/16/25
  Time: 23:24
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="/WEB-INF/views/fragments/navbar.jspf" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Worker Dashboard | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', sans-serif;
    }
    .dashboard-container {
      margin-top: 2rem;
      background: white;
      padding: 2rem;
      border-radius: 1rem;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
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

<div class="container dashboard-container">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h3>Welcome, ${workerName}!</h3>
    <div>
      <a href="/worker/profile" class="btn btn-outline-primary me-2">View/Edit Profile</a>
      <a href="/worker/logout" class="btn btn-outline-secondary">Log Out</a>
    </div>
  </div>

  <h5>Your Assigned Complaints</h5>
  <c:choose>
    <c:when test="${not empty complaints}">
      <table class="table table-bordered table-striped mt-3">
        <thead class="table-dark">
        <tr>
          <th>ID</th>
          <th>Description</th>
          <th>Location</th>
          <th>Severity</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="c" items="${complaints}">
          <tr>
            <td>${c.id}</td>
            <td>${c.description}</td>
            <td>${c.location}</td>
            <td>
              <c:choose>
                <c:when test="${c.severity == 1}">Low</c:when>
                <c:when test="${c.severity == 2}">Medium</c:when>
                <c:when test="${c.severity == 3}">High</c:when>
                <c:when test="${c.severity == 4}">Urgent</c:when>
                <c:otherwise>Unknown</c:otherwise>
              </c:choose>
            </td>
            <td>${c.status}</td>
            <td>
              <c:if test="${c.status != 'Resolved'}">
                <a href="/worker/resolve/${c.id}" class="btn btn-sm btn-success">Mark Resolved</a>
              </c:if>
              <c:if test="${c.status == 'Resolved'}">
                <span class="text-success">Resolved</span>
              </c:if>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise>
      <p class="text-muted mt-3">No complaints assigned yet.</p>
    </c:otherwise>
  </c:choose>
</div>

</body>
</html>