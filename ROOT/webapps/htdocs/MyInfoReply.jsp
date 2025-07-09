<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@ page import="cap.rsReply" %> <!-- 컴파일한다음 폴더에 넣기 src,classes -->--%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="reply.Reply" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<head>
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
            margin: 0 auto;
            padding: 10px;
            width: 1200px;
            border-radius:10px 10px 10px 10px;
            background-color:#fff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, td {
            border: 2px solid #000;
            padding: 10px 0;
        }

        table td:nth-child(1) {
            text-align: center;
        }

        table td:nth-child(2) {
            padding-left: 10px;
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

        .btn {
            background-color: #475d9f;
            border: 1px solid #323f6b;
            color: #ffffff;
            border-radius: 4px;
            padding: 5px 8px;
            font-size: 20px;
            margin-top: 10px;
        }

        .page {
            margin-top: 10px;
            text-align: center;
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
            width: 880px;
            padding: 5px;
            border: 1px solid blue;
        }

        .infoMenu {
            padding: 10px;

            border: solid;
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

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#cbx_reply_chkAll").click(function () {
                if ($("#cbx_reply_chkAll").is(":checked")) $("input[name=chkReply]").prop("checked", true);
                else $("input[name=chkReply]").prop("checked", false);
            });

            $("input[name=chkReply]").click(function () {
                var total = $("input[name=chkReply]").length;
                var checked = $("input[name=chkReply]:checked").length;

                if (total !== checked) $("#cbx_reply_chkAll").prop("checked", false);
                else $("#cbx_reply_chkAll").prop("checked", true);
            });
        });
    </script>

</head>
<%
ReplyDAO replyDAO = new ReplyDAO();
String userId = session.getAttribute("user_id").toString();
int cnt = replyDAO.getReplyCount(userId);
String pageNum = request.getParameter("pageNum");
if (pageNum == null) pageNum = "1";
int currentPage = Integer.parseInt(pageNum);
int pageSize = 5;
int startRow = (currentPage - 1) * pageSize + 1;
List<Reply> listReply = replyDAO.getReplies(userId, startRow, pageSize);

%>
<body>
<div id="wrap">
  <div id="snow"><%@include file="snow222.jsp"%></div>
    <header id="header">
        <a href="test.jsp"> <img src="./logo.png" alt="Your Logo"/> </a>
    </header>
    <nav id="nav" style="border:1px solid black; border-radius: 10px 10px 10px 10px;">
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
        <form onsubmit="return isAtLeastOneCheckboxChecked();" action="DeletePro.jsp?pageNum=<%=pageNum%>" method="post">
            <table>
                <h3 style="font-size: 30px;"> 댓글 삭제 </h3>
                <colgroup>
                    <col width="10">
                    <col width="300">
                </colgroup>
                <thead>
                <tr>
                    <th><input type="checkbox" id="cbx_reply_chkAll"/></th>
                    <th>내용</th>
                </tr>
                </thead>
                <tbody>
                <input type="hidden" name="board" value="Reply">
                <%
                    for (int i = 0; i < listReply.size(); i++) {
                %>
                <tr>
                    <td><input type="checkbox" name="chkReply" value="<%=listReply.get(i).getIdx()%>"></td>
                    <td><%=listReply.get(i).getContent()%>

                    </a></td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <div class="page">
                <%
                    if (cnt != 0) {
                        int pageCount = cnt / pageSize + (cnt % pageSize == 0 ? 0 : 1);

                        int pageBlock = 10;
                        int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
                        int endPage = startPage + pageBlock - 1;
                        if (endPage > pageCount) {
                            endPage = pageCount;
                        }
                %>
                <% if (startPage > pageBlock) { %>
                <span> <a href="MyInfoReply.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>&nbsp&nbsp</span>
                <% }
                    for (int i = startPage; i <= endPage; i++) { %>
                <span> <a href="MyInfoReply.jsp?pageNum=<%=i%>"> <%=i%></a>&nbsp&nbsp</span>
                <% } %>
                <% if (endPage < pageCount) { %>
                <span> <a href="MyInfoReply.jsp?pageNum=<%=startPage+pageBlock%>">다음</a> </span>
                <% } %>
                <%}%>
            </div>
            <input class="btn" type="submit" value="삭제하기">
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $("#cbx_post_chkAll").click(function () {
            if ($("#cbx_post_chkAll").is(":checked")) $("input[name=chkPost]").prop("checked", true);
            else $("input[name=chkPost]").prop("checked", false);
        });

        $("input[name=chkPost]").click(function () {
            var total = $("input[name=chkPost]").length;
            var checked = $("input[name=chkPost]:checked").length;

            if (total !== checked) $("#cbx_post_chkAll").prop("checked", false);
            else $("#cbx_post_chkAll").prop("checked", true);
        });
    });

    // Add this function
    function isAtLeastOneCheckboxChecked() {
        // Get the checkbox elements
        var checkboxes = document.getElementsByName('chkReply');

        // Check if at least one checkbox is checked
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                return true;
            }
        }

        // If no checkbox is checked, show an alert and prevent form submission
        alert('삭제할 항목을 선택하세요');
        return false;
    }
</script>
