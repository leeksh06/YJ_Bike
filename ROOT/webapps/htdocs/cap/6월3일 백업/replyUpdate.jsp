<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    String replyIdx = request.getParameter("replyIdx");
    String content = request.getParameter("content");

    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        pstmt=conn.prepareStatement("SELECT * FROM reply WHERE idx=?");
        pstmt.setString(1, replyIdx);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            pstmt=conn.prepareStatement("UPDATE reply SET content=? WHERE idx=?");
//            System.out.println("sql 값 : ");

            pstmt.setString(1, content);
            pstmt.setString(2, replyIdx);

            int result=pstmt.executeUpdate();
//            System.out.println("result 값 : " + result);
            out.println("success");
        }

    } catch(Exception e){
        e.printStackTrace();
        out.println("{\"success\":false, \"message\":\"" + e.getMessage() + "\"}");
    } finally{
        try{
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
%>