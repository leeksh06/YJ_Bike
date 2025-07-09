<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="reply.Reply" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.net.URLDecoder" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>

<title></title>
<script type="text/javascript">
    window.name='commonUpdate';
</script>
</head>
<body>

    <%
    String userID = null;
    if(session.getAttribute("user_id") != null){
        userID = (String)session.getAttribute("user_id");
    }

    int replyID = 0;
    if (request.getParameter("idx") != null){
        replyID = Integer.parseInt(request.getParameter("idx"));
    }
    String replyText = null;
    if (request.getParameter("content")!=null){
        replyText = URLDecoder.decode(request.getParameter("content"), "UTF-8");
    }

    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = 'test.jsp'");
        script.println("</script>");
    } 

    String replyText2 = new ReplyDAO().getUpdateReply(replyID);

    if (userID == null || replyText2 == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href = 'test.jsp'");
        script.println("</script>");                
    } else {
        if (replyText2.equals("")){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            ReplyDAO replyDAO = new ReplyDAO();
            int result = replyDAO.update(replyID, replyText);
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('댓글수정에 실패했습니다')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                int PostID = replyDAO.getPostIdByReplyId(replyID);
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('댓글 수정 완료')");
                script.println("location.href= \'View3.jsp?idx="+PostID+"\'");
                script.println("</script>");
            }
        }
    }

    %>
</body>
</html>
