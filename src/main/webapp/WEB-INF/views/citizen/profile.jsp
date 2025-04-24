<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/9/25
  Time: 19:25
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ include file="/WEB-INF/views/fragments/navbar.jspf" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Profile | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <style>
    body {
      background: url('https://images.unsplash.com/photo-1528669826292-fd1d4b0d69e9?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
      background-size: cover;
    }
    .profile-container {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 1rem;
      padding: 2rem;
      margin-top: 5vh;
      max-width: 650px;
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

<div class="container profile-container shadow-lg">
  <h3 class="mb-4 text-center">My Profile</h3>

  <form:form action="/citizen/profile" method="post" modelAttribute="citizen">
    <div class="mb-3">
      <label class="form-label">Full Name</label>
      <form:input path="name" cssClass="form-control"/>
      <form:errors path="name" cssClass="text-danger small"/>
    </div>
    <div class="mb-3">
      <label class="form-label">Email (read-only)</label>
      <form:input path="email" cssClass="form-control" readonly="true"/>
    </div>
    <div class="mb-3">
      <label class="form-label">Phone</label>
      <form:input path="phone" cssClass="form-control"/>
      <form:errors path="phone" cssClass="text-danger small"/>
    </div>
    <div class="mb-3">
      <label class="form-label">Address</label>
      <form:input path="address" cssClass="form-control"/>
    </div>
    <div class="mb-3">
      <label class="form-label">Zipcode</label>
      <form:input path="zipcode" cssClass="form-control"/>
    </div>
    <div class="d-flex justify-content-between">
      <a href="/citizen/dashboard" class="btn btn-outline-secondary">Cancel</a>
      <button type="submit" class="btn btn-boston">Save Changes</button>
    </div>
  </form:form>
</div>
</body>
</html>