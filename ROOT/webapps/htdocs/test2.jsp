<!doctype html>
<html>
<head>
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
		background:#fff; 
		text-align: center;
		justify-content: center;
		align-items: center;
		}
        nav#nav {  
		background-color: rgb(100, 149, 237); 
		color: white;
		}
       section#container { 
           width : 950px;
			height: 1450px;
			text-align:left;
			float:left;
			padding:10px;
			
			
	
        }
        
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
       
        div#warp, header#header, nav#nav,
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
  border: 1px solid black;
}
div#kitpic{
 width : 250px;
  height: 545px;
  border: 1px solid black;
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
    width: 100%;
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


</style>
</head>
<body>
<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("id") != null){
			userID = (String)session.getAttribute("id");
		}
	%>
<div id="wrap">
    <header id="header">
       <a href="test.jsp"> <img src="./logo.png" alt="Your Logo" /> </a>
	  
    </header>
    <nav id="nav">
        <ul>
             <li>소개</li>
            <li>공지사항</li>
             <li>사용 방법</li>   
			<li><a href="Untitled-2.jsp">자유게시판</a></li>
			  <li><a href="kit.jsp">키트구매처</a></li> 
        </ul>       
    </nav>
  
<div class="section">
	<input type="radio" name="slide" id="slide01" checked>
	<input type="radio" name="slide" id="slide02">
	<input type="radio" name="slide" id="slide03">
	<div class="slidewrap">
		
		<ul class="slidelist">
			<!-- 슬라이드 영역 -->
			<li class="slideitem">
				<a>
					<div class="textbox">
						<h3>첫번째 슬라이드</h3>
						<p>첫번째 슬라이드 입니다.</p>
					</div>
					<img src="./img/slide.jpg">
				</a>
			</li>
			<li class="slideitem">
				<a>
					
					<div class="textbox">
						<h3>두번째 슬라이드</h3>
						<p>두번째 슬라이드 입니다.</p>
					</div>
					<img src="./img/slide.jpg">
				</a>
			</li>
			<li class="slideitem">
				<a>
					
					<div class="textbox">
						<h3>세번째 슬라이드</h3>
						<p>세번째 슬라이드 입니다.</p>
					</div>
					<img src="./img/slide.jpg">
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

	<div id="content">
    <section id="container">
	
	<div id="wrapper">
        <div class="box2">
		<p>s</p>
		</div>
        <div class="box3">
		
		</div>
		</div>
	<div id="free">
		자유게시판
		</div>
    </section>
	<aside id="aside">
	<aside class="welcome-wrapper">
    <h2></h2>
    <h2>환영합니다! <br><span id="nickname">[nickname]</span>님!</h2>
     <form method="post" action="logoutAction.jsp" id="login-form">
        <button class="logout-btn" id="logout-btn">로그아웃</button>
        </form>
         <form method="post" action="MyInfoChange.jsp" id="login-form">
        <button class="my-info-btn" id="my-info-btn">내 정보</button>
        </form>
		<div id="rank">
		거리 랭킹
		</div>
		<div id="kitpic">
		키트 그림
		</div>
		</aside>
		
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