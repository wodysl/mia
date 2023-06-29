<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="../css/admin/AdminLogin.css">
</head>

<body>

  <body id="particles-js"></body>
  <div class="animated bounceInDown">
    <div class="container">
      <span class="error animated tada" id="msg"></span>
      <form name="form1" class="box" onsubmit="return checkStuff()">
        <h4>Admin<span>Login</span></h4>
        <h5>관리자 로그인</h5>
        <input type="text" name="id" placeholder="아이디" autocomplete="off">
        <i class="typcn typcn-eye" id="eye"></i>
        <input type="password" name="password" placeholder="비밀번호" id="pwd" autocomplete="off">
        <input type="submit" value="로그인" class="btn1">
      </form>
    </div>
  </div>
</body>
<script type="text/javascript" src="../js/admin/AdminLogin.js"></script>
</html>