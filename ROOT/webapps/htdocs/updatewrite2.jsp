<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>

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
            display: flow;
            flex-direction: column;
        }

        .title_field {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 4px;
            margin: 3px 0;
            font-size: 18px;
            width: 99%;
            height: 30px;
        }

        .content_field {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 4px;
            margin: 3px 0;
            font-size: 14px;
            width: 99%;
            height: 350px;
        }

        .button {
            background-color: #475d9f;
            border: 1px solid #323f6b;
            color: #ffffff;
            border-radius: 4px;
            padding: 2px 8px;
            font-size: 18px;
        }

        #att_zone{
            width: 660px;
            min-height:150px;
            padding:10px;
            border:1px dotted #00f;
        }
        #att_zone:empty:before{
            content : attr(data-placeholder);
            color : #999;
            font-size:.9em;
        }
    </style>
</head>
<%
    String category = request.getParameter("category");
    if (category == null) {
        category = "free";
    }
	
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
	category = post.getCategory();
%>
<%
    
    String originalTitle = post.getTitle();
    String originalContent = post.getContent();
    
    String DB_URL = "jdbc:mysql://localhost:3306/capDB";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
    Connection conn;
    Statement stmt;
    ResultSet rs = null;
    String str = "";
    String[] arr = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM post WHERE idx="+idx);
        if (rs.next()) {
            str = rs.getString("thum");
            arr = str.split(" ");
        }

        conn.close();
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
%>
<body>
<div class="form_box">
    <h3>게시물 수정</h3>
    <form action="updatewriteaction.jsp?idx=<%=idx%>" method="post" class="write_form" enctype="multipart/form-data" onsubmit="return checkInputs();">
        <input type="hidden" name="category" value="<%=category%>">
        <input class="title_field" type="text" placeholder="제목" name="title" value="<%=originalTitle%>"><br>
        <textarea class="content_field" placeholder="내용" name="content" ><%=originalContent%></textarea><br>

        <div style="display: flex; justify-content: space-between; align-items: flex-end;">
            <div>
                <div id='att_zone'>
                    <% if (!str.equals("")) { %>
                    <input type="hidden" name="str" value="<%=str%>">
                    <% for (int i = 0; i < arr.length; i++) { %>
                    <input id="image_idx<%=i%>" type="hidden" name="remain" value="<%=i%>">
                    <div id="image_box<%=i%>"
                         style="display:inline-block;position:relative;width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1;">
                        <img src="<%="/"+arr[i]%>" class="image" alt="" style="width:100%;height:100%;z-index:none;">
                        <input type="button" name="change" value="x" onclick="remove_image(<%=i%>)" class="image_delete"
                               style="width:30px;height:30px;position:absolute;font-size:24px;right:0px;bottom:0px;z-index:999;background-color:rgba(255,255,255,0.1);color:#f00;">
                    </div>
                    <% }
                    } %>
                </div>
                <input type='file' id='btnAtt' accept=".png, .jpg, .jpeg" name="files" multiple='multiple'/>
            </div>
			
            <input type="submit" name="submit" class="button" value="수정하기">

			<input type="button" class="button" onclick="goBack()" value="돌아가기">

<%--            <input type="button" class="button" onclick="clickSubmit()" value="전송하기">--%>
        </div>
    </form>
</div>

<script>
    function remove_image(num) {
        var child_image_box = document.getElementById("image_box" + num);
        var image_idx = document.getElementById("image_idx" + num);
        child_image_box.remove();
        image_idx.remove();
    }

     (
            function imageView(att_zone, btn) {
                var attZone = document.getElementById(att_zone);
                var btnAtt = document.getElementById(btn);
                var sel_files = [];

                var div_style = 'display:inline-block;position:relative;'
                    + 'width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1';
                var img_style = 'width:100%;height:100%';
                var btn_style = 'width:30px;height:30px;position:absolute;'
                    + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,255,255,0.7);color:#f00';

                btnAtt.onchange = function (e) {
                    var files = e.target.files;
                    var fileArr = Array.prototype.slice.call(files)
                    for (let i = 0; i < fileArr.length; i++) {
                        imageLoader(fileArr[i]);
                    }
                }

                function imageLoader(file) {
                    sel_files.push(file);
                    var reader = new FileReader();
                    reader.onload = function (ee) {
                        let img = document.createElement('img')
                        img.setAttribute('style', img_style)
                        img.src = ee.target.result;
                        attZone.appendChild(makeDiv(img, file));
                    }
                    reader.readAsDataURL(file);
                }

                function makeDiv(img, file) {
                    var div = document.createElement('div')
                    div.setAttribute('style', div_style)

                    var btn = document.createElement('zbutton')
                    btn.setAttribute('delFile', file.name);
                    btn.setAttribute('style', btn_style);
                    btn.innerHTML = '&#10006;';
                    btn.onclick = function (ev) {
                        var ele = ev.target;
                        var delFile = ele.getAttribute('delFile');
                        for (var i = 0; i < sel_files.length; i++) {
                            if (delFile == sel_files[i].name) {
                                sel_files.splice(i, 1);
                            }
                        }
                        dt = new DataTransfer();
                        for (f in sel_files) {
                            var file = sel_files[f];
                            dt.items.add(file);
                        }
                        btnAtt.files = dt.files;
                        var p = ele.parentNode;
                        attZone.removeChild(p)
                    }
                    div.appendChild(img)
                    div.appendChild(btn)
                    return div
                }
            }
        )('att_zone', 'btnAtt')

        function goBack() {
            location.href = "Untitled-4.jsp";
        }

		    function checkInputs() {
        const titleInput = document.querySelector('.title_field');
        const contentInput = document.querySelector('.content_field');

        if (!titleInput.value.trim()) {
            alert('제목이 입력되지 않았습니다.');
            titleInput.focus();
            return false;
        }

        if (!contentInput.value.trim()) {
            alert('내용이 입력되지 않았습니다.');
            contentInput.focus();
            return false;
        }

        return true;
    }
</script>
</body>
</html>