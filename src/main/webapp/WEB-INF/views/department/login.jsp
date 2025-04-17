<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/16/25
  Time: 19:45
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Department Login | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7"
        crossorigin="anonymous">
  <style>
    body {
      background: url('https://images.unsplash.com/photo-1579039114663-46e5d9a5d3f1?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Segoe UI', sans-serif;
    }
    .card {
      background: rgba(255, 255, 255, 0.9);
      border-radius: 1rem;
    }
    .brand-header {
      font-weight: bold;
      font-size: 1.5rem;
      color: #0d3b66;
    }
    .btn-boston {
      background-color: #0d3b66;
      color: white;
    }
    .btn-boston:hover {
      background-color: #092a4a;
    }
    .footer-link {
      font-size: 0.9rem;
    }
  </style>
</head>
<body>
<div class="container d-flex align-items-center justify-content-center vh-100">
  <div class="col-md-5">
    <div class="card shadow-lg p-4">
      <div class="card-header bg-transparent border-bottom-0 text-center mb-3">
        <span class="brand-header">Boston 311 - Department Login</span>
      </div>
      <div class="card-body">
        <form:form action="/department/login" method="post" modelAttribute="department">
          <div class="mb-3">
            <label class="form-label">Email</label>
            <form:input path="email" cssClass="form-control" type="email" required="true"/>
          </div>
          <div class="mb-3">
            <label class="form-label">Password</label>
            <form:input path="password" cssClass="form-control" type="password" required="true"/>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-boston">Log In</button>
          </div>
        </form:form>
        <c:if test="${not empty error}">
          <div class="alert alert-danger mt-3 text-center">${error}</div>
        </c:if>
      </div>
      <div class="card-footer bg-transparent text-center">
        <a href="/department/register" class="footer-link text-decoration-none">New department? Register here</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>