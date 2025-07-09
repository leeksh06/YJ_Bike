<%@page import="java.io.PrintWriter"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="password" />
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
	if(session.getAttribute("user_id") != null){
		userID = (String)session.getAttribute("user_id");
	}
	
	// 이미 로그인했으면 다시 로그인을 할 수 없게 한다
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어 있습니다')");
		script.println("location.href='test.jsp'");
		script.println("</script>");
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUser_id(), user.getPassword());
	if(result == 1){
		session.setAttribute("user_id",user.getUser_id());
		String nickname = userDAO.getNickname(user.getUser_id());
		session.setAttribute("nickname", nickname);
		
		// 아이디 저장하기 기능
		if ("on".equals(request.getParameter("savedID"))) {
			Cookie idCookie = new Cookie("savedID", user.getUser_id());
			idCookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 1주일
			response.addCookie(idCookie);
		} else {
			Cookie idCookie = new Cookie("savedID", "");
			idCookie.setMaxAge(0);
			response.addCookie(idCookie);
		}
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 성공')");
		script.println("location.href='Untitled-3.jsp'");
		script.println("</script>");
	} else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다')");
		script.println("history.back()");
		script.println("</script>");
	} else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류입니다')");
			script.println("history.back()");
			script.println("</script>");
		}
	
	%>

</body>
</html>