package com.sms.dao;

import com.sms.model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    // UPDATED JDBC URL: 
    // - Confirmed port is 3306.
    // - Removed the complex timeZone setting to simplify connection.
    private String jdbcURL = "jdbc:mysql://localhost:3306/student_management_db"; 
    private String jdbcUsername = "root";
    private String jdbcPassword = "Bankura@123";

    private static final String INSERT_SQL = "INSERT INTO students (first_name, last_name, email, course) VALUES (?, ?, ?, ?)";
    private static final String SELECT_BY_ID = "SELECT id, first_name, last_name, email, course FROM students WHERE id = ?";
    private static final String SELECT_ALL = "SELECT * FROM students";
    private static final String DELETE_SQL = "DELETE FROM students WHERE id = ?";
    private static final String UPDATE_SQL = "UPDATE students SET first_name = ?, last_name = ?, email = ?, course = ? WHERE id = ?";

    protected Connection getConnection() {
        try {
            // Load the MySQL JDBC Driver class
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Critical error message for easy debugging
            throw new RuntimeException("Database connection error. Check if MySQL is running on port 3306 and database 'student_management_db' exists.", e);
        }
    }

    // --- CRUD Methods (Insert, SelectAll, SelectSingle, Update, Delete) ---
    public void insertStudent(Student student) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SQL)) {
            preparedStatement.setString(1, student.getFirstName());
            preparedStatement.setString(2, student.getLastName());
            preparedStatement.setString(3, student.getEmail());
            preparedStatement.setString(4, student.getCourse());
            preparedStatement.executeUpdate();
        }
    }

    public List<Student> selectAllStudents() {
        List<Student> students = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
             ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("id");
                students.add(new Student(id, rs.getString("first_name"), rs.getString("last_name"), rs.getString("email"), rs.getString("course")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return students;
    }

    public Student selectStudent(int id) {
        Student student = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID)) {
            preparedStatement.setInt(1, id);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    student = new Student(id, rs.getString("first_name"), rs.getString("last_name"), rs.getString("email"), rs.getString("course"));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return student;
    }
    
    public boolean updateStudent(Student student) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_SQL)) {
            statement.setString(1, student.getFirstName());
            statement.setString(2, student.getLastName());
            statement.setString(3, student.getEmail());
            statement.setString(4, student.getCourse());
            statement.setInt(5, student.getId());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
    
    public boolean deleteStudent(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_SQL)) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }
}