<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/16/25
  Time: 22:55
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="/WEB-INF/views/fragments/navbar.jspf" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Department Dashboard | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: url('https://images.unsplash.com/photo-1582056601678-e8d94f5d86aa?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Segoe UI', sans-serif;
    }
    .dashboard-container {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 1rem;
      padding: 2rem;
      margin-top: 3rem;
      box-shadow: 0 0 10px rgba(0,0,0,0.15);
    }
    .btn-boston {
      background-color: #0d3b66;
      color: white;
    }
    .btn-boston:hover {
      background-color: #092a4a;
    }
    h3, h5 {
      font-weight: 600;
      color: #0d3b66;
    }
    table th, table td {
      vertical-align: middle !important;
    }
  </style>
</head>
<body>
<div class="container dashboard-container">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h3>Welcome, ${departmentName}!</h3>
    <a href="/department/logout" class="btn btn-outline-secondary">Log Out</a>
  </div>

  <!-- Summary Cards -->
  <div class="row text-center mb-4">
    <div class="col-md-4 mb-3">
      <div class="card shadow-sm border-0">
        <div class="card-body">
          <h5 class="text-warning">🟡 Open</h5>
          <h3 class="fw-bold">${openCount}</h3>
        </div>
      </div>
    </div>
    <div class="col-md-4 mb-3">
      <div class="card shadow-sm border-0">
        <div class="card-body">
          <h5 class="text-primary">🔵 In Progress</h5>
          <h3 class="fw-bold">${inProgressCount}</h3>
        </div>
      </div>
    </div>
    <div class="col-md-4 mb-3">
      <div class="card shadow-sm border-0">
        <div class="card-body">
          <h5 class="text-success">✅ Resolved</h5>
          <h3 class="fw-bold">${resolvedCount}</h3>
        </div>
      </div>
    </div>
  </div>

  <!-- Complaints Table -->
  <h5 class="mb-3">Complaints Assigned to Your Department</h5>
  <c:choose>
    <c:when test="${not empty complaints}">
      <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle">
          <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Description</th>
            <th>Location</th>
            <th>Severity</th>
            <th>Status</th>
            <th>Reported On</th>
            <th>Assigned Worker</th>
            <th>Assign Worker</th>
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
              <td>${c.dateReported}</td>
              <td>
                <c:choose>
                  <c:when test="${not empty c.assignedWorker}">
                    ${c.assignedWorker.name}
                  </c:when>
                  <c:otherwise>
                    <span class="text-muted">Unassigned</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <form action="/department/assign" method="post" class="d-flex align-items-center">
                  <input type="hidden" name="complaintId" value="${c.id}" />
                  <select name="workerId" class="form-select form-select-sm me-2" required>
                    <option value="">Select</option>
                    <c:forEach var="w" items="${workers}">
                      <option value="${w.id}">${w.name}</option>
                    </c:forEach>
                  </select>
                  <button type="submit" class="btn btn-sm btn-boston">Assign</button>
                </form>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:when>
    <c:otherwise>
      <p class="text-muted mt-3">No complaints assigned to this department yet.</p>
    </c:otherwise>
  </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>