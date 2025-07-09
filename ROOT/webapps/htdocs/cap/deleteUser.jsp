<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%
    request.setCharacterEncoding("UTF-8");
    String user_id = (String)request.getParameter("user_id");

    UserDAO userDAO = new UserDAO();
    userDAO.deletePosts(user_id);
    userDAO.deleteComments(user_id);
    userDAO.deleteRank(user_id);
    int result = userDAO.deleteUser(user_id);

    if (result == 1) {
        session.invalidate(); // invalidate the session
        out.println("{\"success\":true, \"message\":\"Membership Success\"}");
    }
%>