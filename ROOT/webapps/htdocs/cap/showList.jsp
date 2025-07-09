<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String currentCategory = request.getParameter("category").replace("\"", "");
    int currentPage = Integer.parseInt(request.getParameter("page"));
    int limit = Integer.parseInt(request.getParameter("limit"));
    int start = (currentPage - 1) * (limit + 1);
    String search = request.getParameter("search");

    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    Connection conn;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        if (search == null) {
//            pstmt = conn.prepareStatement("SELECT * FROM post WHERE category=? ORDER BY idx DESC LIMIT " + start + "," + limit
//                    , ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

pstmt = conn.prepareStatement("select post.idx, post.user_id, post.category, post.title, post.content, post.thum, post.date, post.views, COUNT(reply.idx)  from post left join reply on post.idx=reply.ref where post.category=? group by post.idx order by post.idx desc LIMIT " + start + "," + limit
                    , ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        } else {
//            pstmt = conn.prepareStatement("SELECT * FROM post WHERE category=? AND title LIKE ? ORDER BY idx DESC LIMIT " + start + "," + limit
//                    , ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

pstmt = conn.prepareStatement("select post.idx, post.user_id, post.category, post.title, post.content, post.thum, post.date, post.views, COUNT(reply.idx)  from post left join reply on post.idx=reply.ref where post.category=? AND title LIKE ? group by post.idx order by post.idx desc LIMIT " + start + "," + limit
                    , ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

            pstmt.setString(2, "%" + search + "%");
        }
        pstmt.setString(1, currentCategory);
        rs = pstmt.executeQuery();

        int totalRecord = 0, cntCurrentRecord = 1;
        rs.last();
        totalRecord = rs.getRow();
        rs.beforeFirst();

        String str = null;
        if (totalRecord > 0) {
            str = "{\"data\":[";
            while (rs.next()) {
                str += "{"
                        + "\"idx\": \"" + rs.getInt(1) + "\","
                        + "\"user_id\": \"" + rs.getString(2) + "\","
                        + "\"category\": \"" + rs.getString(3) + "\","
                        + "\"title\": \"" + rs.getString(4) + "\","
                        + "\"content\": \"" + rs.getString(5).replace("\"", "'") + "\","
                        + "\"thum\": \"" + rs.getString(6) + "\","
                        + "\"date\": \"" + rs.getString(7) + "\","
                        + "\"views\": \"" + rs.getInt(8) + "\","
+ "\"count\": \"" + rs.getInt(9) + "\""
                        + "}";
                cntCurrentRecord++;

                if (cntCurrentRecord <= totalRecord) {
                    str += ",";
                } else {
                    str += "]}";
                }
            }
//            System.out.println(str);
        }
System.out.println(str);
        out.print(str);

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println(e.getMessage());
    }
%>