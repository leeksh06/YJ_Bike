<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<style>

.welcome-wrapper {
    width: 400px;
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
    width: 150px;
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
    <div class="welcome-wrapper">
        <h2>환영합니다! <br><span id="user-nickname">[User's Nickname]</span>님!</h2>
        <button class="logout-btn" id="logout-btn">로그아웃</button>
        <button class="my-info-btn" id="my-info-btn">내 정보</button>
    </div>
</body>

</html>
