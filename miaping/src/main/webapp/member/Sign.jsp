<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <link rel="stylesheet" href="../css/member/Login.css">
  <link rel="stylesheet" href="../css/member/Member.css">
  <script src="jquery-3.6.0.min.js"></script>
</head>
<body>
  
  <div class="login-box">
    <h2>회원가입</h2>
    <form id="frm" action="./Sign_act.jsp" method="post">
      <div class="user-box">
        <input type="text" id="user_id" name="user_id" required="">
        <label>아이디</label>
      </div>
      <div class="user-box">
        <input type="password" id="pwd" name="pwd" required="">
        <label>비밀번호</label>
      </div>
      <div class="user-box">
        <input type="password" id="pwd2" name="pwd2" required="">
        <label>비밀번호 확인</label>
      </div>
      <div class="user-box">
        <input type="text" id="name" name="name" required="">
        <label>이름</label>
      </div>
      <div class="user-box">
        <input type="text" id="nickname" name="nickname" required="">
        <label>닉네임</label>
      </div>
      <div class="user-box">
        <input type="email" id="email" name="email" required="">
        <label>이메일</label>
      </div>
      <button type="submit" id="aa">회원가입</button>
      <button type="button" id="aa" class="aa2" onclick="location.href='./Login.jsp'">로그인</button>
    </form>
  </div>
</body>
<script type="text/javascript" src="../js/member/Sign.js"></script>
<script type="text/javascript" src="../js/member/Member.js"></script>
</html>