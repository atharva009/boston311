<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/16/25
  Time: 19:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Welcome to Boston 311</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: white;
      background-size: cover;
      color: #fff;
      font-family: 'Segoe UI', sans-serif;
    }
    .overlay {
      background: rgba(0, 0, 0, 0.65);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      padding: 2rem;
    }
    .btn-boston {
      background-color: #0d3b66;
      color: whitesmoke;
      border: none;
      padding: 0.75rem 2rem;
      font-size: 1.1rem;
      border-radius: 0.5rem;
      margin: 0.5rem;
    }
    .btn-boston:hover {
      background-color: #092a4a;
    }
  </style>
</head>
<body>
<div class="overlay">
  <h1 class="mb-4">Welcome to Boston 311</h1>
  <h4 class="mb-5 ">Report. Track. Resolve. All in one place.</h4>

  <div>
    <a href="/citizen/login" class="btn btn-boston">Citizen</a>
    <a href="/department/login" class="btn btn-boston">Department</a>
    <a href="/worker/login" class="btn btn-boston">Worker</a>
  </div>
</div>
</body>
</html>