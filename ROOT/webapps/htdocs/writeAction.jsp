<%@page import="java.io.PrintWriter"%>
<%@page import="post.PostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="post" class="post.Post" scope="page" />
<jsp:setProperty name="post" property="title" />
<jsp:setProperty name="post" property="content" />
<jsp:setProperty name="post" property="category" value="not" />
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>

	<%
		// 현재 세션 상태를 체크한다
		String userID = null;
		if(session.getAttribute("user_id")!= null){
			userID = (String)session.getAttribute("user_id");
		}
		// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			// 입력이 안 된 부분이 있는지 체크한다
			if(post.getTitle() == null || post.getContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
				PostDAO PostDAO = new PostDAO();
				int result = PostDAO.write(post.getTitle(),userID,post.getContent(),post.getCategory());
				// 데이터베이스 오류인 경우
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기 성공')");
					script.println("location.href='Untitled-5.jsp'");
					script.println("</script>");
				}
			}
		}
	
	%>
</body>
</html>