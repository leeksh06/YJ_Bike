<%@page import="javax.sound.sampled.TargetDataLine"%>
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

<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="capcomplete.css"/>
  <title>Myself</title>
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->



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
   section#container {
           width : 950px;
			height: 9999px;
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
  #free55{
  width:950px;
  height:1200px;
  border:1px solid black;
  border-radius: 10px 10px 10px 10px;
  border: 3px solid black;
  font-size:1.1em;
}

.login-wrapper{
    width: 300px;
    height: 300px;
    padding: 20px;
    box-sizing: border-box;
}
#nav {
 border-radius: 10px 10px 10px 10px;
 border: 2px solid black;
 font-size:1.1em;
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
#aside1{
   width: 250px;
   height: 300px;
  text-align: center;
  border:3px solid black;
  border-radius: 15px 15px 15px 15px;
  background-color: #fff;
  margin-bottom:10px;
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
 </style>
</head>
<body>
<%
//메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("user_id") != null){
			userID = (String)session.getAttribute("user_id");

		}
		// 를 초기화 시키고
				// 라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
				int idx = 0;
				if(request.getParameter("idx") != null){
					idx = Integer.parseInt(request.getParameter("idx"));
				}

				// 만약 넘어온 데이터가 없다면
				if(idx == 0){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('유효하지 않은 글입니다')");
					script.println("history.back()");
					script.println("</script");
				}
				Post Post = new PostDAO().getPost(idx);
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
     <div id="snow"><%@include file="snow333.jsp"%></div>
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
    <h2 class="site_main">문의게시판</h2><br>

 <div id="free55">
        <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; width: 99.8%; border-radius:10px 10px 10px 10px;">
                <thead>
                    <tr>
                        <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
                    </tr>
                </thead>
                <tbody>
                       <%
                      PostDAO PostDAO = new PostDAO(); // 인스턴스 생성
                      
                       
                        Post post = PostDAO.getPost2(idx);
                        String postAuthorID = null;
                        if (post != null) {
                            postAuthorID = post.getUser_id();
                        }

                      
                        if (userID == null || (!userID.equals("admin") && !userID.equals(postAuthorID))) {
                            PrintWriter script = response.getWriter();
                            script.println("<script>");
                            script.println("alert('접속 할 수 있는 권한이 없습니다.\\n관리자와 게시글 작성자만 글을 볼수 있습니다.');");
                            script.println("history.back();");
                            script.println("</script>");
                            script.close();
                            return;
                        }
                    %>
                   <tr>
        <td style="width: 20%;">글 제목</td>
        <td><%= Post.getTitle().replaceAll(" ", "&nbsp;")
                .replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    </tr>
    <tr>
        <td>작성자</td>
        <td style="text-align: left;"><%= PostDAO.getNickname(Post.getUser_id()) %></td>
    </tr>
    <tr>
        <td>작성일자</td>
        <td style="text-align: left;"><%=PostDAO.formatDate(Post.getDate()) %></td>
    </tr>
    <tr>
                 <td>내용</td>
<td colspan="2" style="height: 200px; text-align: left;">
    <%= Post.getContent().replaceAll(" ", "&nbsp;")
    .replaceAll("<", "<").replaceAll(">", ">").replaceAll("\n", "<br>") %>
</td>
</tr>



<tr>
<td colspan="2">
    <div class="image_wrap" style="width: 940px; text-align: center; white-space: nowrap; overflow: auto;">
    <%
        String[] postImages = Post.getThum().split(" ");
        for (int i = 0; i < postImages.length; i++) {
            String imgThum = postImages[i];
    %>
            <img src="/<%=imgThum%>" alt="" style="display: inline-block; width:500px;" />
    <%
        }
    %>
    </div>
</td>
</tr>




                </tbody>
            </table>
            <a href="Untitled-3.jsp" class="btn btn-primary"><button class="jelly">목록</button></a>

			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<%
    if (userID != null && userID.equals(postAuthorID)) {
%>
       <a href="updatewrite3.jsp?idx=<%= idx %>" class="btn btn-primary"><button class="jelly">수정</button></a>
<%
    }
    if (userID != null && (userID.equals(postAuthorID) || userID.equals("admin"))) {
%>
       <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?idx=<%= idx %>" class="btn btn-primary"><button class="jelly">삭제</button></a>
<%
    }
