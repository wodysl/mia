<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Maria DB</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");
	String user_id = request.getParameter("user_id");
	String pwd = request.getParameter("pwd");
	String nickname = request.getParameter("nickname");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String grade = "1";
	
	out.println(user_id+pwd+nickname+name+email+grade);



	
	Connection con = null;
	PreparedStatement PS = null;
	ResultSet RS = null;
	
	try{
		//maraidb 정보입력 시작 
		String server = "172.16.100.32:3306";
		String username = "root";
		String db_pwd = "1234";
		String database = "mia";
		String url = "jdbc:mysql://" + server + "/" + database;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, username, db_pwd);
		
		String query = "insert into user(user_id, pwd, nickname, name, email, grade) ";
		query += "values (?,?,?,?,?,?)";
		
		PS = con.prepareStatement(query);
		PS.setString(1, user_id);
		PS.setString(2, pwd);
		PS.setString(3, nickname);
		PS.setString(4, name);
		PS.setString(5, email);
		PS.setString(6, grade);
		
		int result = 0;
		result = PS.executeUpdate();
		
		/* PS = con.prepareStatement(query);
		RS = PS.executeQuery(); */
		
		if(result == 0){
			%>
			<script>
			alert("가입에 실패하였습니다.");
			history.back();
			</script>
			<% 
		}
		else{
			%>
			<script>
			alert("가입에 성공하였습니다.");
			location.href = "./Login.jsp";
			</script>
			<%
		}
	}catch(Exception ErrMsg){
		ErrMsg.printStackTrace();
		out.println("Unfortunately, Database connection failed"+ErrMsg.getMessage());
		
	}

%>

</body>
</html>