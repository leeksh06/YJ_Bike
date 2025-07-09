<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="reply" class="reply.Reply" scope="page"/>
<jsp:setProperty name="reply" property="*"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
    int idx=1;
    if(request.getParameter("idx")!=null){
        idx=Integer.parseInt(request.getParameter("idx"));
    }

    String userID=null;
    if(session.getAttribute("user_id")!=null){
        userID=(String)session.getAttribute("user_id");
    }

    if(userID==null){
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('로그인이 필요합니다.')");
        script.println("history.back()");
        script.println("</script>");   
    }
    else{
        if(reply.getContent()==null){
            PrintWriter script= response.getWriter();
            script.println("<script>");
            script.println("alert('댓글을 입력해주세요.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            ReplyDAO replyDAO=new ReplyDAO();
            reply.setUser_id(userID);
            reply.setIdx(idx);
            reply.setDate(new Timestamp(System.currentTimeMillis()));
            int result = replyDAO.write(reply);
            if(result==-1){
                PrintWriter script= response.getWriter();
                script.println("<script>");
                script.println("alert('댓글쓰기에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }
            else{
                String url="View3.jsp?idx="+idx;
                PrintWriter script= response.getWriter();
                script.println("<script>");
                script.println("location.href=document.referrer;");
                script.println("</script>");
            }
        }
    }
%>

</body>
</html>
