<%@page import="javax.sound.sampled.TargetDataLine"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta charset="UTF-8">
    <title>게시판 글 수정 양식</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <style>
        body {
            width: 1200px;
            margin: 0 auto;
        }

        .form_box {
            background-color: #ffffff;
            margin: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
            padding: 10px;
        }

        .title_field {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 4px;
            margin: 3px 0;
            font-size: 18px;
            width: 100%;
            height: 50px;
        }

        .write_button, .back_button {
            background-color: #475d9f;
            border: 1px solid #323f6b;
            color: #ffffff;
            border-radius: 4px;
            padding: 2px 8px;
            font-size: 18px;
        }
    </style>
</head>
<body>

<%
    String userID = null;
    if(session.getAttribute("user_id") != null){
        userID = (String)session.getAttribute("user_id");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href='test.jsp'");
        script.println("</script>");
    }

    int idx = 0;
    if(request.getParameter("idx") != null){
        idx = Integer.parseInt(request.getParameter("idx"));
    }

    if(idx == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href='bbs.jsp'");
        script.println("</script");
    }

    Post post = new PostDAO().getPost(idx);

    if (!userID.equals(post.getUser_id())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('You don't have permission')");
        script.println("location.href='test.jsp'");
        script.println("</script>");
    }
%>
<%
    // Add these lines to retrieve the original title and content
    String originalTitle = post.getTitle();
    String originalContent = post.getContent();
%>


<div class="form_box">
   

    <h3>게시판 글 수정 양식</h3>
    <form method="post" action="updateAction2.jsp?idx=<%=idx%>" id="postForm">
    <input class="title_field" type="text" name="title" placeholder="제목" value="<%=originalTitle%>"><br>
  <div id="summernote" name="content" data-original-content="<%=originalContent%>"></div>
    <input type="hidden" name="content" id="contentInput"> <!-- Add this hidden input field -->
    <button class="write_button" type="submit">수정하기</button>
</form>
<a href="test.jsp"><button class="back_button">돌아가기</button></a>
</div>

<script>
$(document).ready(function () {
    // Get the original content from the data attribute
    let originalContent = $('#summernote').data('original-content');

    // Initialize the summernote editor with the original content
    $('#summernote').summernote({
        height: 400,
        placeholder: '내용',
        callbacks: {
            onInit: function() {
                // Set the original content after initializing the editor
                $('#summernote').summernote('code', originalContent);
            }
        }
    });

    $('#postForm').on('submit', function (e) {
        e.preventDefault();
        let content = $('#summernote').summernote('code');
        $('#contentInput').val(content);
        this.submit();
    });

});

</script>
</body>
</html>

