<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시물 삭제</title>
</head>
<body>
    <h2>게시물 삭제</h2>

    <%-- 데이터베이스 연결 --%>
    <% 
    Connection con = null;
    PreparedStatement PS = null;
	ResultSet RS = null;

    try {
    	// MariaDB 정보 입력
    	String server = "172.16.100.32:3306";
    	String username = "root";
    	String password = "1234";
    	String database = "mia";
    	String url = "jdbc:mysql://" + server + "/" + database;
    	Class.forName("com.mysql.jdbc.Driver");
    	con = DriverManager.getConnection(url, username, password);

        int boardId = Integer.parseInt(request.getParameter("boardId"));

        String query = "DELETE FROM board WHERE board_id=?";
        PS = con.prepareStatement(query);
        PS.setInt(1, boardId);
        PS.executeUpdate();

        out.println("게시물이 삭제되었습니다.");

        // 게시물 목록 페이지로 이동
        response.sendRedirect("adminBoardList.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (PS != null) {
            try { PS.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    %>
</body>
</html>
