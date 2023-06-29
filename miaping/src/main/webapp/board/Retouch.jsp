<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link rel="stylesheet" href="../css/board/Write.css">
<link rel="stylesheet" href="../css/board/Sidebar.css">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="jquery-3.6.0.min.js"></script>
<script>

function changeFile(){
	var fileName = $("#img").val().split('/').pop().split('\\').pop();
	  $(".upload-name").val(fileName);   
}

</script>
</head>
<body>
	<div class="container">
		<div class="left">
			<div class="login"><button class="lgbtn" onclick="location.href='#'">로그인</button></div>
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
		<div class="center">
		<div class="write_title">
			<h3>글쓰기</h3>
		</div>
<%
	int id = Integer.parseInt(request.getParameter("id"));

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
		String img = RS.getString("board_img");
		String gameid = RS.getString("game_id");
		String title = RS.getString("title");
		String content = RS.getString("contents");
		String category = RS.getString("category");
		
		if(category.equals("userf")){
%>
		<form action="Retouch_regi.jsp?id=<%= b_id %>" method="post" enctype="multipart/form-data">
				<div class="form">
					<div class="gameid" id="gameid">
						<input type="text" id="gameid" name="gameid" placeholder="소환사 아이디" value="<%= gameid %>">
					</div>
					<div class="title">
						<input type="text" id="title" name="title" placeholder="제목" value="<%= title %>" required>
					</div>
					<div class="content">
						<textarea id="content" name="content" required><%= content %></textarea>
					</div>
					<div class="submit">
						<input type="submit" class="subbtn" value="작성">
					</div>
					<div class="cancle">
						<input type="button" class="canbtn" value="취소" onClick="history.go(-1)">
					</div>
				</div>
			</form>
<%
		}else{
%>
			<form action="Retouch_regi.jsp?id=<%= b_id %>" method="post" enctype="multipart/form-data">
				<div class="form">
					<div class="title">
						<input type="text" id="title" name="title" placeholder="제목" value="<%= title %>" required>
					</div>
					<div class="content">
						<textarea id="content" name="content" required><%= content %></textarea>
					</div>
					<div class="file" id="imgfile">
						<input type="text" class="upload-name" id="img_name" name="img_name" value="<%= img %>" placeholder="첨부파일">
    					<label for="img">파일찾기</label> 
						<input type="file" id="img" name="img" accept="image/png, image/jpeg" onchange="changeFile()">
					</div>
					<div class="submit">
						<input type="submit" class="subbtn" value="작성">
					</div>
					<div class="cancle">
						<input type="button" class="canbtn" value="취소" onClick="history.go(-1)">
					</div>
				</div>
			</form>
<%
		
		}
	}
}catch(Exception ErrMsg){
	ErrMsg.printStackTrace();
	out.println("Unfortunately, Database connection failed"+ErrMsg.getMessage());
	
}

%>		
		</div>
	</div>
</body>
</html>