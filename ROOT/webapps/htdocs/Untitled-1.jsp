<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 폼</title>
   
    <!-- <link rel="stylesheet" href="./quiz07.css"> -->
    <style>
	header#header { 
		background:#fff; 
		text-align: center;
		justify-content: center;
		align-items: center;
		}
      .member {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  font-size: 20px; /* 폰트 크기를 키워줌 */
  padding: 30px; /* 내부 여백을 추가해줌 */
}
.field-wrap {
  width: 500px; /* 폭을 더 넓게 조정 */
  text-align: center;
  margin-bottom: 20px; /* 필드 간의 간격을 더 벌림 */
}
input[type="text"],
    input[type="password"],
    input[type="tel"] {
        width: 100%;
        padding: 10px;
        margin: 5px 0;
        box-sizing: border-box;
        border: 2px solid #ccc;
        border-radius: 4px;
        background-color: #f8f8f8;
        font-size: 16px;
    }
    .field {
        width: 300px;
      }
      input[type="submit"] {
  width: 300px;
  box-sizing: border-box;
  border-radius: 4px;
  background-color: #f8f8f8;
        font-size: 16px;
        padding: 10px;
        margin: 5px 0;
}

input[type="button"],input[type="number"] {
  width: 300px;
  box-sizing: border-box;
  border-radius: 4px;
  background-color: #f8f8f8;
        font-size: 16px;
        padding: 10px;
        margin: 5px 0;
}
.tel-number select {
  font-size: 20px;
  width: 300px;
  box-sizing: border-box;
  border-radius: 4px;
  background-color: #f8f8f8;

        padding: 10px;
        margin: 5px 0;
}
 
    </style>
</head>
<body>
     
    <div class="member">
        <!-- 1. 로고 -->
        <!-- <img class="logo" src="..png"> -->
 <a href="test.jsp"> <img src="./logo.png" alt="Your Logo" /> </a>
        <!-- 2. 필드 -->
        <form method="post" action="joinAction.jsp">
        
        <div class="field">
            <b>아이디</b>
            <span class="placehold-text"><input type="text" name="user_id"></span>
        </div>
        <div class="field">
            <b>비밀번호</b>
           <input type="password" name="password">
        </div>
        <div class="field">
            <b>비밀번호 재확인</b>
            <input type="password" name="password2">
        </div>
        <div class="field">
            <b>닉네임</b>
              <input type="text" name="nickname">
        </div>
			<div class="field">
            <b>주소</b>
            <span class="placehold-text"><input type="text" name="home_address"></span>
        </div>
    
        <div class="field tel-number">
            <b>휴대전화</b><br>
            <select>
                <option value="">대한민국 +82</option>
            </select>
            <div>
                <input type="text" name="phone_number" placeholder="전화번호 입력">
               
           
           
        <!-- 6. 가입하기 버튼 -->
        <input type="submit" value="가입하기">
        </form>
 <form id="registrationForm">
 <input type="submit" value="다시쓰기">
 </form>
 
<script>
        function resetForm() {
            document.getElementById("registrationForm").reset();
        }
    </script>

</body>
</html>