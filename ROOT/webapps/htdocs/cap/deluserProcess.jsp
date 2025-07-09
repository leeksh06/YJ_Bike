<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
    
<%
	String user_id=request.getParameter("user_id");

	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
   
    String url = "jdbc:mysql://localhost/capdb";
        String username = "root";
        String Sqlpassword = "1234";
	
	try {
  		
           Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, Sqlpassword);
  		
  		pstmt=conn.prepareStatement("SELECT * FROM user WHERE user_id=?");
  		pstmt.setString(1,user_id);
  		rs=pstmt.executeQuery();
  		
        
  		if(rs.next()){
               pstmt=conn.prepareStatement("DELETE FROM user WHERE user_id=?");
               pstmt.setString(1,user_id);
               int result=pstmt.executeUpdate();
                out.println("{\"success\":true, \"message\":\"유저 삭제 성공\"}");
  		}
	}catch(Exception e){
		e.printStackTrace();
 	}finally{
 		try{
 			rs.close();
 			pstmt.close();
 			conn.close();
 		}
 		catch(Exception e){
 			e.printStackTrace();
 		}
 	}
%>
