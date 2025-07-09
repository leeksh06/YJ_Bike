<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String[] posts = request.getParameterValues("chkPost");
    String[] replies = request.getParameterValues("chkReply");
    String boardType = request.getParameter("board");

    StringBuilder query = new StringBuilder();

    if (posts != null) {
        query.append("DELETE FROM ").append("post").append(" WHERE idx IN (");
        for (String str : posts) {
            query.append(str);
            query.append(",");
        }
    }
    if (replies != null) {
        query.append("DELETE FROM ").append("reply").append(" WHERE idx IN (");
        for (String str : replies) {
            query.append(str);
            query.append(",");
        }
    }
    query.replace(query.length() - 1, query.length(), ")");
    String pageNum = "1";
    if (request.getParameter("pageNum") != null) {
        pageNum = request.getParameter("pageNum");
    }

    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";

    Connection conn;
    Statement stmt;
    int result = 0;
    boolean check = false;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        stmt = conn.createStatement();
        result = stmt.executeUpdate(query.toString());

        if (result > 0) {
            check = true;
        }

        conn.close();
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }

%>

<script type="text/javascript">
    function isAtLeastOneCheckboxChecked() {
        var checkboxes = document.getElementsByName('chkPost');
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                return true;
            }
        }

        checkboxes = document.getElementsByName('chkReply');
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                return true;
            }
        }

        alert('Please select at least one item to delete.');
        return false;
    }

    if (<%=check%>) {
        alert("삭제 성공");
    } else {
        alert("오류 발생");
    }
    location.replace("MyInfo<%=boardType%>.jsp?pageNum=<%=pageNum%>");
</script>
