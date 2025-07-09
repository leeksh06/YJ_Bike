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
<head class="bb">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <title>YJ Bike V</title>



<style>

        div#wrap {
		 width: 1200px;
            margin: 0 auto;
            position: relative;

		}
        header#header {

		text-align: center;
		justify-content: center;
		align-items: center;
		}
        nav#nav {
			background: linear-gradient(to left, #1488cc,#2b32b2);


		color: white;
		}
       section#container {
           width : 950px;
			height: 1450px;
			text-align:left;
			float:left;
			padding:10px;



        }
        #nav > ul > a  { text-decoration : none; }
        div.content {
			background:#fff;
		}
         aside#aside {

			  width: 250px;
			  height: 1500px;
			  float: right;
			  color: black;
			  text-align: center;
			  line-height: 50px;

		}

  #aside1{
		 width: 250px;
		 height: 300px;
    text-align: center;
  	border:3px solid black;
		border-radius: 15px 15px 15px 15px;
		background-color: #fff;
		margin-bottom:10px;
  }
      footer#footer {


			bottom:0;
			width:100%;
			height:70px;
			background:#102b6a;
			margin:auto;
			clear:both;
			 color: white;
			  text-align: center;
		}

        div#wrap, header#header, nav#nav,
        section#container, div.content, aside#aside,


        nav#nav ul { margin:0 auto; padding:0; list-style:none; text-align: center; }
        nav#nav ul li {  padding:10px; display:inline-block; }
		nav#nav ul li a {display:inline-block;color:white;text-decoration:none;}

	div.content { width:60%; float:left; }


