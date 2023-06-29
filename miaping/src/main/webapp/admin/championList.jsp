<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>챔피언 관리자 페이지</title>
</head>
<body>
    <h2>챔피언 관리자 페이지</h2>

    <%-- 데이터베이스 연결 --%>
    <% 
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // MariaDB 정보 입력
        String server = "172.16.100.32:3306";
        String username = "root";
        String password = "1234";
        String database = "mia";
        String url = "jdbc:mysql://" + server + "/" + database;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, password);
        
        // 챔피언 목록 조회
        stmt = con.createStatement();
        String selectQuery = "SELECT * FROM champion";
        rs = stmt.executeQuery(selectQuery);
    %>

    <table>
        <tr>
            <th>번호</th>
            <th>챔피언 이름</th>
            <th>티어</th>
            <th>이미지</th>
            <th>승률</th>
            <th>밴률</th>
            <th>픽률</th>
            <th>삭제</th>
        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("ch_no") %></td>
            <td><%= rs.getString("ch_name") %></td>
            <td><%= rs.getInt("tier") %></td>
            <td><img src="./ch_img/<%= rs.getString("ch_img") %>" alt="<%= rs.getString("ch_name") %>"></td>
            <td><%= rs.getFloat("win") %></td>
            <td><%= rs.getFloat("ben") %></td>
            <td><%= rs.getFloat("pick") %></td>
            <td>
                <form action="championDelete.jsp" method="post">
                    <input type="hidden" name="ch_no" value="<%= rs.getInt("ch_no") %>">
                    <input type="submit" value="삭제">
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <br>
    <a href="championAdd.jsp">챔피언 추가</a>

    <% 
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (stmt != null) {
            try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    %>
</body>
</html>
