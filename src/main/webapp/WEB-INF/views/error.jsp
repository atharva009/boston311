<%--
  Created by IntelliJ IDEA.
  User: atharva
  Date: 4/23/25
  Time: 21:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Boston 311</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .error-container {
            margin-top: 10vh;
            text-align: center;
        }
        .error-box {
            background: white;
            padding: 3rem;
            border-radius: 1rem;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        .btn-boston {
            background-color: #0d3b66;
            color: white;
            margin-top: 1rem;
        }
        .btn-boston:hover {
            background-color: #092a4a;
        }
    </style>
</head>
<body>
<div class="container error-container">
    <div class="error-box">
        <h1 class="display-4">🚧 Oops!</h1>
        <p class="lead">Something went wrong.</p>
        <p><strong>Status:</strong> ${status}</p>
        <p><strong>Message:</strong> ${message}</p>
        <a href="/" class="btn btn-boston">Back to Home</a>
    </div>
</div>
</body>
</html>