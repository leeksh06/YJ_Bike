<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String idx = request.getParameter("idx");
    String category = request.getParameter("category");
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    String thum = "";
    String total_image = request.getParameter("total_image");
    String real_image = request.getParameter("real_image");
    if (total_image != null) {
        // real_image 에 들어있지 않은 사진들 삭제
        /* 생략 */
        String[] arr_total_image = total_image.split(",");
        System.out.println("update 전체 이미지 : " + total_image);

        if (real_image != null) {
            // db에 저장
            String[] arr_real_image = real_image.split(",");
            for (int i = 0; i < arr_real_image.length; i++) {
                thum += "images/" + arr_real_image[i] + " ";
            }
if (real_image.equals("")) {
    thum = "";
}
        }
    }
    System.out.println("thum : " + thum);
////    테스트용
//    if (!thum.equals(""))
//        out.println("{\"success\":true, \"message\":\"Insert Success!\"}");



    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        pstmt = conn.prepareStatement("SELECT * FROM post WHERE idx=?");
        pstmt.setString(1, idx);
        rs = pstmt.executeQuery();

        if (rs.next()) {

            pstmt = conn.prepareStatement("UPDATE post SET category=?, title=?, content=?, thum=? WHERE idx=?");
            pstmt.setString(1, category);
            pstmt.setString(2, title);
            pstmt.setString(3, content);
            pstmt.setString(4, thum);
            pstmt.setString(5, idx);

            int result = pstmt.executeUpdate();
            out.println("{\"success\":true, \"message\":\"수정 성공\"}");
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