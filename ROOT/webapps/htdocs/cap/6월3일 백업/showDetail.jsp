<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String idx = request.getParameter("idx");


    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        pstmt = conn.prepareStatement("SELECT * FROM post WHERE idx=?");
        pstmt.setString(1, idx);
        rs = pstmt.executeQuery();

        String str;
        if (rs.next()) {
            str = "{"
                    + "\"user_id\": \"" + rs.getString("user_id") + "\","
                    + "\"category\": \"" + rs.getString("category") + "\","
                    + "\"title\": \"" + rs.getString("title") + "\","
                    + "\"content\": \"" + rs.getString("content") + "\","
                    + "\"date\": \"" + rs.getString("date") + "\","
                    + "\"thum\": \"" + rs.getString("thum") + "\""
                    + "}";

            out.print(str);
        } else {
            out.print("null");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("{\"success\":false, \"message\":\"" + e.getMessage() + "\"}");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>