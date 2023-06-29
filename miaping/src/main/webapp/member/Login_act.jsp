<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login act</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");
	String user_id = request.getParameter("user_id");
	String pwd = request.getParameter("pwd");
	
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
		
		String query = "select * from user where user_id=? and pwd=?";

		PS = con.prepareStatement(query);
		PS.setString(1, user_id);
		PS.setString(2, pwd);
		RS = PS.executeQuery();
		
		int count = 0;
		while(RS.next()){
			String idd = RS.getString("user_id");
			String pwdd = RS.getString("pwd");
			String nick = RS.getString("nickname");
		%>
		<script>
			alert("로그인에 성공하였습니다.");
			location.href = "../Main.jsp"
		</script>
		<%
		session.setAttribute("id", idd);
		session.setAttribute("nick", nick);
		}
		
		%>
		<script>
			alert("로그인에 실패하였습니다.");
			history.back();
		</script>
		
		<%
	}catch(Exception ErrMsg){
		ErrMsg.printStackTrace();
		%>
		<script>
			alert("에러 발생 - 콘솔 확인");
			history.back();
		</script>
	
		<%
		System.out.println("Unfortunately, Database connection failed : "+ErrMsg.getMessage());
	}

%>

</body>
</html>