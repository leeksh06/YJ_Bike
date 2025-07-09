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
        category = "use";
    }
%>
<body>
<div class="form_box">
    <h3>게시물 올리기</h3>
    <form action="writeProTest.jsp" method="post" class="write_form" enctype="multipart/form-data">
        <input type="hidden" name="category" value="<%=category%>">
        <input class="title_field" type="text" placeholder="제목" name="title"><br>
        <textarea class="content_field" placeholder="내용" name="content"></textarea><br>
        <div style="display: flex; justify-content: space-between; align-items: flex-end;">
            <div>
                <input type='file' id='btnAtt' accept=".png, .jpg, .jpeg" name="files" multiple='multiple'/>
                <div id='att_zone'></div>
            </div>
            <input type="submit" class="button" value="전송하기">
<%--            <input type="button" class="button" onclick="clickSubmit()" value="전송하기">--%>
        </div>
    </form>
</div>

<script>
    ( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
    imageView = function imageView(att_zone, btn){

        var attZone = document.getElementById(att_zone);
        var btnAtt = document.getElementById(btn)
        var sel_files = [];

        // 이미지와 체크 박스를 감싸고 있는 div 속성
        var div_style = 'display:inline-block;position:relative;'
            + 'width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1';
        // 미리보기 이미지 속성
        var img_style = 'width:100%;height:100%;z-index:none';
        // 이미지안에 표시되는 체크박스의 속성
        var chk_style = 'width:30px;height:30px;position:absolute;font-size:24px;'
            + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,255,255,0.1);color:#f00';

        btnAtt.onchange = function(e){
            var files = e.target.files;
            var fileArr = Array.prototype.slice.call(files)
            for (let i = 0; i < fileArr.length; i++) {
                imageLoader(fileArr[i]);
            }
        }


        /*첨부된 이미지들을 배열에 넣고 미리보기 */
        imageLoader = function(file){
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

        /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
        makeDiv = function(img, file){
            var div = document.createElement('div')
            div.setAttribute('style', div_style)

            var btn = document.createElement('input')
            btn.setAttribute('type', 'button')
            btn.setAttribute('value', 'x')
            btn.setAttribute('delFile', file.name);
            btn.setAttribute('style', chk_style);
            btn.onclick = function(ev){
                var ele = ev.srcElement;
                var delFile = ele.getAttribute('delFile');
                for(var i=0 ;i<sel_files.length; i++){
                    if(delFile== sel_files[i].name){
                        sel_files.splice(i, 1);
                    }
                }

                dt = new DataTransfer();
                for(f in sel_files) {
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


</script>
</body>
</html>