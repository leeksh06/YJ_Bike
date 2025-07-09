<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String user_id = request.getParameter("user_id");
    String content = request.getParameter("content");
    String post_idx = request.getParameter("post_idx");
    String date = request.getParameter("date");
    int ref = 1;
    int re_step = 0;
    int re_level = 0;


    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        pstmt = conn.prepareStatement("SELECT MAX(ref) FROM reply WHERE post_idx=?");
        pstmt.setString(1, post_idx);
        rs = pstmt.executeQuery();
        if (rs.next())
            ref = rs.getInt(1) + 1;


        pstmt = conn.prepareStatement("INSERT INTO reply VALUES (NULL, ?, ?, ?, ?, ?, ?, ?)");
        pstmt.setString(1, user_id);
        pstmt.setString(2, content);
        pstmt.setString(3, date);
        pstmt.setString(4, post_idx);
        pstmt.setInt(5, re_step);
        pstmt.setInt(6, re_level);
        pstmt.setString(7, post_idx);
        int result = pstmt.executeUpdate();
        if (result > 0) {
            pstmt = conn.prepareStatement("SELECT * FROM reply ORDER BY idx DESC LIMIT 0,1");
            rs = pstmt.executeQuery();
            String str = "{\"replyData\":[";
            if (rs.next()) {
                str += "{"
                        + "\"idx\": \"" + rs.getString("idx") + "\","
                        + "\"user_id\": \"" + rs.getString("user_id") + "\","
                        + "\"content\": \"" + rs.getString("content") + "\","
                        + "\"date\": \"" + rs.getString("date") + "\","
                        + "\"ref\": \"" + rs.getString("ref") + "\","
                        + "\"re_step\": \"" + rs.getString("re_step") + "\","
                        + "\"re_level\": \"" + rs.getString("re_level") + "\","
                        + "\"post_idx\": \"" + rs.getString("post_idx") + "\""
                        + "}]}";
                out.print(str);
            }
        } else {
            out.print("false");
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