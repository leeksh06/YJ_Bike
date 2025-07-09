
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
.margin_right {
	margin_right: 10px;
}

.rank_wrap {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.rank_wrap span:first-child {
	width: 40px;
}
.rank_wrap span:last-child {
	width: 70px;
}
</style>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	String title = "include ranking";

	long now = System.currentTimeMillis();
	java.util.Date date = new java.util.Date(now);
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-");
	String time = dateFormat.format(date);
	String sqlDate = time + "%";
	//String sqlDate = "2023-06-%";


	String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
	
	ArrayList<String> nickArr = new ArrayList<String>();
	ArrayList<String> disArr = new ArrayList<String>();
	
	try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        pstmt = conn.prepareStatement("select nickname, max(distance) dis from cycle C, user U where C.user_id=U.user_id and date like ? group by C.user_id order by dis desc limit 0,10");
		pstmt.setString(1, sqlDate);
        rs = pstmt.executeQuery();

        while (rs.next()) {
			nickArr.add(rs.getString("nickname"));
			disArr.add(rs.getString("dis"));
		}
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
%>
<div id="rank">
<img src="./img/rank.png" style="width: 50%; height: 10%;">
<%for(int i = 0; i < nickArr.size(); i++) {%>
<div class="rank_wrap">
	<span><%=(i+1)+"등"%></span>
	<span><%=nickArr.get(i)%></span>
	<span><%=disArr.get(i)+"km"%></span>
</div>
<%}%>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>