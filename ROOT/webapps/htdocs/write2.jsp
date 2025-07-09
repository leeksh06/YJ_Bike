<!DOCTYPE html>
<html lang="en">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta charset="UTF-8">
    <title>Summernote</title>
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
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("user_id") != null){
			userID = (String)session.getAttribute("user_id");
			
		}
		
	%>
<div class="form_box">
    <h3>게시물 올리기</h3>
   <form method="post" action="writeAction2.jsp" onsubmit="getContent()">
    <input class="title_field" type="text" name="title" placeholder="제목"><br>
    <input type="hidden" name="content">
    <div id="summernote"></div>
    <button type="submit" class="write_button">작성하기</button>
</form>
 <a href="test.jsp"><button class="back_button">돌아가기</button></a>
</div>

<script>
    $(document).ready(function () {
        $('#summernote').summernote({
            height: 400,
            placeholder: '내용',
            callbacks: {
                onChange: function(contents, $editable) {
                    $('#content').val(contents); // Summernote의 내용을 textarea 요소에 저장
                }
            }
        });
    });
    function getContent() {
    	  $("input[name='content']").val($('#summernote').summernote('code'));
    	}
</script>
</body>
</html>