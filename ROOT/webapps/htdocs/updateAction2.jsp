<%@page import="javax.sound.sampled.TargetDataLine"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
    <%@ page import="java.io.IOException" %>
<%@ page errorPage="error.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    String userID = null;
    if(session.getAttribute("user_id") != null){
        userID = (String)session.getAttribute("user_id");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href='test.jsp'");
        script.println("</script>");
    }

    int idx = 0;
    if(request.getParameter("idx")!= null){
        idx = Integer.parseInt(request.getParameter("idx"));
    }

    if(idx == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("history.back()");
        script.println("</script");
    }

    Post post = new PostDAO().getPost(idx);
    if (post == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글을 찾을 수 없습니다')");
        script.println("history.back()");
        script.println("</script>");
    } else if (!userID.equals(post.getUser_id())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('You don't have permission')");
        script.println("location.href='test.jsp'");
        script.println("</script>");
    } else {
        if(request.getParameter("title") == null || request.getParameter("content") == null
            || request.getParameter("title").equals("") || request.getParameter("content").equals("")){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            PostDAO postDAO = new PostDAO();
            int result = postDAO.update(idx, request.getParameter("title"), request.getParameter("content"));
            if(result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글 수정하기에 실패했습니다')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글 수정하기 성공')");
                script.println("location.href='Untitled-4.jsp'");
                script.println("</script>");
            }
        }
    }
%>

</body>
</html>