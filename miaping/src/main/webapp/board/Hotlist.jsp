<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Paging.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인기게시판</title>
<link rel="stylesheet" href="../css/board/List.css">
<link rel="stylesheet" href="../css/board/Sidebar.css">
</head>
<body>
	<div class="container">
		<div class="left">
			<div class="login">
				<% 
				String idd = (String)session.getAttribute("id");
				String nick = (String)session.getAttribute("nick");
				
				if(idd==null){
			%>
				<button class="lgbtn" onclick="location.href='../member/Login.jsp'">로그인</button>
			<%
				}else{
			%>
				<button class="lgbtn" onclick="location.href='../member/Logout.jsp'">로그아웃</button>
			<%
				}
			%>
			</div>
			<div class="sidebar">
			<h3 class="lb">커뮤니티</h3>
				<ul>
					<li style="background-color: #a2a2a255;"><a href="Hotlist.jsp" style="color: #fff">인기</a></li>
					<li><a href="Newlist.jsp">최신</a></li>
					<li><a href="Freelist.jsp">자유</a></li>
					<li><a href="Humorlist.jsp">유머</a></li>
					<li><a href="Userlist.jsp">유저 찾기</a></li>
				</ul>
			</div>
		</div>
		<div class="center">
		<h1 class="title">인기게시판</h1>
		<button class="writebtn" onclick="location.href='Write.jsp'">글쓰기</button>
			<div class="list">
				<table class="tb">
				<thead>
					<th>번호</th>
					<th></th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
					<th>추천</th>
				</thead>
<%
	//Connection con = null;
	//PreparedStatement PS = null;
	//ResultSet RS = null;
	//String query = "";
	int list_count = 0;
	
	try{
		//maraidb 정보입력 시작 
		String server = "172.16.100.32:3306";
		String username = "root";
		String pwd = "1234";
		String database = "mia";
		String url = "jdbc:mysql://" + server + "/" + database;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, username, pwd);
		
		query = "select count(*) from board where good>50";
		PS = con.prepareStatement(query);
		RS = PS.executeQuery();
		
		while(RS.next()){
			list_count = RS.getInt(1);
		}
		
		query = "select board_id,board_img,title,nickname,create_date,view_cnt,good from board where good>50 order by board_id desc, board_id limit " + start + "," + len;
		PS = con.prepareStatement(query);
		RS = PS.executeQuery();
		
		list_count = list_count - len*(cPage-1);
		
		while(RS.next()){
			int b_id = RS.getInt("board_id");
			String img = RS.getString("board_img");
			String title = RS.getString("title");
			String nickname = RS.getString("nickname");
			String date = RS.getString("create_date");
			int view = RS.getInt("view_cnt");
			int good = RS.getInt("good");
			
			if(img==null){
				img = "./image/noImg.png";
			}else{
				img = "./uploadImg/" + java.net.URLEncoder.encode(img,"UTF-8");
			}
		%>
		
		<tr onclick="location.href='Content.jsp?id=<%= b_id %>&page=<%= cPage %>'">
			<td scope="row" class="bold"><%= list_count-- %></td>
			<td><img src="<%= img %>" class="thumbnail1" alt="최신글이미지" /></td>
			<td class="bold"><%= title %><span class="ment">[6]</span></td>
			<td><%= nickname %></td>
			<td><%= date %></td>
			<td><%= view %></td>
			<td><%= good %></td>
		</tr>
		<%
		
		}
	}catch(Exception ErrMsg){
		ErrMsg.printStackTrace();
		out.println("Unfortunately, Database connection failed"+ErrMsg.getMessage());
		
	}

%>
				</table>
			</div>
			<div class="footer page_wrap">
				<div class="page_nation">
				<% if(startPage == 1){ %>
					<a href="#" tabindex="-1" aria-disabled="true" class="arrow pprev"></a>
				<% }else { %>
					<a href="Hotlist.jsp?page=<%= startPage - 1 %>" tabindex="-1" aria-disabled="true" class="arrow pprev"></a>
				<% 
					}
					for(int i = startPage;i <= endPage; i++){
				%>
					<a href="Hotlist.jsp?page=<%= i %>" class="active"><%= i %></a>
				<% 
					}
					if(totalPages == endPage){ 
				%>
					<a href="#" class="arrow next"></a>
				<% }else { %>
					<a href="Hotlist.jsp?page=<%= endPage + 1 %>" class="arrow next"></a>
				<% } %>
				</div>
			</div>
		</div>
	</div>
</body>
</html>