<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String id = (String)session.getAttribute("user_id");
    int android = Integer.parseInt(request.getParameter("android"));
    UserDAO userDAO = new UserDAO();
    userDAO.deletePosts(id);
    userDAO.deleteComments(id);
    int result = userDAO.deleteUser(id);

    if ( result == 1 ) {
    	
    	session.invalidate(); // invalidate the session
	if (android == 1) {
		out.println("{\"success\":true, \"message\":\"Membership Success\"}");
		return;
	}
%>
        <script>
            alert("탈퇴가 완료되었습니다.");
            location.href = "test.jsp";
        </script>
<%
    } else {
%>
        <script>
            alert("Unsubscription failed");
        </script>
<%
    }
%>
