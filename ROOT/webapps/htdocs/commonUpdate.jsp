<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="reply.Reply" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/custom.css">
<title></title>
</head>
<body>
    <%
    int postID = 0;
    if (request.getParameter("idx") != null){
        postID = Integer.parseInt(request.getParameter("idx"));
    }
    int replyID = 0;
    if (request.getParameter("idx") != null){
        replyID = Integer.parseInt(request.getParameter("idx"));
    }
    ReplyDAO replyDAO = new ReplyDAO();
    String replyText = replyDAO.getUpdateReply(replyID);
    %>
    <div class="container" align="center">
        <div class="col-lg-10">
            <div class="jumbotron" style="padding-top: 1px;">                
                <h3><br>댓글 수정 창</h3>
                <form name="c_replyUpdate">
                    <input type="text" id="update" style="width:400px;height:50px;" maxlength=1024 value="<%= replyText %>">
                    <input type="button" onclick="send(<%=postID %>,<%=replyID %>)" value="수정하기">
                    <input type="button" onclick="cancel()" value="취소">
                    <br><br>
                </form>
            </div>
        </div>
        <div class="col-lg-10"></div>
    </div>
</body>
<script>
function send(postID, replyID) {
    var sb;
    var replyText = document.c_replyUpdate.update.value;
    var encodedReplyText = encodeURIComponent(replyText);
    sb = "commentUpdateAction.jsp?idx="+postID+"&idx="+replyID+"&content="+encodedReplyText;
    window.opener.location.href= sb;
    window.close();
}

function cancel() {
    window.close();
}
</script>
</html>
