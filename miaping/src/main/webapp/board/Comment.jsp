<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String idd = (String)session.getAttribute("id");
	String nick = (String)session.getAttribute("nick");
	request.setCharacterEncoding("UTF-8");

	int id = Integer.parseInt(request.getParameter("id"));
	String comment = request.getParameter("comment");

Connection con = null;
PreparedStatement PS = null;
int RS = 0;

try{
	//maraidb 정보입력 시작 
	String server = "172.16.100.32:3306";
	String username = "root";
	String pwd = "1234";
	String database = "mia";
	String url = "jdbc:mysql://" + server + "/" + database;
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection(url, username, pwd);
	
	String query = "insert into comment(board_id,user_id,nickname,content) values(?,?,?,?)";
	
	PS = con.prepareStatement(query);
	PS.setInt(1, id);
	PS.setString(2, idd);
	PS.setString(3, nick);
	PS.setString(4, comment);
	
	RS = PS.executeUpdate();

	response.sendRedirect("Content.jsp?id="+id);
	
	}catch(Exception ErrMsg){
		ErrMsg.printStackTrace();
		out.println("Unfortunately, Database connection failed"+ErrMsg.getMessage());
		
	}
%>