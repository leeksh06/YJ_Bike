<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
    request.setCharacterEncoding("UTF-8");	
	String user_id=request.getParameter("user_id");
	String password=request.getParameter("password");
	String password2=request.getParameter("password2");
	String nickname=request.getParameter("nickname");
	String home_address=request.getParameter("home_address"); 
   String phone_number=request.getParameter("phone_number"); 

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
   
   String url = "jdbc:mysql://localhost/capdb";
        String username = "root";
        String Sqlpassword = "1234";

   try {
   
   Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, Sqlpassword);
   
  		//Context init = new InitialContext();
  		//DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB");
  		//conn = ds.getConnection();
   
   
  		
        pstmt=conn.prepareStatement("SELECT * FROM user WHERE nickname=?");
  		pstmt.setString(1, nickname);
  		rs = pstmt.executeQuery();
  		
  		if (rs.next()) {
  			// ID or NAME already exists in the database
  			out.println("{\"success\":false, \"message\":\"닉네임 중복\"}");
  		} else {
  			// ID and NAME do not exist in the database, so insert the new member
  			pstmt=conn.prepareStatement("UPDATE user SET password=?, password2=?, nickname=?, home_address=?, phone_number=? WHERE user_id=?");
  			
  			pstmt.setString(1,password);
  			pstmt.setString(2,password2);
  			pstmt.setString(3,nickname);
  			pstmt.setString(4,home_address);
            pstmt.setString(5,phone_number);
            pstmt.setString(6,user_id);

  			int result=pstmt.executeUpdate();
  			out.println("{\"success\":true, \"message\":\"수정 성공\"}");
  		}
   
    } catch(Exception e){
        e.printStackTrace();
        out.println("{\"success\":false, \"message\":\"" + e.getMessage() + "\"}");
    } finally{
        try{
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
%>
    