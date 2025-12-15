<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management System</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; margin: 0; padding: 20px; }
        .container { max-width: 900px; margin: 30px auto; background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); }
        h1 { color: #2c3e50; text-align: center; margin-bottom: 20px; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #3498db; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .action-links a { margin-right: 10px; text-decoration: none; color: #2980b9; font-weight: 600; }
        .action-links a:hover { text-decoration: underline; }
        .add-link { display: block; text-align: right; margin-bottom: 15px; }
        .add-link a { background-color: #2ecc71; color: white; padding: 10px 15px; border-radius: 5px; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Student Records</h1>
        
        <div class="add-link">
            <a href="StudentServlet?action=new">Add New Student</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Course</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="student" items="${listStudent}">
                    <tr>
                        <td><c:out value="${student.id}" /></td>
                        <td><c:out value="${student.firstName}" /></td>
                        <td><c:out value="${student.lastName}" /></td>
                        <td><c:out value="${student.email}" /></td>
                        <td><c:out value="${student.course}" /></td>
                        <td class="action-links">
                            <a href="StudentServlet?action=edit&id=<c:out value='${student.id}' />">Edit</a>
                            <a href="StudentServlet?action=delete&id=<c:out value='${student.id}' />" onclick="return confirm('Are you sure you want to delete this record?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>