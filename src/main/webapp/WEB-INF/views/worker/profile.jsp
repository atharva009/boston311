<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/20/25
  Time: 19:11
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Worker Profile | Boston 311</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .profile-container {
            max-width: 720px;
            margin: 3rem auto;
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }
        .btn-boston {
            background-color: #0d3b66;
            color: white;
        }
        .btn-boston:hover {
            background-color: #092a4a;
        }
        .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="profile-container">
    <h3 class="mb-4 text-center">Update Profile</h3>

    <form:form method="post" action="/worker/profile" modelAttribute="worker">
        <form:hidden path="id" />

        <!-- Name -->
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <form:input path="name" cssClass="form-control" />
            <form:errors path="name" cssClass="text-danger" />
        </div>

        <!-- Status -->
        <div class="mb-3">
            <label class="form-label">Status</label>
            <form:input path="status" cssClass="form-control" />
            <form:errors path="status" cssClass="text-danger" />
        </div>

        <!-- Email (read-only) -->
        <div class="mb-3">
            <label class="form-label">Email</label>
            <form:input path="email" cssClass="form-control" readonly="true" />
            <form:errors path="email" cssClass="text-danger" />
        </div>

        <!-- Department -->
        <div class="mb-3">
            <label class="form-label">Department</label>
            <form:select path="department.id" cssClass="form-select">
                <form:option value="" label="-- Select Department --" />
                <form:options items="${departments}" itemValue="id" itemLabel="name" />
            </form:select>
            <form:errors path="department.id" cssClass="text-danger" />
        </div>

        <!-- Submit -->
        <div class="text-center">
            <button type="submit" class="btn btn-boston px-4">Update Profile</button>
        </div>
    </form:form>
</div>
</body>
</html>