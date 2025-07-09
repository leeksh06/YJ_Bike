<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%
    request.setCharacterEncoding("UTF-8");

    long now = System.currentTimeMillis();
    java.util.Date date = new java.util.Date(now);
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-");
    String time = dateFormat.format(date);
    String sqlDate = time + "%";
//    String sqlDate = "2023-05-%";

    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        pstmt = conn.prepareStatement("select nickname, max(distance) dis from cycle, user where cycle.user_id=user.user_id and date like ? group by cycle.user_id order by dis desc limit 0,10");
        pstmt.setString(1, sqlDate);
        rs = pstmt.executeQuery();


        String str = "";
        boolean check = true;
        while (rs.next()) {
            if (check) {
                str = "{\"ranking\":[";
                check = false;
            }
            str += "{"
                    + "\"nickname\": \"" + rs.getString("nickname") + "\","
                    + "\"distance\": \"" + rs.getString("dis") + "\""
                    + "},";
        }
        if (!check) {
            str = str.substring(0, str.lastIndexOf(","));
            str += "]}";
        }

        out.print(str);
    } catch (Exception e) {
        e.printStackTrace();
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