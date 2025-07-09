<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="reply.Reply" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>댓글 삭제</title>
</head>
<body>
    <%
    String userID = null;
    if(session.getAttribute("user_id") != null){
        userID = (String)session.getAttribute("user_id");
    }
    ReplyDAO replyDAO = new ReplyDAO();

    int replyID = 0;
    if (request.getParameter("idx") != null){
        replyID = Integer.parseInt(request.getParameter("idx"));
        
    }
  
   
    if (userID == null ) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href = 'test.jsp'");
        script.println("</script>");                
    } else {
        // 댓글을 삭제하기 전에 참조 게시글의 ID를 얻습니다.
       
        // 이후 댓글을 삭제합니다.
        int result = replyDAO.delete(replyID);
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('댓글 삭제에 실패했습니다')");
            
            script.println("</script>");
        } else {
        	 
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('댓글 삭제 완료\\n 새로 고침을 눌러주세요 ')");
           
            script.println("history.back()");
           
            script.println("</script>");
        }
    }
    %>
</body>
</html>
