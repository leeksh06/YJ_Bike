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
            // ID에 해당하는 다른 속성의 값을 변수에 저장
            String home_address = rs.getString("home_address");

            // 안드로이드 앱으로 응답 전송
            out.print("{\"home_address\":\"" + home_address + "\"}");
   
        } else {
            // ID에 해당하는 데이터가 없는 경우
            out.print("{\"error\":\"ID not found\"}");
        }

        // 자원 해제
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        // 예외 처리
        e.printStackTrace();
        out.print("{\"error\":\"" + e.getMessage() + "\"}");
    }
%>