* {margin:0;padding:0;}
	.section input[id*="slide"] {display:none;}
	.section .slidewrap {max-width:1200px;margin:0 auto;}
	.section .slidelist {white-space:nowrap;font-size:0;overflow:hidden;position:relative;}
	.section .slidelist > li {display:inline-block;vertical-align:middle;width:100%;transition:all .5s;}
	.section .slidelist > li > a {display:block;position:relative;}
	.section .slidelist > li > a img {width:100%;}
	.section .slidelist label {position:absolute;z-index:10;top:50%;transform:translateY(-50%);padding:50px;cursor:pointer;}
	.section .slidelist .textbox {position:absolute;z-index:1;top:50%;left:50%;transform:translate(-50%,-50%);line-height:1.6;text-align:center;}
	.section .slidelist .textbox h3 {font-size:36px;color:#fff;;transform:translateY(30px);transition:all .5s;}
	.section .slidelist .textbox p {font-size:16px;color:#fff;opacity:0;transform:translateY(30px);transition:all .5s;}

	/* input에 체크되면 슬라이드 효과 */
	.section input[id="slide01"]:checked ~ .slidewrap .slidelist > li {transform:translateX(0%);}
	.section input[id="slide02"]:checked ~ .slidewrap .slidelist > li {transform:translateX(-100%);}
	.section input[id="slide03"]:checked ~ .slidewrap .slidelist > li {transform:translateX(-200%);}

	/* input에 체크되면 텍스트 효과 */
	.section input[id="slide01"]:checked ~ .slidewrap li:nth-child(1) .textbox h3 {opacity:1;transform:translateY(0);transition-delay:.2s;}
	.section input[id="slide01"]:checked ~ .slidewrap li:nth-child(1) .textbox p {opacity:1;transform:translateY(0);transition-delay:.4s;}
	.section input[id="slide02"]:checked ~ .slidewrap li:nth-child(2) .textbox h3 {opacity:1;transform:translateY(0);transition-delay:.2s;}
	.section input[id="slide02"]:checked ~ .slidewrap li:nth-child(2) .textbox p {opacity:1;transform:translateY(0);transition-delay:.4s;}
	.section input[id="slide03"]:checked ~ .slidewrap li:nth-child(3) .textbox h3 {opacity:1;transform:translateY(0);transition-delay:.2s;}
	.section input[id="slide03"]:checked ~ .slidewrap li:nth-child(3) .textbox p {opacity:1;transform:translateY(0);transition-delay:.4s;}

	/* 좌,우 슬라이드 버튼 */
	.slide-control > div {display:none;}
	.section .left {left:30px;background:url('./img/left.png') center center / 100% no-repeat;}
	.section .right {right:30px;background:url('./img/right.png') center center / 100% no-repeat;}
	.section input[id="slide01"]:checked ~ .slidewrap .slide-control > div:nth-child(1) {display:block;}
	.section input[id="slide02"]:checked ~ .slidewrap .slide-control > div:nth-child(2) {display:block;}
	.section input[id="slide03"]:checked ~ .slidewrap .slide-control > div:nth-child(3) {display:block;}

	/* 페이징 */
	.slide-pagelist {text-align:center;padding:20px;}
	.slide-pagelist > li {display:inline-block;vertical-align:middle;}
	.slide-pagelist > li > label {display:block;padding:8px 30px;border-radius:30px;background:#ccc;margin:20px 10px;cursor:pointer;}
	.section input[id="slide01"]:checked ~ .slidewrap .slide-pagelist > li:nth-child(1) > label {background:#999;}
	.section input[id="slide02"]:checked ~ .slidewrap .slide-pagelist > li:nth-child(2) > label {background:#999;}
	.section input[id="slide03"]:checked ~ .slidewrap .slide-pagelist > li:nth-child(3) > label {background:#999;}



.login-wrapper{
    width: 300px;
    height: 300px;
    padding: 20px;
    box-sizing: border-box;
}

.login-wrapper > h2{
    font-size: 24px;
    color: rgb(100, 149, 237);
    margin-bottom: 20px;
}
#login-form > input{
    width: 100%;
    height: 48px;
    padding: 0 5px;
    box-sizing: border-box;
    margin-bottom: 16px;
    border-radius: 6px;
    background-color: #F8F8F8;
}
#login-form > input[type="checkbox"]{
    display: none;
}
#login-form > input[type="submit"]{
    color: #fff;
    font-size: 16px;
    background-color: rgb(100, 149, 237);
    margin-top: 1px;
}
#login-form > input[type="submit2"]{
    color: #fff;
    font-size: 16px;
    background-color: rgb(100, 149, 237);
    margin-top: 1px;
}
#login-form label {
  display: flex;
  align-items: center;
}

#login-form label > input[type="checkbox"] {
  margin-right: 5px;
}
div#rank{
	width : 250px;
  height: 500px;
  border: 3px solid black;
  border-radius: 10px 10px 10px 10px;
  margin-bottom:1px;
  font-size:1.1em;
  background-color:#fff;
}
div#kitpic{
	width : 250px;
  height: 500px;
  border: 3px solid black;
  border-radius: 10px 10px 10px 10px;
  font-size:1.1em;
  background-color:#fff;
}
.box1, .box2, .box3 {
			display: inline-block;
            width: 465px;
            height: 700px;
            text-align: center;
            vertical-align: middle;
            line-height: 100px;
						border:2px solid black;


        }
        .box1 {
           border: 2px solid black;
        }
        .box2 {
			background-color: white;
			border-radius: 15px; /* or any value you wish to use */

        }
        .box3 {
			background-color: white;
			border-radius: 15px; /* or any value you wish to use */
        }
div#free{
 width : 945px;
  height: 750px;
  background-color: white;
	border-radius: 15px;
	border: 2px solid black;
	 /* or any value you wish to use */
}
nav#nav ul li:hover {
    background-color:#A9A9F5; opacity: 0.9;
}

.welcome-wrapper {
    width: 300px;
    height: 200px;
    padding: 40px;
    box-sizing: border-box;
    text-align: center;


}

.welcome-wrapper > h2 {
    font-size: 24px;
    color: rgb(100, 149, 237);
    margin-bottom: 20px;

}

