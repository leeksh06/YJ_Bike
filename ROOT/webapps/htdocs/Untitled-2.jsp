<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="reply.Reply" %>
<%@ page import="reply.ReplyDAO" %>
<!DOCTYPE html>
<html lang="ko">
<head>




    <script>

    </script>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Myself</title>



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
#nav > ul > a  { text-decoration : none; }
      div#wrap {

		 width: 1200px;
            margin: 0 auto;
            position: relative;

		}
    .pull-right{
    background-color:#fff;
    border-radius: 10px 10px 10px 10px;
    border: 2px solid black;
    padding:5px;
    margin-top:5px;
}
        header#header {
		background:#none;
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
			height: 2000px;
			text-align:left;
			float:left;
			padding:10px;



        }

        div.content {
			background:#fff;
		}
         aside#aside {

			  width: 220px;
			  height: 1500px;
			  float: right;
			  color: black;
			  text-align: center;
			  line-height: 50px;

		}
      footer#footer {


			bottom:0;
			width:1200px;
			height:70px;
			background:#102b6a;
			margin:auto;
			clear:both;
			 color: white;
			  text-align: center;
		}

        div#warp, header#header, nav#nav,
        section#container, div.content, aside#aside,


        nav#nav ul { margin:0 auto; padding:0; list-style:none; text-align: center; }
        nav#nav ul li {  padding:10px; display:inline-block; }
		nav#nav ul li a {display:inline-block;color:white;text-decoration:none;}

	div.content { width:60%; float:left; }
}
	#free55{
  border:3px solid black;
}

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
#nav {
 border-radius: 10px 10px 10px 10px;
 border: 2px solid black;
 font-size:1.1em;

}
div#kitpic{
 width : 250px;
  height: 545px;
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
            color: white;
        }
        .box1 {
           border: 1px solid black;
        }
        .box2 {
            border: 1px solid black;
        }
        .box3 {
           border: 1px solid black;
        }
div#free{
 width : 945px;
  height: 750px;
  border: 1px solid black;
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
    width: 80%;
    height: 48px;
    margin: 10px;
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

.btn-write {
    float: right; /* Align the button to the right */
    background-color: rgb(100, 149, 237); /* Button background color */
    color: white; /* Button text color */
    border: none; /* Remove button border */
    padding: 5px 10px; /* Button padding */
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 2px 2px;
    cursor: pointer;
    border-radius: 6px;
}
.btn btn-write {
  margin:10px;
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

 </style>

</head>
<body>
<%
//메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
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
	 <nav id="nav">
        <ul>
            <li><a href="Untitled-5.jsp">공지사항</li>
            <li><a href="Untitled-4.jsp">사용 방법</li>
			<li><a href="Untitled-2.jsp">자유게시판</a></li>
			 <li><a href="Untitled-3.jsp">문의 게시판</li>
			  <li><a href="kit.jsp">키트구매처</a></li>
        </ul>
    </nav>


       <section id="container">
        <h2 class="site_main">자유게시판</h2><br>
        <button class="btn btn-write" onclick="checkLoginAndNavigate()" style="margin-top:5px;margin-right:5px; " >글쓰기</button>
            <div id="free55" style="border:3px solid black; border-radius: 10px 10px 10px 10px;">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; width: 99.8%;">
                    <thead>
                        <!-- 테이블 헤더를 작성해주세요. (필요한 경우) -->
                    </thead>
                    <tbody>
                        <%
                            int pageSize = 10;
                            PostDAO PostDAO = new PostDAO(); // 인스턴스 생성
                            String category = "free";
                            ArrayList<Post> list = PostDAO.getCategoryPostsPaged(pageNumber, pageSize, category);
                            int totalCount = PostDAO.getTotalCount(category);
                            int totalPages = (int) Math.ceil((double) totalCount / pageSize);
                        %>
                        <% for (int i = 0; i < list.size(); i++) {
                        	 String imgThum = list.get(i).getThum().split(" ")[0];
                        	%>
                        <tr>
                           <td class="no"><%= list.get(i).getIdx() %></td>
                           <td class="POTO">
                            <!-- 앞에 / 붙여서 절대경로 만들기  -->
                           <img src="/<%=imgThum%>" alt="" style="max-width: 150px; max-height: 150px;">
                           </td>
                           <td class="info">
                             <p class="title"><a href="View5.jsp?idx=<%= list.get(i).getIdx() %>">
                                 <%= list.get(i).getTitle() %>(<%= PostDAO.getCommentCount(list.get(i).getIdx()) %>)</a></p>
                             <p class="author"><%= PostDAO.getNickname(list.get(i).getUser_id()) %></p>
                             <p class="date"><%= PostDAO.formatDate(list.get(i).getDate()) %></p>
							  조회수: <%= list.get(i).getViews() %>
                           </td>
                        </tr>
                        <tr>
                           <td colspan="3" style="padding: 0;">
                             <hr style="margin: 0;">
                           </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <ul style="list-style-type: none;">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <li style="display: inline;">
                        <a href="Untitled-2.jsp?pageNumber=<%=i%>&category=<%=category%>"><%=i%></a>
                    </li>
                    <% } %>
                </ul>
            </div>
		<div class="row">
		  <form method="post" name="search" action="searchpost.jsp" onsubmit="return checkSearch();">
        <table class="pull-right">
            <tr>
                <td>
                    <select class="form-control" name="searchField">
                        <option value="0">선택</option>
                        <option value="title">제목</option>
                        <option value="nickname">작성자</option>
                    </select>
                </td>
                 <td>
                    <select class="form-control" name="category">
                        <option value="">전체</option>
                        <option value="not">공지사항</option>
                        <option value="use">사용방법</option>
                          <option value="free">자유게시판</option>
                            <option value="ask">문의게시판</option>
                        <!-- Add more categories as needed -->
                    </select>
                </td>
                <td><input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100"></td>

                <td><button type="submit" class="btn btn-success">검색</button></td>
            </tr>
        </table>
			</form>
		</div>

        </section>

   <%
    if(userID == null){
    	%>
<aside id="aside">
	<aside class="login-wrapper">

    <h2>Login</h2>
   <form method="post" action="loginAction7.jsp" id="login-form">
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
         <form method="post" action="logoutAction7.jsp" id="login-form">
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
<script>
    function checkSearch() {
        var searchText = document.getElementsByName("searchText")[0].value;
        if (searchText.trim() === "") {
            alert("검색어를 입력하세요.");
            return false;
        }
        return true;
    }

    function checkLoginAndNavigate() {
        <% if (userID == null) { %>
            alert("로그인을 하세요!");
        <% } else { %>
            location.href = "write_S.jsp?category=free";
        <% } %>
    }
</script>
</body>
</html>
