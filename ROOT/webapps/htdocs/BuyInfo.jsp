<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>

<!doctype html>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title> 구매 </title>
    <style>
    #snow {
 			 position: fixed;
 top: 0;
 			 left: 0;
 			 width: 100%;
 			 height: 100%;
 			 z-index: -1;
 			 opacity: 0.9;
 	 }


        div#wrap {
            background: #fff;
        }

        header#header {
            background: #fff;
            text-align: center;
            justify-content: center;
            align-items: center;
        }

        nav#nav {
background: linear-gradient(to left, #1488cc,#2b32b2);
color: white;
margin-left: auto;
margin-right: auto;
width: 100%;
}



@media (min-width: 1800px) {
nav#nav {
width: 60%;
}
}

        div#warp, header#header {
            padding: 10px;
        }

        nav#nav ul {
            margin: 0 auto;
            padding: 0;
            list-style: none;
            text-align: center;
        }

        nav#nav ul li {
            padding: 10px;
            display: inline-block;
        }
        nav#nav ul li:hover {
            display: inline-block;
            background: #a9a9f5;
        }
        #nav ul li a { color : white; }
        a { text-decoration: none;}

        .container {
            width: 1200px;
            margin: 20px auto;
            padding: 10px;
            border-radius:10px 10px 10px 10px;
            background-color:#fff;
            border:2px solid black;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: #EFE7DB;
        }

        tr {
            border: 2px solid #000;
        }

        th {
            padding: 15px;
        }

        td {
            text-align: center;
        }

        h3 {
            font-size: 30px;
            margin: 20px;
        }

        hr {
            margin-top: 10px;
        }

        * {
            margin: 0;
            padding: 0;
        }

        .write_button {
            background-color: #475d9f;
            border: 1px solid #323f6b;
            color: #ffffff;
            border-radius: 4px;
            padding: 2px 8px;
            font-size: 18px;
            margin-top: 10px;
        }

        .text_link {
            color: #0000ff;
        }

        .buyInfo b {
            font-size: 20px;
        }

        .buyInfo p {
            margin: 5px 10px;
        }

        .buyInfo .userInfo {
            width: 65%;
            display: inline-block;
        }

        .buyInfo .price {
            width: 30%;
            display: inline-block;
        }
    </style>
</head>

<%
    String name = "null", photo = "logo.png";
    int productIdx = 0, count = 0, price = 0;

	String userId = session.getAttribute("user_id").toString();
    String nickname = "null", home = "null", phone = "null";
    if (request.getParameter("idx") != null) {
        productIdx = Integer.parseInt(request.getParameter("idx"));
    }
    if (request.getParameter("count") != null) {
        count = Integer.parseInt(request.getParameter("count"));
    }

    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";

    Connection conn;
    Statement stmt;
    ResultSet rs;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        stmt = conn.createStatement();


        rs = stmt.executeQuery("SELECT * FROM product WHERE idx=" + productIdx);
        rs.next();
        name = rs.getString("product_name");
        photo = rs.getString("product_photo");
        if (photo.equals("photo")) {
            photo = "logo.png";
        }
        price = count * rs.getInt("price");


        rs = stmt.executeQuery("SELECT * FROM user WHERE user_id = '" + userId + "'");

        rs.next();
        nickname = rs.getString("nickname");
        home = rs.getString("home_address");
        phone = rs.getString("phone_number");

        conn.close();
        stmt.close();
        rs.close();
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
%>
<body>

<div id="wrap">
  <div id="snow"><%@include file="snow222.jsp"%></div>
    <header id="header">
        <a href="test.jsp"> <img src="./logo.png" alt="Your Logo"/> </a>
    </header>
    <nav id="nav" style="border:2px solid black; border-radius: 10px 10px 10px 10px;">  
        <ul>
            <li><a href="Untitled-5.jsp">공지사항</a></li>
            <li><a href="Untitled-4.jsp">사용 방법</a></li>
            <li><a href="Untitled-2.jsp">자유게시판</a></li>
            <li><a href="Untitled-3.jsp">문의 게시판</a></li>
            <li><a href="kit.jsp">키트구매처</a></li>
        </ul>
    </nav>
</div>

<div class="container">
    <hr/>
    <h3> 결제 페이지 </h3>
    <table cellspacing="0" class="tb_products">
        <colgroup>
            <col width="150">
            <col width="300">
            <col width="120">
            <col width="110">
            <col>
        </colgroup>
        <thead class="thead">
        <tr>
            <th scope="col" colspan="2">상품정보</th>
            <th scope="col">수량</th>
            <th scope="col">상품금액</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <a href="링크" class="">
                    <span class="mask"></span>
                        <img src="./img/1_1.png" style="width: 50%; height: 20%;  border-radius: 10px;">
                </a>
            </td>
            <td>
                <a href="링크" class="text_link">
                    <strong>
                        <%=name%>
                    </strong>
                </a>
            </td>
            <td><%=count%> 개</td>
            <td class="col_price">
                <strong><em><%=price%>
                </em> 원</strong>
            </td>
        </tr>
        </tbody>
    </table>
    <hr/>

    <div class="buyInfo">
        <div class="userInfo">
            <b> 배송지 정보 </b>
            <p><%=nickname%></p>
            <p><%=home%></p>
            <p><%=phone%></p>
        </div>
        <div class="price">
            <b> 주문 금액 </b>
            <p><%=price%> 원 </p>
        </div>
    </div>
    <hr/>
   <button class="write_button" onclick="window.location.href='Buycomplete.jsp?idx=<%=productIdx%>&count=<%=count%>'">구매하기</button>
<button class="write_button" onclick="window.location.href='kit.jsp'">돌아가기</button>
</div>
</body>
</html>
