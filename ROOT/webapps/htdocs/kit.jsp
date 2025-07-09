<!doctype html>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>YJ Bike V</title>

<script>
  var countValue = 1;
  var pricePerItem = 50000;

  function count(action) {
    if (action === "plus") {
      if (countValue < 3) {
        countValue++; // 최대 개수를 3개로 제한
      }

	}else if (action === "minus") {
      countValue--;
      if (countValue < 1) {
        countValue = 1;
      }
    }

    updateDisplay();
  }

  function updateDisplay() {
    document.getElementById("counterDisplay").innerText = countValue + "개";
    document.getElementById("kitt33").innerText = countValue * pricePerItem + "원";
  }

  function redirectToLoginPage() {
    alert("로그인을 하셔야 이용할 수 있습니다.");
    // Redirect to the login page
    window.location.href = "kit.jsp"; // Replace "login.jsp" with the actual login page URL
  }

  function redirectToInquiryPage() {
    alert("로그인을 하셔야 이용할 수 있습니다.");
    // Redirect to the inquiry page
    window.location.href = "kit.jsp"; // Replace "inquiry.jsp" with the actual inquiry page URL
  }

  function redirectToTargetPage(url) {
    window.location.href = url + "?idx=1&count=" + countValue;
}

</script>
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

#nav > ul > a  { text-decoration : none; }
        div#wrap {

		 width: 1200px;
            margin: 0 auto;
            position: relative;

		}
        header#header {
		background:#none;
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
			height: 100%;
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

        div#wrap, header#header, nav#nav,
        section#container, div.content, aside#aside,


        nav#nav ul { margin:0 auto; padding:0; list-style:none; text-align: center; }
        nav#nav ul li {  padding:10px; display:inline-block; }
		nav#nav ul li a {display:inline-block;color:white;text-decoration:none;}
	div.content { width:60%; float:left; }
  div.login-wrapper{width:35%;float:right;}



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
  border: 3px solid black;
  border-radius: 10px 10px 10px 10px;
  margin-bottom:1px;
  font-size:1.1em;
  background-color:#fff;
}
#nav {
 border-radius: 10px 10px 10px 10px;
 border: 2px solid black;
 font-size:1.1em;

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
div#kitt{
 width : 945px;
  height: 400px;
  border: 3px solid black;
  border-radius: 10px 10px 10px 10px;
  background-color:#fff;

}
div#free{
 width : 945px;
  height: 980px;
  border: 3px solid black;
  margin-top:1px;
  margin-bottom:40px;
  border-radius: 10px 10px 10px 10px;
  background-color:#fff;
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
nav#nav ul li:hover {
    background-color:#A9A9F5; opacity: 0.9;
}
#kitt1 {
  width: 300px; height: 350px;float:left; margin:20px; border: 1px solid black;
  text-align:center;font-size: 15pt; border-radius: 10px 10px 10px 10px;
  
}
#kitt2 {
  width: 500px; height: 70px;float:right; margin-top:50px; margin-right:40px; border: 1px solid black;
  text-align:center; font-size: 15pt;  background-color:#F6F6F6; border-radius: 10px 10px 0px 0px;
}
#kitt3 {
  width: 500px; height: 70px;float:right; margin-top:1px; margin-right:40px; border: 1px solid black;
  text-align:center;  font-size: 15pt;background-color:#F6F6F6;
}
#kitt33 {
  float:right; margin-top:0px;
  text-align:center; font-size: 15pt;
}
#kitt34 {
  float:right; margin-top:0px;
  text-align:center; font-size: 15pt;
}
#kitt4 {
  width: 500px; height: 70px;float:right; margin-top:1px; margin-right:40px; border: 1px solid black;
  text-align:center; font-size: 15pt;background-color:#F6F6F6;position:relative; border-radius: 0px 0px 10px 10px;
}
#kitt5 {
  width: 180px; height: 40px;float:right; margin-top:30px; margin-right:70px; border: 1px solid black;
  text-align:center; font-size: 18pt; background-color:#D4F4FA;border-radius:10px;
}
#kitt6 {
  width: 180px; height: 40px;float:right; margin-top:30px; margin-right:50px; border:1px solid black;border-radius:10px;
  text-align:center; font-size: 18pt; background-color:#D4F4FA;
}
#nav ul > li > div:hover {background-color:#A9A9F5; opacity: 0.9;}

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
	 line-height:200%;
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
.free123{
  width:400px;
  height:280px;
  border:2px solid black;
  border-radius:10px 10px 10px 10px;
  margin-left:10px; margin-bottom:10px;
}
.free1234{
  width:500px;
  height:300px;
  float:right;
  text-align: left;
  margin-top:10px;
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
  <div id="snow"><%@include file="snow222.jsp"%></div>
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



	<div id="content">

    <section id="container">
	  <div id="feaf" style="font-size:1.2em;">상품 소개</div>

     <div id="kitt">
<div id="kitt1"><p>상품이미지
  <a href="kit.jsp">
				<img src="./img/1_1.png" style="width: 100%; height: 70%;  border-radius: 10px;">
			</a>
</div>
<div id="kitt2">상품이름<br>
  자전거 키트 세트
</div>
<div id="kitt3">가격 <br><div id="kitt33">50000원</div>
</div>
<div id="kitt4" >개수 선택<br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<input
      type="button"
      onclick='count("plus")'
      value='+'
    />
    <input
      type="button"
      onclick='count("minus")'
      value='-'
    />


   <div id="kitt34"><div id="counterDisplay">1개</div></div>


  </div>
<div id="kitt5" onclick='<%= (userID != null) ?  "window.location.href=\"Untitled-3.jsp\""  : "redirectToLoginPage()" %>'>
  문의하기
</div>

<div id="kitt6" onclick='<%= (userID !=null) ?  "redirectToTargetPage(\"BuyInfo.jsp\")"  : "redirectToLoginPage()" %>'>
  결제
</div>
		</div>

	<div id="free">
		<p>구성 상품 설명
		<p>(물량 문제로 1인당 3개씩 만 주문 가능합니다)</p>
	
    <div class="free1234">
	<p>1.아두이노 우노 R3 키트 세트</p>
    <p>아두이노 R3 키트 세트는 전자공학과 프로그래밍을 쉽게 시작할 수 있는 완벽한 키트입니다. 이 키트에 아두이노 R3 보드, 다양한 센서, 모터, 저항, LED, 브레드보드, 점퍼 와이어 등이 포함되어 있어 다양한 프로젝트와 실험을 진행할 수 있습니다. 초보자부터 전문가까지 모두 쉽게 사용할 수 있록 설계되어 있어, 창의적인 아이디어를 현실로 만들 수 있는 놀라운 경험을 선사합니다.</p>
    </div>
	
    <div class="free123">
	<img src="./adino.png" style="width: 100%; height: 70%;  border-radius: 10px;">
    </div>

    <div class="free1234">
	<p>2.아두이노 가변 저항</p>
   <p> 사용자 친화적인 조작 방식: 다이얼 타입 가변 저항은 회전식 노브를 돌려서 저항 값을 조절할 수 있으며, 이 과정은 간단하고 정확합니다. 또한, 최소 및 최대 저항 값 사이의 부드러운 변화를 선호하는 애플리케이션에 효율적으로 대응할 수 있습니다.</p>
    </div>

    <div class="free123">
<img src="./gaben.png" style="width: 100%; height: 70%;  border-radius: 10px;">
    </div>
    <div class="free1234">
	<p>3.아두이노용 리드 스위치</p>
      <p>아두이노용 리드 스위치는 미세한 자기장에 반응하는 간단하면서도 강력한 센서입니다. 이 스위치는 자기장이 가까이 올 때 접촉이 이루어져 전기적인 연결이 가능하며, 자기장이 멀어지면 접촉이 끊어져 연결이 끊긴 원리로 작동합니다. 주로 문이나 창문 개폐 감지, 비밀번호 잠금 시스템, 보안관련 프로젝트에 사용되며, 아두이노와 함께 사용되어 쉽게 자기장 대한 정보를 얻을 수 있습니다. 리드 스위치는 낮은 전력 소모, 긴 수명, 작은 크기 등의 장점을 가지며, 다양한 상황에 적용할 수 있는 안정적인 센서입니다.</p>
    </div>

    <div class="free123">
<img src="./jiro.png" style="width: 100%; height: 70%;  border-radius: 10px;">
    </div>

		</div>

	</section>
	 <%
    if(userID == null){
    	%>
	<aside id="aside">
	<aside class="login-wrapper">

    <h2>Login</h2>
    <form method="post" action="loginAction2.jsp" id="login-form">
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
       <form method="post" action="logoutAction2.jsp" id="login-form">
          <button class="logout-btn" id="logout-btn">로그아웃</button>
            </form>
             <form method="post" action="MyInfoChange.jsp" id="login-form">
              <button class="my-info-btn" id="my-info-btn">내 정보</button>
               </form>
			<div>
		&nbsp; 
	  </div>
	  	<div>
		&nbsp; 
	  </div>
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
</body>
</html>