.logout-btn, .my-info-btn {
    width: 90%;
    height: 48px;
    margin-top: 30px;
    border-radius: 6px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.logout-btn {
    background-color:rgb(100, 149, 237);
    color: #fff;
}

.my-info-btn {
    background-color: black;
    color: #fff;
}

th.no {
    width: 10%;
}

th.title {
    width: 50%;
}

th.author {
    width: 20%;
}

th.date {
    width: 20%;
}

.bb {
	background: rgb(177,178,255);
background: linear-gradient(90deg, rgba(177,178,255,1) 0%, rgba(170,196,255,1) 35%, rgba(210,218,255,1) 100%);
}
tbody {
  border: none;
}

#snow {
           position: fixed;
 top: 0;
           left: 0;
           width: 100%;
           height: 100%;
           z-index: -1;
           opacity: 0.9;
     }
.slidelist {
	 border-radius: 0px 0px 15px 15px;border:1px solid black;

}
.free55 > row{
	margin-right:10px;

}

</style>
</head>
<body class="bb">
<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("user_id") != null){
			userID = (String)session.getAttribute("user_id");

		}
		int pageNumber = 1; //기본은 1 페이지를 할당
		// 만약 파라미터로 넘어온 오브젝트 타입 'pageNumber'가 존재한다면
		// 'int'타입으로 캐스팅을 해주고 그 값을 'pageNumber'변수에 저장한다
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}

	%>
<%
	// 로그인 페이지 접속 시 쿠키 확인
	 String savedID = "";
 boolean isCheckboxChecked = false;
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
	  for (Cookie cookie : cookies) {
	    if ("savedID".equals(cookie.getName())) {
	      request.setAttribute("savedID", cookie.getValue());
	      savedID = cookie.getValue();
          isCheckboxChecked = !savedID.isEmpty();
	      break;
	    }
	  }
	}
	%>

<div id="wrap">
	<div id="snow"><%@include file="snow222.jsp"%></div>
    <header id="header">
       <a href="test.jsp"> <img src="./logo.png" alt="Your Logo" /> </a>

    </header>
	<nav id="nav" style="border:1px solid black; border-radius:15px 15px 0px 0px;">
		<ul>
		  <li><a href="Untitled-5.jsp">공지사항</a></li>
		  <li><a href="Untitled-4.jsp">사용방법</a></li>
		  <li><a href="Untitled-2.jsp">자유게시판</a></li>
		  <li><a href="Untitled-3.jsp">문의게시판</a></li>
		  <li><a href="kit.jsp">키트구매처</a></li>
		</ul>
	  </nav>


	  <div class="section" >
		<input type="radio" name="slide" id="slide01" checked>
		<input type="radio" name="slide" id="slide02">
		<input type="radio" name="slide" id="slide03">
		<div class="slidewrap">
			
			<ul class="slidelist">
				<!-- 슬라이드 영역 -->
				<li class="slideitem">
					<a>
						<div class="textbox">
						</div>
						<a href="Untitled-5.jsp">
						<img src="./img/main.png" style="border-radius: 10px; width: 100%; height: 600px;">
						</a>
					</a>
				</li>
				<li class="slideitem">
					<a>
						
						<div class="textbox">
						</div>
	
						<a href="Untitled-4.jsp">
						<img src="./img/sldd.png" style="border-radius: 10px; width: 100%; height: 600px;">
						</a>
					</a>
				</li>
				<li class="slideitem">
					<a>
						
						<div class="textbox">
						
						</div>
						<a href="Untitled-2.jsp">
						<img src="./img/sd.png" style="border-radius: 10px; width: 100%; height: 600px;">
					</a>
					</a>
</li class="slideitem">
			<!-- 좌,우 슬라이드 버튼 -->
			<div class="slide-control">
				<div>
					<label for="slide03" class="left"></label>
					<label for="slide02" class="right"></label>
				</div>
				<div>
					<label for="slide01" class="left"></label>
					<label for="slide03" class="right"></label>
				</div>
				<div>
					<label for="slide02" class="left"></label>
					<label for="slide01" class="right"></label>
				</div>
			</div>

		</ul>
		<!-- 페이징 -->
		<ul class="slide-pagelist">
			<li><label for="slide01"></label></li>
			<li><label for="slide02"></label></li>
			<li><label for="slide03"></label></li>
		</ul>
	</div>


