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
   
        //Context init = new InitialContext();
  		//DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB");
  		//conn = ds.getConnection();
  		
  		
  		pstmt=conn.prepareStatement("SELECT * FROM user WHERE user_id=?");
  		pstmt.setString(1,user_id);
  		rs=pstmt.executeQuery();
        // 결과 처리
        if (rs.next()) {
          out.print(
                    "{\"user_id\":\""+rs.getString("user_id")+"\",\"password\":\""+rs.getString("password")+"\",\"password2\":\""+rs.getString("password2")+"\",\"nickname\":\""+rs.getString("nickname")+"\",\"home_address\":\""+rs.getString("home_address")+"\",\"phone_number\":\""+rs.getString("phone_number")+"\"}"
                );
        } else {
            out.print("{\"error\":\"ID not found\"}");
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.print("{\"error\":\"" + e.getMessage() + "\"}");
    }
%>