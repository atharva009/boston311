<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/16/25
  Time: 23:24
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="/WEB-INF/views/fragments/navbar.jspf" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Worker Registration | Boston 311</title>
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
  <div class="col-md-7">
    <div class="card shadow-lg p-4">
      <div class="text-center mb-3">
        <span class="brand-header">Boston 311 - Worker Registration</span>
      </div>
      <form:form action="/worker/register" method="post" modelAttribute="worker">
        <div class="row">
          <div class="col-md-6 mb-3">
            <label class="form-label">Full Name</label>
            <form:input path="name" cssClass="form-control" required="true"/>
          </div>
          <div class="col-md-6 mb-3">
            <label class="form-label">Email</label>
            <form:input path="email" cssClass="form-control" type="email" required="true"/>
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label">Password</label>
          <form:input path="password" cssClass="form-control" type="password" required="true"/>
        </div>
        <div class="mb-3">
          <label class="form-label">Department</label>
          <form:select path="department.id" cssClass="form-select">
            <form:option value="" label="-- Select Department --"/>
            <form:options items="${departments}" itemValue="id" itemLabel="name"/>
          </form:select>
        </div>
        <div class="d-grid">
          <button type="submit" class="btn btn-boston">Register</button>
        </div>
      </form:form>
      <div class="text-center mt-3">
        <a href="/worker/login" class="text-decoration-none">Already registered? Log in</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>