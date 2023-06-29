<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="../css/member/Id.css">
  <link rel="stylesheet" href="../css/member/Member.css">
  <script src="jquery-3.6.0.min.js"></script>
</head>
<body>
  
  <div class="big"><form action="">
    <div class="imgBox">
      <img class="logoImg" src="../img/logo.png" alt="" id="logo">
    </div>

      <div class="small">

        <input type="text" onblur="this.placeholder='이름'" onfocus="this.placeholder='이름'" placeholder="이름" id="name"><br>

        <input type="email" onblur="this.placeholder='이메일'" onfocus="this.placeholder='이메일'" placeholder="이메일" id="email">
        <input type="submit" id="submitN" value="인증번호 받기"><br>

        <input type="number" id="inputN" placeholder="인증번호 6자리 숫자 입력" maxlength="6" oninput="maxLengthChk(this)">
        <input type="submit" id="check" value="인증하기">

        <br><br>

        <a href="Pwd.jsp">PASSWORD 찾기</a>
        <span id="nbsp">|</span>
        <a href="Login.jsp">로그인</a>

    </div>
  </form></div>
</body>
<script type="text/javascript" src="./Id.js"></script>
<script type="text/javascript" src="./Member.js"></script>
</html>