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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
   #free55{
  background-color:#fff;

 }
		div#wrap {
		background:#fff;
	}
	header#header {
		background:#fff;
		text-align: center;
		justify-content: center;
		align-items: center;
	}
	   nav#nav {
			background: linear-gradient(to left, #1488cc,#2b32b2);


		color: white;
		}
	div#warp, header#header, nav#nav {
		padding:10px;
	}
	nav#nav ul {
		margin:0 auto;
		padding:0;
		list-style:none;
		text-align: center;
	}
	nav#nav ul li {
		padding:10px; display:inline-block;
	}

		.container {
		width: 1200px;
		margin: 20px auto;
		padding: 10px;
			margin: 0 auto;
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


		div#wrap {
		background:#fff;
	}
		header#header {
		background:#fff;
		text-align: center;
		justify-content: center;
		align-items: center;
	}
    nav#nav {
		background-color: rgb(100, 149, 237);
		color: white;
	}
	div#warp, header#header, nav#nav {
		padding:10px;
	}
	nav#nav ul {
		margin:0 auto; padding:0; list-style:none; text-align: center;
	}
    nav#nav ul li {
		padding:10px; display:inline-block;
	}

	* {margin:0;padding:0;}

	.write_button {
		background-color: #475d9f;
		border: 1px solid #323f6b;
		color: #ffffff;
		border-radius: 4px;
		padding: 2px 8px;
		font-soze: 18px;
		margin-top: 10px;
	}

.text_link {
	color: #0000ff;
}

.buyInfo b {
font-size:20px;
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
nav#nav ul li:hover {
    background-color:#A9A9F5; opacity: 0.9;
}
nav#nav ul { margin:0 auto; padding:0; list-style:none; text-align: center; }
        nav#nav ul li {  padding:10px; display:inline-block; }
		nav#nav ul li a {display:inline-block;color:white;text-decoration:none;}
		#nav ul > li > div:hover {background-color:#A9A9F5; opacity: 0.9;}
  #Buy123{
		width: 950px;
		height: 300px;
		border: 2px solid black;
		text-align: center;
		background-color: #E6E6E6;
		margin: 10px auto;
  }
	#Buy1234{
		width: 950px;
		height: 650px;
		border: 2px solid black;
		text-align: center;
		margin-top: 1px;
		margin-left: auto;
		margin-right: auto;
		background-color:#fff;
	}
	#Buy12345{
		width: 950px;
		height: 100px;
		border: 2px solid black;
		margin: 1px auto 100px;
		background-color:#fff;
	}
	#Buy123 > ul {color:#848484;font-size:1.1em;}

	#Button153 {
		width:200px;
		height: 50px;
		margin-top:20px;
		margin-left:180px;
		border:2px solid black;
		text-align: center;
		font-size:1.6em;
		background-color:#BDBDBD;
		color:black;
		border-radius:15px 15px 15px 15px;
	}
	#Button154 {
		width:200px;
		height:50px;
		margin-top:-54px;
	  margin-left:600px;
		border:2px solid black;
		text-align: center;
		font-size:1.6em;
		background-color:#2E2E2E;
		color:white;
	border-radius:15px 15px 15px 15px;
	}

		   #nav > ul > a  { text-decoration : none; }

#Buy1234 .image-container {
			width: 300px;
			height: 200px;
			border: 2px solid black;
			margin: 20px;
			float: left;
			position: relative;
			top: -20px; /* 추가된 코드 */
		}
		.image-container{
			border-radius: 25px 25px 25px 25px;
		}

#Buy1234 .divider {
			width: 100%;
			height: 2px;
			background-color: black;
			
			margin: 20px 0;
		}


#Buy1234 .product-info {
			padding-left: 30px;
		}
		#Buy1234 .product-info h2 {
			text-align: right;
		}

.thank-you-message {
			width: 100%;
			text-align: center;
			margin-top: 20px;
		}
		
.delivery-info {
  text-align: center;
  margin-left: -20px;
  padding-left: 20px;
}

	</style>

<head>
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
       <a href="test.jsp"> <img src="./logo.png" alt="Your Logo" /> </a>
	</header>
	<nav id="nav">
	<ul>
	<li><a href="Untitled-5.jsp">공지사항</li>
            <li><a href="Untitled-4.jsp">사용 방법</li>
			<li><a href="Untitled-2.jsp">자유게시판</a></li>
			 <li><a href="Untitled-3.jsp">문의 게시판</li>
			  <li><a href="kit.jsp">키트구매처</a></li>
	</ul>
    </nav>
</div>

<div id="Buy123">
	<h3>주문완료</h3>
	<br><br><h2>주문번호:216111919166</h2><br><br>
  <ul>고객님의 주문이 완료되었습니다.</ul>
</div>
<div id="Buy1234">
<h3>주문목록</h3>

<div class="image-container">
<img src="./img/1_1.png" style="width: 100%; height: 70%;  border-radius: 10px;">
</div>

<div class="product-info">
		<h2>상품정보: <%=name%></h2>
		<br><br><h2>수량:<%=count%>개</h2><br>
		<br><h2>주문 상품 금액:<%=price%>원</h2><br>
	</div>


<div class="divider"></div>
      <h3>배송지 정보&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</h3>
	  <div class="delivery-info">
<div class="product-info">
		<h2>고객명:<%=nickname%></h2>
		<br><br><h2>주소:<%=home%></h2><br>
		<br><h2>연락처:<%=phone%></h2><br>
	</div>

<div class="thank-you-message"><h2>구매해주셔서 감사드립니다.</h2></div>
</div>

<div id="Buy12345">
 <div id="Button153"  onclick="window.location.href='kit.jsp'">확인</div>
 <div id="Button154"  onclick="window.location.href='test.jsp'">메인메뉴</div>
</div>

</body>


</html>
