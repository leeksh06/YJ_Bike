<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
UserDAO userDAO = new UserDAO();
String pID = request.getParameter("id");
String pNick = request.getParameter("nick");
String pPass = request.getParameter("pass");
String pPass2 = request.getParameter("pass2");
String pHome = request.getParameter("home");
String pPhone = request.getParameter("phone");

User user = new User();
user.setUser_id(pID); // Add this line
user.setPassword(pPass);
user.setPassword2(pPass2);
user.setNickname(pNick);
user.setHome_address(pHome);
user.setPhone_number(pPhone);

    // Check for empty fields
    if (pNick.isEmpty() || pPass.isEmpty() || pPass2.isEmpty() || pHome.isEmpty() || pPhone.isEmpty()) {
        out.println("<script>alert('입력 안된 사항이 있습니다.');</script>");
        out.println("<script>history.back();</script>");
    } else {
        if (pPass.equals(pPass2)) {
            try {
                // Check for duplicate nickname
                if (userDAO.isNicknameDuplicate(pNick)) {
                    // Duplicate nickname
                    out.println("<script>alert('중복된 닉네임입니다.');</script>");
                    out.println("<script>history.back();</script>");
                } else {
                    // Update user information including nickname
                    userDAO.updateUser(user);

                    // Display success message
                    out.println("<script>alert('변경사항이 저장되었습니다');</script>");
                    out.println("<script>history.back();</script>");
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        } else {
            // Display error message for password mismatch
            out.println("<script>alert('비밀번호가 일치하지 않습니다.');</script>");
            out.println("<script>history.back();</script>");
        }
    }
%>




