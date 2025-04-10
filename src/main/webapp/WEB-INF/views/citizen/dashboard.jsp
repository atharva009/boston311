<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/9/25
  Time: 19:09
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Dashboard | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7"
        crossorigin="anonymous">
  <style>
    body {
      background: url('https://images.unsplash.com/photo-1582056601678-e8d94f5d86aa?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
      background-size: cover;
    }
    .dashboard-container {
      background: rgba(255, 255, 255, 0.94);
      border-radius: 1rem;
      padding: 2rem;
      margin-top: 3rem;
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

<!-- ✅ Profile updated toast -->
<c:if test="${profileUpdated}">
  <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1050">
    <div id="toastProfile" class="toast align-items-center text-bg-success border-0" role="alert"
         aria-live="assertive" aria-atomic="true"
         data-bs-delay="5000" data-bs-autohide="true">
      <div class="d-flex">
        <div class="toast-body">
          ✅ Profile updated successfully!
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto"
                data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    </div>
  </div>
</c:if>

<!-- 📝 Issue added toast -->
<c:if test="${not empty sessionScope.issueAdded}">
  <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1050">
    <div id="toastIssue" class="toast align-items-center text-bg-success border-0" role="alert"
         aria-live="assertive" aria-atomic="true"
         data-bs-delay="5000" data-bs-autohide="true">
      <div class="d-flex">
        <div class="toast-body">
          📝 New issue reported successfully!
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto"
                data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    </div>
  </div>
  <c:remove var="issueAdded" scope="session"/>
</c:if>

<div class="container dashboard-container">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h3>Welcome, ${citizenName}!</h3>
    <div>
      <a href="/complaints/new" class="btn btn-boston me-2">Report New Issue</a>
      <a href="/citizen/profile" class="btn btn-outline-primary me-2">Edit Profile</a>
      <a href="/citizen/logout" class="btn btn-outline-secondary">Log Out</a>
    </div>
  </div>

  <!-- Summary Cards -->
  <div class="row text-center mb-4">
    <div class="col-md-4">
      <div class="card shadow-sm">
        <div class="card-body">
          <h5 class="text-warning">🟡 Open</h5>
          <h3 class="fw-bold">${openCount}</h3>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card shadow-sm">
        <div class="card-body">
          <h5 class="text-primary">🔵 In Progress</h5>
          <h3 class="fw-bold">${inProgressCount}</h3>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card shadow-sm">
        <div class="card-body">
          <h5 class="text-success">✅ Resolved</h5>
          <h3 class="fw-bold">${resolvedCount}</h3>
        </div>
      </div>
    </div>
  </div>

  <!-- Filter/Search Form -->
  <form method="get" action="/citizen/dashboard" class="row g-3 align-items-end mb-3">
    <div class="col-md-3">
      <label class="form-label">Status</label>
      <select name="status" class="form-select">
        <option value="">All</option>
        <option value="Open" ${selectedStatus == 'Open' ? 'selected' : ''}>Open</option>
        <option value="In Progress" ${selectedStatus == 'In Progress' ? 'selected' : ''}>In Progress</option>
        <option value="Resolved" ${selectedStatus == 'Resolved' ? 'selected' : ''}>Resolved</option>
        <option value="Cancelled" ${selectedStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
      </select>
    </div>
    <div class="col-md-6">
      <label class="form-label">Search</label>
      <input type="text" name="keyword" class="form-control" placeholder="Search description or location"
             value="${searchKeyword}">
    </div>
    <div class="col-md-3">
      <button type="submit" class="btn btn-boston w-100">Apply Filters</button>
    </div>
  </form>

  <!-- Complaints Table -->
  <h5>Your Reported Complaints</h5>
  <c:choose>
    <c:when test="${not empty complaints}">
      <table class="table table-striped table-bordered mt-3">
        <thead class="table-dark">
        <tr>
          <th>ID</th>
          <th>Description</th>
          <th>Location</th>
          <th>Severity</th>
          <th>Status</th>
          <th>Reported On</th>
          <th>Actions</th>
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
              <c:if test="${c.status == 'Open'}">
                <a href="/complaints/edit/${c.id}" class="btn btn-sm btn-warning">Edit</a>
                <a href="/complaints/cancel/${c.id}" class="btn btn-sm btn-danger ms-1"
                   onclick="return confirm('Are you sure you want to cancel this complaint?');">Cancel</a>
              </c:if>
              <c:if test="${c.status != 'Open'}">
                <span class="text-muted">Locked</span>
              </c:if>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise>
      <p class="text-muted mt-3">You haven’t submitted any complaints yet.</p>
    </c:otherwise>
  </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YNaIJG0Lxf+IP7zVPA13uXvb4+4nTP7k4T2gfTVXGQjMkFJAFIJkHQHRsiRxz3qE"
        crossorigin="anonymous"></script>

<script>
  window.addEventListener('DOMContentLoaded', () => {
    const toastProfile = document.getElementById('toastProfile');
    const toastIssue = document.getElementById('toastIssue');

    if (toastProfile) {
      new bootstrap.Toast(toastProfile).show();
    }
    if (toastIssue) {
      new bootstrap.Toast(toastIssue).show();
    }
  });
</script>

</body>
</html>