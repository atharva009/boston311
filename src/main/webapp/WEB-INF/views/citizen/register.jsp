<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/9/25
  Time: 18:39
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Citizen Registration | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7"
        crossorigin="anonymous">
  <style>
    body {
      background: url('https://images.unsplash.com/photo-1584989323185-83f7b26c51b0?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Segoe UI', sans-serif;
    }
    .card {
      background: rgba(255, 255, 255, 0.92);
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
  <div class="col-md-7">
    <div class="card shadow-lg p-4">
      <div class="card-header bg-transparent border-bottom-0 text-center mb-3">
        <span class="brand-header">Boston 311 - Citizen Registration</span>
      </div>
      <div class="card-body">
        <form:form action="/citizen/register" method="post" modelAttribute="citizen">
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
            <label class="form-label">Phone</label>
            <form:input path="phone" cssClass="form-control" required="true"/>
          </div>
          <div class="mb-3">
            <label class="form-label">Password</label>
            <form:input path="password" cssClass="form-control" type="password" required="true"/>
          </div>
          <div class="mb-3">
            <label class="form-label">Address</label>
            <form:input path="address" cssClass="form-control"/>
          </div>
          <div class="mb-3">
            <label class="form-label">Zip Code</label>
            <form:input path="zipcode" cssClass="form-control"/>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-boston">Register</button>
          </div>
        </form:form>
      </div>
      <div class="card-footer bg-transparent text-center">
        <a href="/citizen/login" class="footer-link text-decoration-none">Already registered? Log in</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>