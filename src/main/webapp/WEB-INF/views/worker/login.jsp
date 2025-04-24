<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/16/25
  Time: 23:24
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="/WEB-INF/views/fragments/navbar.jspf" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Worker Login | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #f0f4f8;
      font-family: 'Segoe UI', sans-serif;
    }
    .card {
      background: rgba(255, 255, 255, 0.95);
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
  </style>
</head>
<body>
<div class="container d-flex align-items-center justify-content-center vh-100">
  <div class="col-md-5">
    <div class="card shadow-lg p-4">
      <div class="text-center mb-3">
        <span class="brand-header">Boston 311 - Worker Login</span>
      </div>
      <form:form action="/worker/login" method="post" modelAttribute="worker">
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
      <div class="text-center mt-3">
        <a href="/worker/register" class="text-decoration-none">New worker? Register</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>