<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/9/25
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Complaint Submitted | Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7"
        crossorigin="anonymous">
  <style>
    body {
      background: url('https://images.unsplash.com/photo-1557683316-973673baf926?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Segoe UI', sans-serif;
    }
    .success-container {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 1rem;
      padding: 2rem;
      margin-top: 10vh;
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
<div class="container col-md-6 success-container shadow-lg text-center">
  <h3 class="mb-3 text-success">✅ Complaint Submitted Successfully!</h3>
  <p class="mb-4">Your issue has been recorded. You can view and track its progress in your dashboard.</p>
  <div class="d-grid gap-2 d-md-block">
    <a href="/citizen/dashboard" class="btn btn-boston me-2">Go to Dashboard</a>
    <a href="/complaints/new" class="btn btn-outline-secondary">Report Another Issue</a>
  </div>
</div>
</body>
</html>