</div>

	<div id="content" >
    <section id="container">
	<div id="wrapper">
        <div class="box2" >
   <a href="Untitled-5.jsp"><img src="./img/notice.png"  style= "width: 60%; height: 80px;"></a>


         <div id ="free55">
			<div class="row">
				<table class="table table-striped" style="text-align: center; width: 100%; background-color: white; ">

				<tbody>
					<%


						PostDAO PostDAO = new PostDAO(); // 인스턴스 생성
						List<String> categories = Arrays.asList("not");
					    ArrayList<Post> list = PostDAO.getFilteredPosts(pageNumber, categories);
					    for(int i = 0; i < list.size()&& i < 3; i++) {
					%>
					<tr>
						<!-- 테스트 코드 -->
						<td style="font-size: 16px;border-left:1px dashed black;border-bottom:1px dashed black;border-top:1px dashed black;border-radius:5px 0px 0px 5px;"><%= list.get(i).getIdx() %></td>
						<td style="font-size: 16px;border-bottom:1px dashed black;border-top:1px dashed black;"><a href="View.jsp?idx=<%= list.get(i).getIdx() %>"><%= list.get(i).getTitle() %></a></td>
						<td style="font-size: 16px;border-bottom:1px dashed black;border-top:1px dashed black;"><%= PostDAO.getNickname(list.get(i).getUser_id()) %></td>
						<td style="font-size: 16px;border-right:1px dashed black;border-bottom:1px dashed black;border-top:1px dashed black;border-radius:0px 5px 5px 0px;"><%= PostDAO.formatDate2(list.get(i).getDate()) %></td>

					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<!-- 글쓰기 버튼 생성 -->

		</div>
	</div></p>
		</div>
        <div class="box3">
			<a href="Untitled-4.jsp"><img src="./img/use.png" style= "width: 50%; height: 80px;"></a>
		          <div id ="free55">
<div class="row">
			<table class="table table-striped" style="text-align: center; width: 100%;">

		<tbody>
    <%
        List<String> categories2 = Arrays.asList("use");
        ArrayList<Post> list2 = PostDAO.getFilteredPosts(pageNumber, categories2);
        for(int i = 0; i < list2.size() && i < 3; i++) {
    %>
    <tr>
        <!-- 테스트 코드 -->
      <td style="font-size: 16px;border-left:1px dashed black;border-bottom:1px dashed black;border-top:1px dashed black;border-radius:5px 0px 0px 5px;"><%= list2.get(i).getIdx() %></td>
       <td style="font-size: 16px;border-bottom:1px dashed black;border-top:1px dashed black;"><a href="View2.jsp?idx=<%= list2.get(i).getIdx() %>">
               <%= list2.get(i).getTitle() %></a></td>
       	<td style="font-size: 16px;border-bottom:1px dashed black;border-top:1px dashed black;"><%= PostDAO.getNickname(list.get(i).getUser_id()) %></td>
       <td style="font-size: 16px;border-right:1px dashed black;border-bottom:1px dashed black;border-top:1px dashed black;border-radius:0px 5px 5px 0px;"><%= PostDAO.formatDate2(list2.get(i).getDate()) %></td>
    </tr>
    <%
        }
    %>
</tbody>

			</table>
			<!-- 글쓰기 버튼 생성 -->

		</div>
	</div>
		</div>

		<div>
			&nbsp;
			</div>
		</div>
	<div id="free">
		<a href="Untitled-2.jsp"><img src="./img/fre.png" style=" height:110px;"></a>
            <div id ="free55">
<div class="row">
			<table class="table table-striped" style="text-align: center; border-top: 2px solid #dddddd; width: 99.8%;">
	<div>
		&nbsp;
		</div>
	  <tbody>
    <% // 새로운 변수를 사용하기 때문에 수정이 필요한 부분을 수정하여 올바른 값을 얻습니다.
        List<String> categories3 = Arrays.asList("free");
        ArrayList<Post> list3 = PostDAO.getFilteredPosts(pageNumber, categories3);
        for(int i = 0; i < list3.size()&& i < 5; i++) {
            String imgThum = list3.get(i).getThum().split(" ")[0];
    %>
    <tr class="row" >
        <td class="no"><%= list3.get(i).getIdx() %></td>
        <td class="POTO" >
        <!-- 앞에 / 붙여서 절대경로 만들기  -->
        <img src="/<%=imgThum%>" alt="" style="max-width: 150px; max-height: 150px;" >
        </td>
        <td class="info">
            <p class="title"><a href="View5.jsp?idx=<%= list3.get(i).getIdx() %>">
                <%= list3.get(i).getTitle() %>(<%= PostDAO.getCommentCount(list3.get(i).getIdx()) %>)</a></p>
            <p class="author"><%= PostDAO.getNickname(list3.get(i).getUser_id()) %></p> <!-- 이 줄 수정 -->
            <p class="date"><%= PostDAO.formatDate(list3.get(i).getDate()) %></p>
			 조회수: <%= list3.get(i).getViews() %>
        </td>
    </tr>
    <tr>
        <td colspan="3" style="padding: 0;">
            <hr style="margin: 0;">
        </td>
    </tr>
    <% // 중괄호 올바른 위치에 추가
        }
    %>
</tbody>


               </table>
        </div>

    </section>
        </div>

    </section>
    <%
    if(userID == null){
    	%>
<aside id="aside">
	<aside class="login-wrapper">
    <h2>Login</h2>
    <form method="post" action="loginAction.jsp" id="login-form">
        <input type="text" name="user_id" placeholder="ID" value="<%= request.getAttribute("savedID") != null ? request.getAttribute("savedID") : "" %>">
        <input type="password" name="password" placeholder="Password">
        <label for="remember-check">
            <input type="checkbox" id="remember-check" name="savedID" <%= isCheckboxChecked ? "checked" : "" %>>아이디 저장하기
        </label>
        <input type="submit" value="로그인">
    </form>
   	 <form method="post" action="Untitled-1.jsp" id="login-form">
			  <input type="submit" value="회원가입" >
    </form>
	
				
			<%@ include file="RankDiv.jsp"%>	
			
				
		
	<div>
		&nbsp;
	  </div>

    <div id="kitpic">
		<img src="./img/bike.png" style="width: 50%; height: 10%;">
		<a href="kit.jsp">
				<img src="./img/1_1_1.png" style="width: 100%; height: 70%;  border-radius: 10px;">
			</a>
		</a>
    </div>
	</aside>
</aside>

<%
}else{

	%>
	<aside id="aside">
	<aside class="welcome-wrapper">
		<div id="aside1">
    <h2></h2>
  <% String nickname = (String) session.getAttribute("nickname"); %>
    <h2>환영합니다!<br><%= (nickname != null) ? nickname : "불러오기실패" %>님</h2>
     <form method="post" action="logoutAction.jsp" id="login-form">
        <button class="logout-btn" id="logout-btn">로그아웃</button>
        	</form>
         	<form method="post" action="MyInfoChange.jsp" id="login-form">
       	 	<button class="my-info-btn" id="my-info-btn">내 정보</button>
       		 </form>
			<div>
		&nbsp;
	  </div>
			<%@ include file="RankDiv.jsp"%>	
			

		<div id="kitpic">
			<img src="./img/bike.png" style="width: 50%; height: 10%;">
			<a href="kit.jsp">
				<img src="./img/1_1_1.png" style="width: 100%; height: 70%;  border-radius: 10px;">
			</a>
		</a>
		</div>
	</aside>
		<%
			}

		%>
</div>
<footer id="footer">
        <a>
          상호 : 대한민국 대표자 : 권기현 주소 : 대구광역시 북구 복현로 35
          <br>사업자 등록번호 : 010-3145-4107 TEL : 02-1234-5678 FAX : 02-3399-1672 EMAIL : web@co.kr
          <br>Copyright(c) 영진전문대학교. All Rights Reserved.
        </a>

 </footer>
 </div>
</body>
</html>
