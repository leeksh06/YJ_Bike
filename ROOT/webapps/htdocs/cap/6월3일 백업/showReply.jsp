<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
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
        pstmt = conn.prepareStatement("SELECT * FROM reply WHERE ref=?"
                , ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        pstmt.setString(1, idx);
        rs = pstmt.executeQuery();


        int totalRecord = 0, cnt = 1;
        rs.last();
        totalRecord = rs.getRow();

        rs.beforeFirst();

//        System.out.println("댓글 totalRecord : " + totalRecord);
        String str = null;
        if (totalRecord > 0) {
            str = "{\"replyData\":[";
            while (rs.next()) {
                str += "{"
                        + "\"idx\": \"" + rs.getString("idx") + "\","
                        + "\"user_id\": \"" + rs.getString("user_id") + "\","
                        + "\"content\": \"" + rs.getString("content") + "\","
                        + "\"date\": \"" + rs.getString("date") + "\","
                        + "\"ref\": \"" + rs.getString("ref") + "\","
                        + "\"re_step\": \"" + rs.getString("re_step") + "\","
                        + "\"re_level\": \"" + rs.getString("re_level") + "\","
                        + "\"post_idx\": \"" + rs.getString("post_idx") + "\""
                        + "}";
                cnt++;
                if (cnt <= totalRecord) {
                    str += ",";
                } else {
                    str += "]}";
                }
            }
//            System.out.println("댓글 json : " + str);
        }
        out.print(str);

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