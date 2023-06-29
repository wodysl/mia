<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String puuid = request.getParameter("puuid");

%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="../css/search/All.css">
  <script src="jquery-3.6.0.min.js"></script>
  <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>

<body>
  <div class="side">
    <ul class="navi">
      <li><a href="#" target="all">전체</a></li>
      <li><a href="#" target="all">솔로랭크</a></li>
      <li><a href="#" target="all">자유랭크</a></li>
    </ul>
  </div>
  <p>&nbsp;</p>
  <hr>
  <div>

  </div>
  <iframe src="./Both.jsp?puuid=<%= puuid %>" frameborder="0" width="100%" height="100%" name="all"></iframe>



</body>
<script type="text/javascript" src="../js/search/All.js"></script>

</html>