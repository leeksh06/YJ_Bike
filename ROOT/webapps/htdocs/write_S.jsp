<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
%>
<body>
<div class="form_box">
    <h3>게시물 올리기</h3>
    <form action="writePro.jsp" method="post" class="write_form" enctype="multipart/form-data" onsubmit="return checkInputs();">
        <input type="hidden" name="category" value="<%=category%>">
        <input class="title_field" type="text" placeholder="제목" name="title"><br>
        <textarea class="content_field" placeholder="내용" name="content"></textarea><br>
        <div style="display: flex; justify-content: space-between; align-items: flex-end;">
            <div>
                <input type='file' id='btnAtt' accept=".png, .jpg, .jpeg" name="files" multiple='multiple'/>
                <div id='att_zone'></div>
            </div>
            <input type="submit" class="button" value="업로드">
			<input type="button" class="button" onclick="goBack()" value="돌아가기">

<%--            <input type="button" class="button" onclick="clickSubmit()" value="전송하기">--%>
        </div>
    </form>
</div>

<script>
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
    const category = '<%=category%>';
    let targetPage = '';

    if (category === 'free') {
        targetPage = 'Untitled-2.jsp';
    } else if (category === 'ask') {
        targetPage = 'Untitled-3.jsp';
    } else if (category === 'use') {
        targetPage = 'Untitled-4.jsp';
    } else {
        targetPage = 'Untitled-5.jsp';
    }
    
    location.href = targetPage;
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