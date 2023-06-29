<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <link rel="stylesheet" href="../css/member/Login.css">
  <link rel="stylesheet" href="../css/member/Member.css">
  <script src="jquery-3.6.0.min.js"></script>
</head>
<body>
  
  <div class="login-box">
    <h2>로그인</h2>
    <form id="frm" action="./Login_act.jsp" method="post">
      <div class="user-box">
        <input type="text" name="user_id" required="">
        <label>아이디</label>
      </div>
      <div class="user-box">
        <input type="password" name="pwd" required="">
        <label>비밀번호</label>
      </div>
      <button type="submit" id="aa">로그인</button>
      <button type="button" id="aa" class="aa2" onclick="location.href='./Sign.jsp'">회원가입</button>
    </form>
  </div>
</body>
<script type="text/javascript" src="../js/member/Login.js"></script>
<script type="text/javascript" src="../js/member/Member.js"></script>
</html>