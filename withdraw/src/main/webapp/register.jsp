<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>
    <style>
        .error {
            color: red;
            display: none;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 15px;
            box-shadow: 0 9px #999;
        }
        .button:hover {background-color: #3e8e41}
        .button:active {
            background-color: #3e8e41;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }
    </style>
    <script>
        function validateForm() {
            var fullname = document.forms["registrationForm"]["fullname"].value;
            var address = document.forms["registrationForm"]["address"].value;
            var phonenumber = document.forms["registrationForm"]["phonenumber"].value;
            var dateofbirth = new Date(document.forms["registrationForm"]["dateofbirth"].value);
            var idproof = document.forms["registrationForm"]["idproof"].value.toLowerCase();
            var today = new Date();
            var age = today.getFullYear() - dateofbirth.getFullYear();
            var month = today.getMonth() - dateofbirth.getMonth();
            if (month < 0 || (month === 0 && today.getDate() < dateofbirth.getDate())) {
                age--;
            }

            var errors = false;

            // Full name validation
            if (!/^[a-zA-Z\s]+$/.test(fullname)) {
                document.getElementById("fullnameError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("fullnameError").style.display = "none";
            }

            // Address validation
            if (!/^[a-zA-Z0-9\s,.-]+$/.test(address)) {
                document.getElementById("addressError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("addressError").style.display = "none";
            }

            // Phone number validation
            if (!/^\d{10}$/.test(phonenumber)) {
                document.getElementById("phonenumberError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("phonenumberError").style.display = "none";
            }

            // Age validation
            if (age < 18) {
                document.getElementById("dateofbirthError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("dateofbirthError").style.display = "none";
            }

            // ID proof validation
            var validIdProofs = ["aadhar card", "pan card", "driving license", "passport"];
            if (!validIdProofs.includes(idproof)) {
                document.getElementById("idproofError").style.display = "block";
                errors = true;
            } else {
                document.getElementById("idproofError").style.display = "none";
            }

            return !errors;
        }

        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <h2>Customer Registration Form</h2>
    <form name="registrationForm" action="CustomerRegistrationServlet" method="Post" onsubmit="return validateForm()">
        Full Name: <input type="text" name="fullname" required><br>
        <span id="fullnameError" class="error">Full name should contain only letters and spaces.</span><br>
        Address: <input type="text" name="address" required><br>
        <span id="addressError" class="error">Address can contain letters, numbers, spaces, commas, periods, and hyphens.</span><br>
        Phone Number: <input type="text" name="phonenumber" required><br>
        <span id="phonenumberError" class="error">Phone number should be a 10-digit number.</span><br>
        Account Type: <input type="text" name="accounttype" required><br>
        Date of Birth: <input type="date" name="dateofbirth" required><br>
        <span id="dateofbirthError" class="error">Age should be 18 or above.</span><br>
        ID Proof: <input type="text" name="idproof" required><br>
        <span id="idproofError" class="error">ID Proof should be one of the following: Aadhar Card, PAN Card, Driving License, Passport.</span><br>
        Email ID: <input type="email" name="emailid" required><br>

        <input type="submit" value="Register">
    </form>

    <button class="button" onclick="goBack()">Back</button>
</body>
</html>
