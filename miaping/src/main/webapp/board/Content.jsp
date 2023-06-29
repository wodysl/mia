<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글</title>
<link rel="stylesheet" href="../css/board/Content.css">
<link rel="stylesheet" href="../css/board/Sidebar.css">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="jquery-3.6.0.min.js"></script>
<script>

</script>
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
					<li><a href="Hotlist.jsp">인기</a></li>
					<li><a href="Newlist.jsp">최신</a></li>
					<li><a href="Freelist.jsp">자유</a></li>
					<li><a href="Humorlist.jsp">유머</a></li>
					<li><a href="Userlist.jsp">유저 찾기</a></li>
				</ul>
			</div>
		</div>
<%	

	int id = Integer.parseInt(request.getParameter("id")); 
	int view = 0;
	int good = 0;
	
	Connection con = null;
	PreparedStatement PS = null;
	ResultSet RS = null;
	
	try{
		//maraidb 정보입력 시작 
		String server = "172.16.100.32:3306";
		String username = "root";
		String pwd = "1234";
		String database = "mia";
		String url = "jdbc:mysql://" + server + "/" + database;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, username, pwd);
		
		String query = "select * from board where board_id=" + id;
		PS = con.prepareStatement(query);
		RS = PS.executeQuery();
		
		
		while(RS.next()){
			int b_id = RS.getInt("board_id");
			String user_id = RS.getString("user_id");
			String img = RS.getString("board_img");
			String title = RS.getString("title");
			String content = RS.getString("contents");
			String nickname = RS.getString("nickname");
			String c_date = RS.getString("create_date");
			String u_date = RS.getString("update_date");
			String category = RS.getString("category");
			view = RS.getInt("view_cnt") + 1;
			good = RS.getInt("good");
			
			String date = "";
			String cate = "";
			
			if(u_date!=null){
				date = u_date;
			}else{
				date = c_date;
			}
			
			if(category.equals("free")){
				cate = "자유";
			}else if(category.equals("humor")){
				cate = "유머";
			}else if(category.equals("userf")){
				cate = "유저 찾기";
			}
		%>
		
		<div class="center">
			<div class="content_header">
				<h3><%= title %></h3>
				<span class="h_left">
					<span><%= cate %></span>
					<span><%= date %></span>
					<span><%= nickname %></span>
				</span>
				<span class="h_right">
					<span>조회 <%= view %></span>
					<span>댓글 6</span>
					<span>추천 <%= good %></span>
				</span>
				<br>
			<%
				
				if(user_id.equals(idd)){
			%>
				<span id="mine" class="h_right">
					<button class="btn" onclick="location.href='Retouch.jsp?id=<%= b_id %>'">수정</button>
					<button class="btn" onclick="location.href='Delete.jsp?id=<%= b_id %>'">삭제</button>
				</span>
			<%
				}
			%>
			</div>
			<div class="content_main">
			<%
				if(!(category.equals("userf"))){
					if(!(img==null)){
			%>
				<img src="./uploadImg/<%= img %>" class="img" alt="컨텐츠이미지" />
			<%		
					}
				}
			%>
				<label>
<pre>
<%= content %>
</pre>
				</label>
			</div>
			<% } %>
			<div class="content_footer">
				<div class="good">
					<button class="goodbtn">추천</button>
				</div>
			</div>
			<div class="comment">
				<h3>댓글</h3>
		<% 
			if(idd!=null){
		%>
				<form action="Comment.jsp?id=<%= id %>" method="post">
					<textarea type="text" id="comment" name="comment" ></textarea>
					<input type="submit" value="작성">
				</form>
		<%
			}
		
			query = "select * from comment where board_id=" + id;
			PS = con.prepareStatement(query);
			RS = PS.executeQuery();
			
			while(RS.next()){
				String nickname = RS.getString("nickname");
				String date = RS.getString("create_date");
				String content = RS.getString("content");
		%>
				<div class="showcomment">
					<span class="h_left"><span><%= nickname %></span><span><%= date %></span></span> 
					<div>
						<%= content %>
					</div>
				</div>
		<% 	
			}
		%>
				
			</div>	
		</div>
		<%
		
		query = "update board set view_cnt='" + view + "' where board_id=" + id;
		PS = con.prepareStatement(query);
		int result = PS.executeUpdate();
		
		
	}catch(Exception ErrMsg){
		ErrMsg.printStackTrace();
		out.println("Unfortunately, Database connection failed"+ErrMsg.getMessage());
		
	}

%>
		
	</div>
</body>
</html>