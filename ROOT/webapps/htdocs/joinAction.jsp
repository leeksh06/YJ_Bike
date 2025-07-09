<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="password" />
<jsp:setProperty name="user" property="password2" />
<jsp:setProperty name="user" property="nickname" />
<jsp:setProperty name="user" property="home_address" />
<jsp:setProperty name="user" property="phone_number" />
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
	UserDAO userDAO = new UserDAO();
			if(session.getAttribute("user_id") != null){
				userID = (String)session.getAttribute("user_id");
				
			}
			// 이미 로그인했으면 회원가입을 할 수 없게 한다
			if(userID != null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인이 되어 있습니다')");
				script.println("location.href='test.jsp'");
				script.println("</script>");
			}
			if(user.getPassword() == null || user.getPassword2() == null){
		        PrintWriter script = response.getWriter();
		        script.println("<script>");
		        script.println("alert('입력이 안 된 사항이 있습니다')");
		        script.println("history.back()");
		        script.println("</script>");
		    } else if(!user.getPassword().equals(user.getPassword2())) {
		        PrintWriter script = response.getWriter();
		        script.println("<script>");
		        script.println("alert('비밀번호가 맞지 않습니다.')");
		        script.println("history.back()");
		        script.println("</script>");
		        
		    } else if(userDAO.nicknameExists(user.getNickname())) {
		        PrintWriter script = response.getWriter();
		        script.println("<script>");
		        script.println("alert('중복되는 닉네임이 있습니다')");
		        script.println("history.back()");
		        script.println("</script>");
		    } else if(user.getUser_id() == null || user.getPassword() == null ||user.getPassword2()==null || user.getNickname() == null ||
	        user.getHome_address() == null || user.getPhone_number() == null){
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('입력이 안 된 사항이 있습니다')");
	        script.println("history.back()");
	        script.println("</script>");
	    } else {
	       
	        int result = userDAO.join(user);
	        if(result == -1){
	            PrintWriter script = response.getWriter();
	            script.println("<script>");
	            script.println("alert('이미 존재하는 아이디입니다')");
	            script.println("history.back()");
	            script.println("</script>");
	        } else {
	            PrintWriter script = response.getWriter();
	            script.println("<script>");
	            script.println("alert('회원가입 성공')");
	            script.println("location.href='test.jsp'");
	            script.println("</script>");
	        }
	    }
	%>
</body>
</html>