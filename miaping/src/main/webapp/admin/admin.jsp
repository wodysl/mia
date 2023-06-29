<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 목록</title>
</head>
<body>
    <h2>회원 목록</h2>
    <table border="1">
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>닉네임</th>
            <th>이메일</th>
            <th>등급</th>
            <th>가입일</th>
            <th>삭제</th>
        </tr>

        <%-- 데이터베이스 연결 --%>
        <% 
        Connection con = null;
        PreparedStatement pstmt = null;
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
        %>

        <%-- 회원 목록 조회 쿼리 실행 --%>
        <% 
        String query = "SELECT * FROM user";
        pstmt = con.prepareStatement(query);
        rs = pstmt.executeQuery();
        int count = 0;

        while (rs.next()) {
            String user_id = rs.getString("user_id");
            String name = rs.getString("name");
            String nickname = rs.getString("nickname");
            String email = rs.getString("email");
            int grade = rs.getInt("grade");
            Timestamp regdate = rs.getTimestamp("regdate");
        %>
            <tr>
                <td><%= user_id %></td>
                <td><%= name %></td>
                <td><%= nickname %></td>
                <td><%= email %></td>
                <td><%= grade %></td>
                <td><%= regdate %></td>
                <td><a href="delete.jsp?user_id=<%= user_id %>">삭제</a></td>
            </tr>
        <% 
            count++;
        }

        rs.close();
        pstmt.close();
        con.close();
        %>
    </table>

    <br>

    <%-- 회원 추가 버튼 --%>
    <form method="get" action="insert.jsp">
        <input type="submit" value="회원 추가">
    </form>

    <% 
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
</body>
</html>
