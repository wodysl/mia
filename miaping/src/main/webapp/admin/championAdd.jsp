<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>챔피언 추가</title>
</head>
<body>
    <h2>챔피언 추가</h2>

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

    <%-- 챔피언 추가 폼 입력 처리 --%>
    <form action="championProcess.jsp" method="post" enctype="multipart/form-data">

        <label for="ch_name">챔피언 이름:</label>
        <input type="text" name="ch_name" required><br>
        <label for="tier">티어:</label>
        <input type="text" name="tier" required><br>
        <label for="ch_img">이미지 선택:</label>
        <input type="file" name="ch_img" required><br>
        <label for="win">승률:</label>
        <input type="text" name="win"><br>
        <label for="ben">밴률:</label>
        <input type="text" name="ben"><br>
        <label for="pick">픽률:</label>
        <input type="text" name="pick"><br>
        
        <input type="submit" value="챔피언 추가">
    </form>

    <% 
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
