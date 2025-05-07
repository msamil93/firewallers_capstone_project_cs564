<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Check-In Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eef2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .confirmation {
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
       }
        .confirmation h2 {
            color: #1a73e8;
            margin-bottom: 20px;
        }
        .confirmation p {
            color: #333;
            font-size: 16px;
        }
        .confirmation a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #1a73e8;
            font-weight: bold;
        }
        .confirmation a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="confirmation">
    <h2>Check-In Successful!</h2>
    <p>Your attendance has been recorded. Thank you.</p>
    <a href="/checkpin/index.jsp">Go Back</a>
</div>

</body>
</html>
