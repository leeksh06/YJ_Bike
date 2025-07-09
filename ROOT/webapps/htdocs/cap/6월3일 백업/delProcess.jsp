<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
    String idx = request.getParameter("idx");
    String replyIdx = request.getParameter("replyIdx");


    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        if (idx != null) {
            pstmt = conn.prepareStatement("SELECT * FROM post WHERE idx=?");
            pstmt.setString(1, idx);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                pstmt = conn.prepareStatement("DELETE FROM post WHERE idx=?");
                pstmt.setString(1, idx);
                int result = pstmt.executeUpdate();
                out.println("{\"success\":true, \"message\":\"글 삭제 성공\"}");
            }
        }

        if (replyIdx != null) {
            pstmt = conn.prepareStatement("SELECT * FROM reply WHERE idx=?");
            pstmt.setString(1, replyIdx);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                pstmt = conn.prepareStatement("DELETE FROM reply WHERE idx=?");
                pstmt.setString(1, replyIdx);
                int result = pstmt.executeUpdate();
                out.println("success");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>