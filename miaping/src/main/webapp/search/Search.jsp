<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="../css/search/Search.css">
  <script src="jquery-3.6.0.min.js"></script>
  <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>

<!-- Main content -->
<main role="main">
  <a href="../Main.jsp"><h1>MIAPING</h1></a>
  <form action="./Search_act.jsp" method="post">
    <div class="search">
      <button type="submit">search</button>
      <input type="search" name="name" placeholder="">
    </div>
  </form>
</main><!-- @end main -->

</body>
<script type="text/javascript" src="../js/search/Search.js"></script>
</html>