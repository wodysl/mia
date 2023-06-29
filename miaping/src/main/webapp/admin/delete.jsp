<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 삭제</title>
    <meta http-equiv="refresh" content="2;url=admin.jsp">
</head>
<body>
    <h2>회원 삭제</h2>

    <%-- 데이터베이스 연결 --%>
    <% 
    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // MariaDB 정보 입력
        String server = "172.16.100.32:3306";
        String username = "root";
        String password = "1234";
        String database = "mia";
        String url = "jdbc:mysql://" + server + "/" + database;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, password);
    %>

    <%-- 삭제할 회원 정보 수신 --%>
    <% 
        String user_id = request.getParameter("user_id");

        String deleteQuery = "DELETE FROM user WHERE user_id=?";
        pstmt = con.prepareStatement(deleteQuery);
        pstmt.setString(1, user_id);
        pstmt.executeUpdate();

        out.println("회원이 삭제되었습니다.");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    %>
</body>
</html>
