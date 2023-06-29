<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>MIA MAIN PAGE</title>
	<link rel="stylesheet" href="./css/Main.css">
</head>
<body>
	
  <a href="./search/Search.jsp">
    <span></span>
    <span></span>
    <span></span>
    <span></span>
    SEARCH
  </a>
  <% 
				String idd = (String)session.getAttribute("id");
				String nick = (String)session.getAttribute("nick");
				
				if(idd==null){
			%>
				<a href="./member/Login.jsp">
			      <span></span>
			      <span></span>
			      <span></span>
			      <span></span>
			      LOGIN
			    </a>
			<%
				}else{
			%>
				<a href="./member/Logout.jsp">
			      <span></span>
			      <span></span>
			      <span></span>
			      <span></span>
			      LOGOUT
			   </a>
			<%
				}
			%>
  
  <a href="./board/Newlist.jsp">
      <span></span>
      <span></span>
      <span></span>
      <span></span>
      COMMUNITY
  </a>
</body>
</html>