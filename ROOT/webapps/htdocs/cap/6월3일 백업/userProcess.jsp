<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String id=request.getParameter("id");
   
   	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;

  try {
  		Context init = new InitialContext();
  		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB");
  		conn = ds.getConnection();
  		
  		pstmt=conn.prepareStatement("SELECT * FROM member WHERE id=?");
  		pstmt.setString(1,id);
  		rs=pstmt.executeQuery();
        // 결과 처리
        if (rs.next()) {
            // ID에 해당하는 다른 속성의 값을 변수에 저장
            String name = rs.getString("pass");
            String pass = rs.getString("name");
            String home = rs.getString("home");
            String phone = rs.getString("phone");

            // 안드로이드 앱으로 응답 전송
            out.print("{\"id\":\"" + id + "\", \"pass\":\"" + pass + "\", \"name\":\"" + name + "\", \"home\":\"" + home + "\", \"phone\":\"" + phone + "\"}");
   
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