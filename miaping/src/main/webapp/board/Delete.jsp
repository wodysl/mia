<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	Connection con = null;
	PreparedStatement PS = null;
	String query = "";
	int id = 0;
	
	try{
		
		String server = "172.16.100.32:3306";
		String username = "root";
		String pwd = "1234";
		String database = "mia";
		String url = "jdbc:mysql://" + server + "/" + database;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, username, pwd);
		
	
	id = Integer.parseInt(request.getParameter("id"));

	query = "delete from board where board_id="+id;
	PS = con.prepareStatement(query);
	PS.execute();
	
%>
	<script>
	alert('게시글 삭제가 완료되었습니다.');
	location.href = "Newlist.jsp"
	</script>
<%
	}catch(Exception e){
		e.printStackTrace();
		out.println("Unfortunately, Database connection failed"+e.getMessage());
	}
%>