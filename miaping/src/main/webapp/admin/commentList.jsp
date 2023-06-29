<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 댓글 관리</title>
</head>
<body>
    <h2>관리자 댓글 관리</h2>
    <table border="1">
        <tr>
            <th>댓글 ID</th>
            <th>댓글 내용</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>동작</th>
        </tr>

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

            String query = "SELECT * FROM comment";
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int comment_id = rs.getInt("comment_id");
                int board_id = rs.getInt("board_id");
                String user_id = rs.getString("user_id");
                String nickname = rs.getString("nickname");
                String content = rs.getString("content");
                Timestamp create_date = rs.getTimestamp("create_date");
        %>
            <tr>
                <td><%= comment_id %></td>
                <td><%= content %></td>
                <td><%= user_id %></td>
                <td><%= create_date %></td>
                <td>
                    <a href="commentDelete.jsp?comment_id=<%= comment_id %>">삭제</a>
                </td>
            </tr>
        <% 
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>
    </table>
</body>
</html>
