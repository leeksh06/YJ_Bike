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
	
	Connection conn=null;
	PreparedStatement pstmt=null;
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
   
   
  		
        pstmt=conn.prepareStatement("SELECT * FROM user WHERE user_id=? OR nickname=?");
  		pstmt.setString(1, user_id);
  		pstmt.setString(2, nickname);
  		rs = pstmt.executeQuery();
  		
  		if (rs.next()) {
  			// user_id or NAME already exists in the database
  			out.println("{\"success\":false, \"message\":\"user_id or NAME already exists\"}");
  		} else {
  			// user_id and NAME do not exist in the database, so insert the new member
  			pstmt=conn.prepareStatement("INSERT INTO user VALUES (?,?,?,?,?,?)");
  			pstmt.setString(1,user_id);
  			pstmt.setString(2,password);
  			pstmt.setString(3,password2);
  			pstmt.setString(4,nickname);
  			pstmt.setString(5,home_address);
            pstmt.setString(6,phone_number);

  			int result=pstmt.executeUpdate();
  			out.println("{\"success\":true, \"message\":\"Membership Success\"}");
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