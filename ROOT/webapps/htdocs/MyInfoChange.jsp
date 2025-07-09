<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>회원정보 수정</title>
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
		a { text-decoration: none; }

        .container {
            width: 1200px;
            margin: 20px auto;
            padding: 10px;
            border: 2px solid black;
            border-radius:10px 10px 10px 10px;
            background-color:#fff;
        }

        .container table {
            width: 100%;
        }

        .container td {
            padding: 10px;
            font-size: 20px;
        }

        .container td input {
            background-color: rgb(233, 233, 233);
            outline: none;
            border: 0;
            font-size: 20px;
            padding: 10px;
            width: 100%;
        }

        .container tr td:nth-child(1) {
            width: 20%;
            border-right: solid;

        / / border: 1 px solid red;
        }

        .container tr td:nth-child(2) {
            width: 67%;

        / / border: 1 px solid blue;
        }

        button {
            background-color: #475d9f;
            border: 1px solid #323f6b;
            color: #ffffff;
            border-radius: 4px;
            padding: 5px 8px;
            font-size: 20px;
            margin-top: 10px;
        }

        .container {
            width: 1200px;
            margin: 10px auto;
            padding: 5px;
            display: flex;
            flex-wrap: wrap;
            align-items: flex-start;
            border: 1px solid #000;
        }

        .sideMenu {
            width: 280px;
            padding: 5px;
            border: 1px solid red;
        }

        .sideMenu ul {
            list-style: none;
            padding: 5px;
        }

        .sideMenu ul li a {
			text-decoration: none;
			display: block;
			color: #000;
			padding: 8px 15px 8px 15px;
			font-weight: bold;
        }

        .sideMenu ul li a:hover {
            background: rgb(100, 149, 237);
			color: white;
        }

        .infoContent {
            width: 890px;
            padding: 5px;
            border: 1px solid blue;
        }

        .infoMenu ul li {
            display: inline-block;
            margin-right: 30px;
            padding: 10px;
        }

        .infoMenu ul li:hover {
            cursor: pointer;
            background: #475d9f;
        }

        * {
            margin: 0;
            padding: 0;
        }
    </style>

</head>
<%
UserDAO userDAO = new UserDAO();
User user = userDAO.getUserById((String)session.getAttribute("user_id"));
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
    <div class="sideMenu">
        <h3 style="margin: 5px 10px 0 10px">내 정보</h3>
        <ul>
            <li><a href="MyInfoDist.jsp">달린 거리</a></li>
            <li><a href="MyInfoBoard.jsp">게시글 삭제</a></li>
            <li><a href="MyInfoReply.jsp">댓글 삭제</a></li>
            <li><a href="MyInfoChange.jsp">내 정보 변경</a></li>
        </ul>
    </div>
    <div class="infoContent">
        <h3 style="font-size:30px;"> 회원정보 수정 </h3>
        <form action="changePro.jsp" method="post">
            <table>
                <tr>
                    <td> 아이디</td>
                    <td>
                    <input type="text" placeholder="아이디" value="<%=user.getUser_id()%>" name="id" readonly>

                    </td>
                </tr>
                <tr>
                    <td> 닉네임</td>
                    <td>
                        <input type="text" placeholder="닉네임" value="<%=user.getNickname()%>" name="nick">
                    </td>
                    <td>


                    </td>
                </tr>
                <tr>
                    <td> 비밀번호</td>
                    <td>
                        <input type="text" placeholder="비밀번호" name="pass">
                    </td>
                </tr>
                <tr>
                    <td> 비밀번호 확인</td>
                    <td>
                        <input type="text" placeholder="비밀번호 확인" name="pass2">
                    </td>
                </tr>
                <tr>
                    <td> 집주소</td>
                    <td>
                        <input type="text" placeholder="<%=user.getHome_address()%>" name="home">
                    </td>
                </tr>
                <tr>
                    <td> 전화번호</td>
                    <td>
                        <input type="text" placeholder="<%=user.getPhone_number()%>" name="phone">
                    </td>
                </tr>
            </table>
            <button type="submit"> 변경하기 </button>
        </form>
        <form action="unsubscribe.jsp" method="post" id="unsubscribeForm">
        <input type="hidden" value="<%=user.getUser_id()%>" name="id" />
        <button type="button" onclick="confirmUnsubscribe()"> 탙퇴하기</button>
    </form>
    </div>
</div>
<script>
    function confirmUnsubscribe() {
        let confirmation = confirm("정말로 탈퇴하시겠습니까?");
        if (confirmation) {
            document.getElementById('unsubscribeForm').submit();
        }
    }
</script>
</body>
