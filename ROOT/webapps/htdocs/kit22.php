<!doctype html>
<html>
<head>
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
			height: 100%;
			text-align:left;
			float:left;
			padding:10px;



        }

        div.content {
			background:#fff;
	
		}
         aside#aside {
			
			  width: 0%;
			  height: 1500px;
			  float: right;
			  color: black;
			  text-align: center;
			  line-height: 50px;

		}
      footer#footer {

			position: fixed
			bottom:0;
			width:100%;
			height:70px;
			background:#102b6a;
			margin:auto;
			clear:both;
			 color: white;
		}

        div#warp, header#header, nav#nav,
        section#container, div.content, aside#aside,


        nav#nav ul { margin:0 auto; padding:0; list-style:none; text-align: center; }
        nav#nav ul li {  padding:10px; display:inline-block; }
	div.content { width:60%; float:left; }





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
div#kitt{
 width : 945px;
  height: 400px;
  border: 1px solid black;
}
div#free{
 width : 945px;
  height: 250px;
  border: 1px solid black;
}
nav#nav ul li:hover {
    background-color:#A9A9F5; opacity: 0.9;
}

</style>
</head>
<body>

<div id="wrap">
    <header id="header">
       <a href="test.html"> <img src="./logo.png" alt="Your Logo" /> </a>

    </header>
    <nav id="nav">
        <ul>
             <li>소개</li>
            <li>공지사항</li>
             <li>사용 방법</li>
			 <li>자유게시판</li>
			 <li>키트구매처</li>
        </ul>
    </nav>



	<div id="content">
    <section id="container">
	상품 소개

     <div id="kitt">


		</div>
	<div id="free">
		상품 설명
		</div>
		<section id="container">
	상품 소개2

     <div id="kitt">


		</div>
	<div id="free">
		상품 설명
		</div>
		<section id="container">
	상품 소개3

     <div id="kitt">


		</div>
	<div id="free">
		상품 설명
		</div>
		<section id="container">
	상품 소개4

     <div id="kitt">


		</div>
	<div id="free">
		상품 설명
		</div>
		<section id="container">
	상품 소개5
     <div id="kitt">


		</div>
	<div id="free">
		상품 설명
		</div>
		<section id="container">
	상품 소개6

     <div id="kitt">


		</div>
	<div id="free">
		상품 설명
		</div>
    </section>
	<aside id="aside">
	<aside class="login-wrapper">
    <h2>Login</h2>
     <form method="post" action="서버의url" id="login-form">
            <input type="text" name="userName" placeholder="Email">
            <input type="password" name="userPassword" placeholder="Password">
            <label for="remember-check">
                <input type="checkbox" id="remember-check">아이디 저장하기
            </label>
            <input type="submit" value="로그인">
			  <input type="submit" value="회원가입">
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
