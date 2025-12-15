<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Form</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; margin: 0; padding: 20px; }
        .container { max-width: 600px; margin: 30px auto; background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); }
        h1 { color: #2c3e50; text-align: center; margin-bottom: 25px; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        label { display: block; margin-top: 15px; font-weight: 600; color: #34495e; }
        input[type="text"], input[type="email"] { width: 100%; padding: 12px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 16px; }
        .form-actions { margin-top: 25px; overflow: hidden; }
        .btn { padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; text-decoration: none; display: inline-block; }
        .btn-submit { background-color: #2ecc71; color: white; float: right; }
        .btn-cancel { background-color: #95a5a6; color: white; float: left; }
    </style>
</head>
<body>
    <div class="container">
        <h1><c:if test="${student != null}">Edit Record</c:if><c:if test="${student == null}">Add New Student</c:if></h1>
        
        <form action="StudentServlet" method="post">
            
            <c:choose>
                <c:when test="${student != null}">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<c:out value='${student.id}'/>"/>
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="action" value="insert"/>
                </c:otherwise>
            </c:choose>

            <label for="first_name">First Name:</label>
            <input type="text" id="first_name" name="first_name" value="<c:out value='${student.firstName}'/>" required/>

            <label for="last_name">Last Name:</label>
            <input type="text" id="last_name" name="last_name" value="<c:out value='${student.lastName}'/>" required/>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<c:out value='${student.email}'/>" required/>

            <label for="course">Course:</label>
            <input type="text" id="course" name="course" value="<c:out value='${student.course}'/>" required/>

            <div class="form-actions">
                <a href="StudentServlet?action=list" class="btn btn-cancel">Cancel</a>
                <button type="submit" class="btn btn-submit">
                    <c:if test="${student != null}">Update Record</c:if>
                    <c:if test="${student == null}">Save Student</c:if>
                </button>
            </div>
        </form>
    </div>
</body>
</html>