%>

	<!-- 댓글 작성 폼 -->
<form action="replyAction.jsp" method="post" onsubmit="return validateForm();">
    <textarea type="text" class="form-control" placeholder="댓글을 입력하세요" name="content" maxlength="2048" style="width: 940px; height: 200px; resize: none;"></textarea>
    <input type="hidden" name="ref" value="<%=request.getParameter("idx")%>">
    <div style="width: 100%; text-align: right;">
        <input type="submit" class="btn" value="댓글 입력">
    </div>
</form>

<!-- 댓글 목록 -->
<div class="row">
    <table class="table table-striped" style="text-align: center; width: 99.8%; height: 200px; border: 1px solid #dddddd">
        <tbody>
            <tr>
                <th colspan="5" style="background-color: beige; text-align: left;">댓글</th>
            </tr>
            <%
                int page2 = 1;
                int commentsPerPage = 5;

                if (request.getParameter("page") != null) {
                    page2 = Integer.parseInt(request.getParameter("page"));
                }

                ReplyDAO replyDAO = new ReplyDAO();
                int totalComments = replyDAO.getCommentsCount(idx);
                int totalPages = (int) Math.ceil((double) totalComments / commentsPerPage);
                ArrayList<Reply> list = replyDAO.getList(idx, page2, commentsPerPage);
                for(int i=0; i<list.size(); i++){
            %>
            <tr>
                <td style="text-align: left;"><%= PostDAO.getNickname(list.get(i).getUser_id()) %> <%= list.get(i).getDate().toString() %></td>
                <td style="text-align: center;">
                 <%
    if (list.get(i).getUser_id() != null && list.get(i).getUser_id().equals(userID)) {
%>
       <form name="p_search">
          <button type="button" onclick="nwindow(<%=idx%>,<%=idx %>,<%=list.get(i).getIdx()%>)" class="btn btn-primary">수정</button>
       </form>
<%
    }
    if (list.get(i).getUser_id() != null && (list.get(i).getUser_id().equals(userID) || userID.equals("admin"))) {
%>
       <form action="commentDeleteAction.jsp" method="get" onsubmit="return confirm('정말로 삭제하겠습니까?')">
          <input type="hidden" name="idx" value="<%= list.get(i).getIdx() %>">
           <button type="submit" class="btn btn-primary">삭제</button>
       </form>
<%
    }
%>

                </td>
            </tr>
            <tr>
                <td colspan="5" style="text-align: left;"><%= list.get(i).getContent() %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
  <!-- Pagination -->
<div>
    <%
        if(page2 > 1){
    %>
        <a href="View3.jsp?idx=<%=idx%>&page=<%= page2 - 1 %>"
        class="btn btn-success btn-arraw-left">이전</a>
    <%
        }
        if (page2 < totalPages){
    %>
        <a href="View3.jsp?idx=<%=idx%>&page=<%= page2 + 1 %>"
        class="btn btn-success btn-arraw-left">다음</a>
    <%
        }
    %>
</div>
</div>
			</form>
			<br>
		</div>
	</div>
        </section>
   <%
    if(userID == null){
    	%>
<aside id="aside">
	<aside class="login-wrapper">

    <h2>Login</h2>
  <form method="post" action="loginAction4.jsp" id="login-form">
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
     <form method="post" action="logoutAction4.jsp" id="login-form">
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
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
  <script>
    function handleWriteButtonClick() {
      var userID = '<%= userID %>';
      if (userID === null || userID === "" || userID === "null") {
        alert("로그인을 하세요");
      } else if (userID === "Admin" || userID === "Admin01"||userID === "Admin02"||userID === "Admin03"||userID === "Admin04"||userID === "Admin05") {
        window.location.href = "write2.jsp";
      } else {
        alert("관리자만 접근할수 있습니다");
      }
    }
    function nwindow(idx, idx, idx, page2){
        window.name = "commonParant";
        var url = "commonUpdate.jsp?idx=" + idx + "&idx=" + idx + "&idx=" + idx + "&page=" + page2;
        window.open(url,"","width=600,height=230,left=300");
    }




  </script>
</html>
